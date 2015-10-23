//
//  SvImageInfoUtils.m
//  SvImgeInfo
//
//  Created by  maple on 6/19/13.
//  Copyright (c) 2013 maple. All rights reserved.
//


#import "SvImageInfoUtils.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface SvImageInfoUtils ()
{
    CGImageSourceRef _imageRef;
    NSDictionary     *_imageProperty;
}
@property(nonatomic,retain)NSURL *imageUrl;
@end

@implementation SvImageInfoUtils

#pragma mark - < init > -
+(SvImageInfoUtils *)share
{
    static SvImageInfoUtils *share = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        share = [[self alloc] init];
    });
    return share;
}

- (id)initWithURL:(NSURL*)imageUrl
{
    self = [super init];
    if (self) {
        _imageUrl = imageUrl;
        _imageRef = CGImageSourceCreateWithURL((CFURLRef)imageUrl, NULL);//图片如果经过压缩会获取不到信息
//        _imageRef = CGImageSourceCreateWithData((CFDataRef)imageData, NULL);//这个初始化方法获取的信息不全
        _imageProperty = (NSDictionary*)CGImageSourceCopyPropertiesAtIndex(_imageRef, 0, NULL);
        
        NSLog(@"image property: %@", _imageProperty);
    }
    
    return self;
}


- (void)dealloc
{
    if (_imageRef != NULL) {
        CFRelease(_imageRef);
    }
    
    [_imageProperty release];
    
    [super dealloc];
}

#pragma mark - < get info > -
- (NSInteger)fileSize
{
    CFDictionaryRef dict = CGImageSourceCopyProperties(_imageRef, NULL);
    CFNumberRef fileSize = (CFNumberRef)CFDictionaryGetValue(dict, kCGImagePropertyFileSize);
    
    CFNumberType type = CFNumberGetType(fileSize);
    
    int size = 0;
    if (type == kCFNumberSInt32Type) {
        CFNumberGetValue(fileSize, type, &size);
    }
    
    CFRelease(dict);
    
    return 0;
}

- (NSString*)fileType
{
    CFStringRef fileUTI = CGImageSourceGetType(_imageRef);
    NSLog(@"type Ref: %@", fileUTI);
    
    CFStringRef fileTypeDes = UTTypeCopyDescription(fileUTI);
    NSString *typeRef = (NSString*)fileTypeDes;
    [typeRef retain];
    
    CFRelease(fileTypeDes);
    return [typeRef autorelease];
}

- (int)colorDepth
{
    return [[_imageProperty valueForKey:(NSString*)kCGImagePropertyDepth] intValue];
}

- (NSString*)colorModel
{
    return [_imageProperty valueForKey:(NSString*)kCGImagePropertyColorModel];
}

- (UIImageOrientation)imageOrientation
{
    return [[_imageProperty valueForKey:(NSString*)kCGImagePropertyOrientation] intValue];
}

- (int)dpiWidth
{
    return [[_imageProperty valueForKey:(NSString*)kCGImagePropertyDPIWidth] intValue];
}

- (int)dpiHeight
{
    return [[_imageProperty valueForKey:(NSString*)kCGImagePropertyDPIHeight] intValue];
}

- (int)pixelWidth
{
    return [[_imageProperty valueForKey:(NSString*)kCGImagePropertyPixelWidth] intValue];
}

- (int)pixelHeight
{
    return [[_imageProperty valueForKey:(NSString*)kCGImagePropertyPixelHeight] intValue];
}

- (NSDictionary*)tiffDictonary
{    
    return [_imageProperty valueForKey:(NSString*)kCGImagePropertyTIFFDictionary];
}

- (NSDictionary*)exifDictionary
{
    return [_imageProperty objectForKey:(NSString*)kCGImagePropertyExifDictionary];
}

-(NSDictionary *)gpsDictionary
{
    return [_imageProperty objectForKey:(NSString *)kCGImagePropertyGPSDictionary];
}

-(NSDictionary *)imageProperty
{
    return _imageProperty;
}

#pragma mark - < action > -
#warning 内存泄露要处理
-(UIImage *)getZipImageWithSourceExif:(NSString *)imageName
{
    //获取压缩后图片的data
    NSString *urlStr = [_imageUrl absoluteString];
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"file://" withString:@""];
    UIImage *sourceImage = [UIImage imageWithContentsOfFile:urlStr];
    NSData *zipData = UIImageJPEGRepresentation(sourceImage, 0.5);
    
    //设置destinaion
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((CFDataRef)zipData, NULL);
    CFStringRef UTI = CGImageSourceGetType(imageSource);
    NSMutableData *newZipData = [NSMutableData data];
    CGImageDestinationRef destination = CGImageDestinationCreateWithData(((CFMutableDataRef)newZipData), UTI, 1, NULL);
    if(!destination){
        NSLog(@"***Could not create image destination ***");
    }
    
    //写入exif gps tiff
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[[self exifDictionary],[self gpsDictionary],[self tiffDictonary]]
                                                    forKeys:@[@"{Exif}",@"{GPS}",@"{TIFF}"]];
    CGImageDestinationAddImageFromSource(destination, imageSource, 0, (CFDictionaryRef)dic);
    
    BOOL success = CGImageDestinationFinalize(destination);
    if (!success) {
        NSLog(@"***Could not create data from image destination ***");
    }
    
    //保存图片
    NSArray *newZipPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *newZipPath=[newZipPaths[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",imageName]];
//    NSString *newZipPath = [NSString stringWithFormat:@"%@/Documents/%@.jpg",NSHomeDirectory(),imageName];
    
    NSFileManager *manager=[NSFileManager defaultManager];
    [manager createFileAtPath:newZipPath contents:newZipData attributes:nil];
    
    NSLog(@"\n%@\n%@\n",[newZipPath stringByDeletingLastPathComponent],newZipPath);
    
    UIImage *zipImage = [UIImage imageWithContentsOfFile:newZipPath];
    
    return zipImage;
}

@end
