//
//  SKViewController.m
//  ThubnailTest
//
//  Created by shrek wang on 4/9/15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import "SKViewController.h"

#import "NIImageProcessing.h"

#import "SKThumbnailViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>

NSString *segueThumbnailVC = @"ThumbnailVC";

@interface SKViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) UIImage *thumbnail;
@property (copy, nonatomic) NSString *thumbnailTitle;

@property (weak, nonatomic) IBOutlet UISegmentedControl *qualitySegmentControl;
@end

@implementation SKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.imageView.image = image;
    self.image = image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    CGSize imageSize = self.image.size;
    NSString *imageTitle = @"";
    CGRect rectForThubnail = CGRectZero;
    UIImage *thumbnail = nil;
    
    switch (indexPath.row) {
        case 0: {
            thumbnail = [NIImageProcessing imageFromSource:self.image
                                                withContentMode:UIViewContentModeScaleAspectFit
                                                       cropRect:CGRectZero
                                                    displaySize:CGSizeMake(100, 100)
                                                   scaleOptions:NIImageViewScaleToFitCropsExcess
                                           interpolationQuality:[self currentQuality]];
            rectForThubnail = [NIImageProcessing scaledRectForImageSize:imageSize
                                                            displaySize:CGSizeMake(100, 100)
                                                            contentMode:UIViewContentModeScaleAspectFit
                                                           scaleOptions:NIImageViewScaleToFitCropsExcess];
            imageTitle = @"thunbmail-fit";
            
        } break;
        case 1: {
            thumbnail = [NIImageProcessing imageFromSource:self.image
                                                    withContentMode:UIViewContentModeScaleAspectFill
                                                           cropRect:CGRectZero
                                                        displaySize:CGSizeMake(100, 100)
                                                       scaleOptions:NIImageViewScaleToFitCropsExcess
                                               interpolationQuality:[self currentQuality]];
            rectForThubnail = [NIImageProcessing scaledRectForImageSize:imageSize
                                                            displaySize:CGSizeMake(100, 100)
                                                            contentMode:UIViewContentModeScaleAspectFill
                                                           scaleOptions:NIImageViewScaleToFitCropsExcess];
            imageTitle = @"thunbmail-fill";
        } break;
        default: break;
    }
    
    CGSize thumbnailSize = thumbnail.size;
    if (CGSizeEqualToSize(rectForThubnail.size, thumbnailSize)) {
        NSLog(@"equal size");
    }
    
    self.thumbnail = thumbnail;
    self.thumbnailTitle = [NSString stringWithFormat:@"%@-%@.jpg", imageTitle, [self.qualitySegmentControl titleForSegmentAtIndex:self.qualitySegmentControl.selectedSegmentIndex]];
    [self performSegueWithIdentifier:segueThumbnailVC sender:self];
}

- (CGInterpolationQuality)currentQuality
{
    CGInterpolationQuality quaility = kCGInterpolationDefault;
    
    switch (self.qualitySegmentControl.selectedSegmentIndex) {
        case 0: {
            quaility = kCGInterpolationDefault;
        } break;
        case 1: {
            quaility = kCGInterpolationLow;
        } break;
        case 2: {
            quaility = kCGInterpolationMedium;
        } break;
        case 3: {
            quaility = kCGInterpolationHigh;
        } break;
        default: break;
    }
    
    return quaility;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:segueThumbnailVC]) {
        SKThumbnailViewController *destVC = segue.destinationViewController;
        destVC.image = self.thumbnail;
        destVC.imageTitle = self.thumbnailTitle;
    }
}

@end
