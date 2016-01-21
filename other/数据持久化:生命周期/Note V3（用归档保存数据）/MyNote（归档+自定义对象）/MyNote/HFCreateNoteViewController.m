//
//  HFCreateNoteViewController.m
//  MyNote
//
//  Created by hanyfeng on 14-5-13.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFCreateNoteViewController.h"
#import "NoteBL.h"
#import "Note.h"
@interface HFCreateNoteViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation HFCreateNoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)finish:(id)sender
{
    Note *note = [[Note alloc] init];
    note.content = self.textView.text;
    note.date = [NSDate date];
    
    NoteBL *noteBL = [[NoteBL alloc] init];
    [noteBL createNote:note];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshNoteData" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
