#import "GyroscopeViewController.h"

@implementation GyroscopeViewController

@synthesize image, toleranceField;

- (void)updateImage: (NSNumber *)rotNum
{
    self.image.transform = CGAffineTransformMakeRotation([rotNum floatValue]);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing: YES];
    
    return NO;
}

-(IBAction)toggleUpdates:(id)sender {
    if (motionManager.isGyroAvailable) {
        if ([sender isOn]) {
            lastTimeStamp   = 0.0;
            [motionManager startGyroUpdatesToQueue: gyroQueue
                                       withHandler: ^(CMGyroData *gyroData, NSError *error) {
                                    double   rate    = gyroData.rotationRate.z;
                                   
                                    if (lastTimeStamp > 0.0) {
                                        if (fabs(rate) >= tolerance) {
                                            rotation += rate * (gyroData.timestamp - lastTimeStamp);
                                            
                                            [self performSelectorOnMainThread: @selector(updateImage:)
                                                                   withObject: [NSNumber numberWithDouble: rotation]
                                                                waitUntilDone: NO];
                                       }
                                    }
//                                  NSLog(@"Gyro at: %.5f\tLast: %.5f", gyroData.timestamp, lastTimeStamp);
                                    lastTimeStamp   = gyroData.timestamp;
                                }];
        } else {
            [motionManager stopGyroUpdates];
            rotation    = 0.0;
            [self performSelector: @selector(updateImage:)
                       withObject:[NSNumber numberWithDouble: rotation]
                       afterDelay: 0.5];
        }
    }
}

-(IBAction)changeTolerance:(id)sender
{
    tolerance   = fabs([toleranceField.text doubleValue]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tolerance           = 0.01;
    toleranceField.text = [NSString stringWithFormat: @"%.4f", tolerance];
    
	motionManager       = [[CMMotionManager alloc] init];
    gyroQueue           = [[NSOperationQueue alloc] init];
    
    if (motionManager.isGyroAvailable) {
        motionManager.gyroUpdateInterval    = 1 / 60.0;
    }
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[motionManager release];
    [gyroQueue release];
}


- (void)dealloc {
	self.image          = nil;
    self.toleranceField = nil;
    
    [super dealloc];
}

@end
