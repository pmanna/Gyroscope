#import <UIKit/UIKit.h>

@class GyroscopeViewController;

@interface GyroscopeAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow				*window;
	GyroscopeViewController	*viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GyroscopeViewController *viewController;

@end

