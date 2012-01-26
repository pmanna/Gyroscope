#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface GyroscopeViewController : UIViewController <UITextFieldDelegate>
{
	NSOperationQueue    *gyroQueue;
	CMMotionManager     *motionManager;
	double              rotation;
	double              tolerance;
	NSTimeInterval      lastTimeStamp;
}

@property(nonatomic, retain) IBOutlet UIImageView *image;
@property(nonatomic, retain) IBOutlet UITextField *toleranceField;

-(IBAction)toggleUpdates:(id)sender;
-(IBAction)changeTolerance:(id)sender;

@end

