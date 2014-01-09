//
//  ViewController.m
//  CA Tutorial
//
//  Created by Christopher Constable on 1/7/14.
//
//

#import "CustomView.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:[[UISlider alloc] init]];
    
    CustomView *customView = [[CustomView alloc] init];
    NSLog(@"%@ --- layer contents: %@", customView, customView.layer.contents);
    
    // Run examples here...
	[self example1];
}

#pragma mark - Examples

/**
 *  Example 1 - Adding a sublayer with color
 *
 *  Create a red CALayer.
 */
- (void)example1
{
    // Create a simple sublayer
    CALayer *newSublayer = [CALayer layer];
    newSublayer.frame = CGRectMake(20.0f, 100.0f, 280.0f, 280.0f);
    newSublayer.backgroundColor = [[UIColor redColor] CGColor];

    [self.view.layer addSublayer:newSublayer];
}

/**
 *  Example 2 - Adding a sublayer using an image
 *
 *  Create a CALayer using 'sampleImage1'.
 */
- (void)example2
{
    CALayer *newSublayer = [CALayer layer];
    newSublayer.frame = CGRectMake(20.0f, 100.0f, 280.0f, 280.0f);
    
    // Load sample image...
    UIImage *sampleImage = [UIImage imageNamed:@"sampleImage1.jpg"];
    
    // Get the underlying reference to the CGImage
    CGImageRef imageRef = [sampleImage CGImage];
    
    // Lastly, set the "contents" of the layer. Since CGImageRef
    // is not an Obj-C object, we have to "bridge" it into the
    // Obj-C object world.
    newSublayer.contents = (__bridge id)(imageRef);
    
    [self.view.layer addSublayer:newSublayer];
}

/**
 *  Example 3 - Manipulating the contentsGravity
 *
 *  Using 'sampleImage2', modify the contentsGravity.
 */
- (void)example3
{
    CALayer *newSublayer = [CALayer layer];
    newSublayer.frame = CGRectMake(20.0f, 100.0f, 280.0f, 280.0f);
    UIImage *sampleImage = [UIImage imageNamed:@"sampleImage2.jpg"];
    CGImageRef imageRef = [sampleImage CGImage];
    newSublayer.contents = (__bridge id)(imageRef);
    
    // The default is kCAGravityResize
    newSublayer.contentsGravity = kCAGravityCenter;
    
    [self.view.layer addSublayer:newSublayer];
}

/**
 *  Example 4 - Masking the layer
 *
 *  Render 'sampleImage2' into a layer that is too small for the
 *  image. Set the 'contentsGravity' to 'kCAGravityCenter' and 
 *  observe the results. Then, use 'masksToBounds' to clip the
 *  layer.
 */
- (void)example4
{
    CALayer *newSublayer = [CALayer layer];
    newSublayer.frame = CGRectMake(20.0f, 100.0f, 280.0f, 280.0f);
    UIImage *sampleImage = [UIImage imageNamed:@"sampleImage2.jpg"];
    CGImageRef imageRef = [sampleImage CGImage];
    newSublayer.contents = (__bridge id)(imageRef);
    newSublayer.contentsGravity = kCAGravityCenter;
    
    // Clip (or mask) any sublayers that have content
    // beyond the bounds of our layer.
    newSublayer.masksToBounds = YES;
    
    [self.view.layer addSublayer:newSublayer];
}

/**
 *  Example 5 - Scaling the content via contentsScale
 *
 *  Create two layers using 'sampleImage1'. Leave the 'contentScale
 *  of one layer at it's default value (1.0) and set the other
 *  to 2.0 (retina). Make sure the layers you create are the same
 *  size and the contentsGravity is kCAGravityCenter.
 */
- (void)example5
{
    UIImage *sampleImage = [UIImage imageNamed:@"sampleImage1.jpg"];
    CGImageRef imageRef = [sampleImage CGImage];
    
    // Default: 1.0 contentsScale
    CALayer *newSublayer1 = [CALayer layer];
    newSublayer1.frame = CGRectMake(10.0f, 50.0f, 300.0f, 300.0f);
    newSublayer1.contents = (__bridge id)(imageRef);
    newSublayer1.contentsGravity = kCAGravityCenter;
    newSublayer1.contentsScale = 1.0;
    [self.view.layer addSublayer:newSublayer1];
    
    // 2.0 contentsScale (retina)
    CALayer *newSublayer2 = [CALayer layer];
    newSublayer2.frame = CGRectMake(10.0f, 300.0f, 300.0f, 300.0f);
    newSublayer2.contents = (__bridge id)(imageRef);
    newSublayer2.contentsGravity = kCAGravityCenter;
    newSublayer2.contentsScale = 2.0;
    [self.view.layer addSublayer:newSublayer2];

    // We can also get the scale from the image:
    // sampleImage.scale
}

/**
 *  Example 6 - Using contentsRect to shape the content
 *
 *  Using 'sampleImage2', take random pieces of the image
 *  and display them in layers around the screen. Use 'contentsRect'
 *  to do this.
 */
- (void)example6
{
    UIImage *sampleImage = [UIImage imageNamed:@"sampleImage2.jpg"];
    CGImageRef imageRef = [sampleImage CGImage];
    
    CALayer *newSublayer1 = [CALayer layer];
    newSublayer1.frame = CGRectMake(20.0f, 20.0f, 95.0f, 95.0f);
    newSublayer1.contents = (__bridge id)(imageRef);
    newSublayer1.masksToBounds = YES;
    
    // drand48() returns a random value between 0.0 and 1.0
    srand48(time(0)); // sets up the random number generator
    newSublayer1.contentsRect = CGRectMake(drand48(), drand48(), drand48(), drand48());
    
    [self.view.layer addSublayer:newSublayer1];
    
    CALayer *newSublayer2 = [CALayer layer];
    newSublayer2.frame = CGRectMake(205.0f, 20.0f, 95.0f, 95.0f);
    newSublayer2.contents = (__bridge id)(imageRef);
    newSublayer2.masksToBounds = YES;
    newSublayer2.contentsRect = CGRectMake(drand48(), drand48(), drand48(), drand48());
    [self.view.layer addSublayer:newSublayer2];
    
    CALayer *newSublayer3 = [CALayer layer];
    newSublayer3.frame = CGRectMake(20.0f, 140.0f, 280.0f, 280.0f);
    newSublayer3.contents = (__bridge id)(imageRef);
    newSublayer3.masksToBounds = YES;
    newSublayer3.contentsRect = CGRectMake(drand48(), drand48(), drand48(), drand48());
    [self.view.layer addSublayer:newSublayer3];
}

/**
 *  Example 7 - Using contentsCenter
 *
 *  Using 'sampleImage1', create a CALayer and set a random square
 *  contentsCenter. Then increase the contentsScale of the layer
 *  to artificially stretch the backing image. Try changing the frame
 *  of the layer to see how the stretching occurs.
 */
- (void)example7
{
    UIImage *sampleImage = [UIImage imageNamed:@"sampleImage1.jpg"];
    CGImageRef imageRef = [sampleImage CGImage];
    
    CALayer *newSublayer = [CALayer layer];
    newSublayer.frame = CGRectMake(20.0f, 60.0f, 280.0f, 280.0f);
    newSublayer.contents = (__bridge id)(imageRef);
    
    // Modify the contentsCenter
    srand48(time(0));
    double randomDouble = drand48();
    randomDouble = fabs(randomDouble - 0.5); // Make sure the number is between 0.0 and 0.5
    newSublayer.contentsCenter = CGRectMake(randomDouble,
                                            randomDouble,
                                            1.0 - (2 * randomDouble),
                                            1.0 - (2 *randomDouble));
    NSLog(@"contentsCenter: %@", NSStringFromCGRect(newSublayer.contentsCenter));
    
    // Make the contentsScale large so the image stretches
    newSublayer.contentsScale = 8.0;
    
    [self.view.layer addSublayer:newSublayer];
}

@end
