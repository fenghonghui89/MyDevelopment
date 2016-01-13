//
//  HFChangeNoteViewController.m
//  MyNote
//
//  Created by hanyfeng on 14-5-13.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFChangeNoteViewController.h"

@interface HFChangeNoteViewController ()
@property(nonatomic,strong)NoteBL *noteBL;
@property(nonatomic,strong)Note *note;
@end

@implementation HFChangeNoteViewController

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
    self.noteBL = [[NoteBL alloc] init];
    self.noteData = [self.noteBL allNote];
    self.note = [self.noteData objectAtIndex:self.noteDataIndex];
    self.textView.text = self.note.content;

}
- (IBAction)cancleChangeNote:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)finishChangeNote:(id)sender
{
    self.note.content = self.textView.text;
    [self.noteBL changeNote:self.note];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshNoteData" object:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
