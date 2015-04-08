//
//  SKThumbnailViewController.m
//  ThubnailTest
//
//  Created by shrek wang on 4/9/15.
//  Copyright (c) 2015 shrek wang. All rights reserved.
//

#import "SKThumbnailViewController.h"

@interface SKThumbnailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthHeightAspectRatioConstraint;
@end

@implementation SKThumbnailViewController

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
    // Do any additional setup after loading the view.
    
    self.imageView.image = self.image;
    
    CGSize size = self.image.size;
    self.widthHeightAspectRatioConstraint.constant = size.width / size.height;
    
    UIBarButtonItem *rightItem = self.navigationItem.rightBarButtonItem;
    rightItem.target = self;
    rightItem.action = @selector(saveImage);
    
    self.title = self.imageTitle;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveImage
{
    NSData *data = UIImageJPEGRepresentation(self.image, 1.0);
    NSString *path = [NSString pathWithComponents:@[
                                                    NSHomeDirectory(),
                                                    @"Documents",
                                                    self.imageTitle
                                                    ]];
    [data writeToFile:path atomically:YES];
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
