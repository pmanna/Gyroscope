#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface GyroscopeViewController : UIViewController <UITextFieldDelegate>
{
	NSOperationQueue    *gyroQueue;
	CMMotionManager     *motionManager;
	double              rotation;
	double              tolerance;
    double              calibrationTime;
	NSTimeInterval      lastTimeStamp;
}

@property(nonatomic, retain) IBOutlet UIImageView   *image;
@property(nonatomic, retain) IBOutlet UITextField   *toleranceField;
@property(nonatomic, retain) IBOutlet UITextField   *calibrationField;
@property(nonatomic, retain) IBOutlet UISwitch      *gyroToggle;
@property(nonatomic, retain) IBOutlet UISwitch      *motionToggle;

-(IBAction)toggleGyroUpdates:(id)sender;
-(IBAction)toggleMotionUpdates:(id)sender;
-(IBAction)changeTolerance:(id)sender;
-(IBAction)changeCalibration:(id)sender;

@end

