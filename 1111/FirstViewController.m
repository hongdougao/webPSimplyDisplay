//
//  FirstViewController.m
//  1111
//
//  Created by yangyue on 15/11/18.
//  Copyright © 2015年 com.yintai.iphone. All rights reserved.
//
#import "UIImage+WebP.h"

#import "FirstViewController.h"

@interface FirstViewController ()
{
    WebPDecoderConfig config;
    UIImageView *testImageView;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//       self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:255.0/255.0 green:124.0/255.0 blue:56.0/255.0 alpha:1];
    
    for (UITabBarItem *item in self.tabBarController.tabBar.items) {
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
 
    NSString *imagePath   =  [[NSBundle mainBundle] pathForResource:@"Rosetta" ofType:@"webp"];

    
    testImageView =   [[UIImageView  alloc]initWithFrame:CGRectMake(80, 80, 100, 100)];
    testImageView.layer.masksToBounds = YES;
     testImageView.layer.borderWidth = 1.5;
     testImageView.layer.borderColor  = [UIColor yellowColor].CGColor;
    
    
    
    [self displayImage:imagePath];
    [self.view addSubview:testImageView];
    testImageView.frame = CGRectMake(80, 80, 150, 150);
    [testImageView setBackgroundColor:[UIColor yellowColor]];
}
#pragma mark - WebP example

/*
 This gets called when the UIImage gets collected and frees the underlying image.
 */
static void free_image_data(void *info, const void *data, size_t size)
{
    if(info != NULL)
    { \
        WebPFreeDecBuffer(&(((WebPDecoderConfig *)info)->output));
    }
    else
    {
        free((void *)data);
    }
}
- (void)displayImage:(NSString *)filePath
{
    NSLog(@"* * * * * * * * * * *");
    
    NSDate *startTime = [NSDate date];
    
    // Find the path of the selected WebP image in the bundle and read it into memory
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    
    NSLog(@"Time to read data: %0.2fms", [startTime timeIntervalSinceNow] * -1000.0);
    
    // Get the current version of the WebP decoder
    int rc = WebPGetDecoderVersion();
    
    NSLog(@"Version: %d", rc);
    
    startTime = [NSDate date];
    
    // Get the width and height of the selected WebP image
    int width = 0;
    int height = 0;
    WebPGetInfo([myData bytes], [myData length], &width, &height);
    
    NSLog(@"Time to read info: %0.2fms", [startTime timeIntervalSinceNow] * -1000.0);
    
    NSLog(@"Image Width: %d Image Height: %d", width, height);
    
    CGDataProviderRef provider;
    
//    if(_bypassFilteringSwitch.on || _noFancyUpsamplingSwitch.on || _useThreadsSwitch.on )
//    {
//        WebPInitDecoderConfig(&config);
//        
//        config.options.no_fancy_upsampling = _noFancyUpsamplingSwitch.on ? 1 : 0;
//        config.options.bypass_filtering = _bypassFilteringSwitch.on ? 1 : 0;
//        config.options.use_threads = _useThreadsSwitch.on ? 1 : 0;
//        config.output.colorspace = MODE_RGBA;
//        
//        NSLog(@"Settings: no_fancy_upsampling=%d, bypass_filtering=%d, use_threads=%d", config.options.no_fancy_upsampling, config.options.bypass_filtering, config.options.use_threads);
//        
//        startTime = [NSDate date];
//        
//        // Decode the WebP image data into a RGBA value array
//        WebPDecode([myData bytes], [myData length], &config);
//        
//        NSLog(@"Time to decode WebP data: %0.2fms", [startTime timeIntervalSinceNow] * -1000.0);
//        
//        startTime = [NSDate date];
//        
//        // Construct a UIImage from the decoded RGBA value array
//        provider = CGDataProviderCreateWithData(&config, config.output.u.RGBA.rgba, width*height*4, free_image_data);
//    }
//    else
//    {
        startTime = [NSDate date];
        
        // Decode the WebP image data into a RGBA value array
        uint8_t *data = WebPDecodeRGBA([myData bytes], [myData length], &width, &height);
        
        NSLog(@"Time to decode WebP data: %0.2fms", [startTime timeIntervalSinceNow] * -1000.0);
        
        startTime = [NSDate date];
        
        // Construct a UIImage from the decoded RGBA value array
        provider = CGDataProviderCreateWithData(NULL, data, width*height*4, free_image_data);
//    }
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    CGImageRef imageRef = CGImageCreate(width, height, 8, 32, 4*width, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    
    NSLog(@"Time to contruct UIImage from RGBA: %0.2fms", [startTime timeIntervalSinceNow] * -1000.0);
    
    // Set the image into the image view and make image view and the scroll view to the correct size
    testImageView.frame = CGRectMake(0, 0, width, height);
    testImageView.image = newImage;
    
    
    CGImageRelease(imageRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGDataProviderRelease(provider);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
