#import "AssetsViewController.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

@interface AssetsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property  (nonatomic, strong)  UITableView *tableView;
@property  (nonatomic, strong)  ALAssetsLibrary *assetsLibrary;
@property  (nonatomic, strong)  NSMutableArray *imageGroup;
@end

@implementation AssetsViewController

- (ALAssetsLibrary *)assetsLibrary
{
  if (!_assetsLibrary) {
    _assetsLibrary = [[ALAssetsLibrary alloc] init];
  }
  return _assetsLibrary;
}

- (NSMutableArray *)imageGroup
{
  if (!_imageGroup) {
    _imageGroup = [[NSMutableArray alloc] initWithCapacity:0];
  }
  return _imageGroup;
}




- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  [self.imageGroup removeAllObjects];
  
  UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
  [self.view addSubview:tableView];
  tableView.delegate = self;
  tableView.dataSource = self;
  
  ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
    ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
    [group setAssetsFilter:onlyPhotosFilter];
    if ([group numberOfAssets] > 0)
    {
      [self.imageGroup addObject:group];
    }
    else
    {
      [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
  };
  
  NSUInteger groupTypes = ALAssetsGroupAll ;
  
  [self.assetsLibrary enumerateGroupsWithTypes:groupTypes usingBlock:listGroupBlock failureBlock:^(NSError *error) {
    NSLog(@"Group not found!\n");
  }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.imageGroup.count;
}

-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellName = @"name";
  UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellName];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
  }
  
  ALAssetsGroup *group = [self.imageGroup objectAtIndex:indexPath.row];
  UIImage *postImage = [UIImage imageWithCGImage:[group posterImage]];
  
  cell.imageView.image =  postImage;
  cell.textLabel.text = [group valueForProperty:ALAssetsGroupPropertyName];;
  cell.detailTextLabel.text = [@(group.numberOfAssets) stringValue];
  return cell;
}
@end