#import <UIKit/UIKit.h>

@interface GreekLettersAppDelegate : NSObject <UIApplicationDelegate>
{
@private
    UIWindow *window;
    UIViewController *gameViewController;
    UIViewController *cheatSheetViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UIViewController *gameViewController;
@property (nonatomic, retain) UIViewController *cheatSheetViewController;

- (IBAction)showGameView;
- (IBAction)showCheatSheetView;

@end
