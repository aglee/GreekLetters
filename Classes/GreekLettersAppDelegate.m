#import "GreekLettersAppDelegate.h"

#import "GameViewController.h"
#import "CheatSheetViewController.h"


// The status bar is hidden using the UIStatusBarHidden entry in Info.plist.
// The window is set up in the MainWindow nib file.


@implementation GreekLettersAppDelegate

//-------------------------------------------------------------------------
// Init/awake/dealloc
//-------------------------------------------------------------------------

- (void)dealloc
{
    [gameViewController release];
    [window release];

    [super dealloc];
}

//-------------------------------------------------------------------------
// Accessors
//-------------------------------------------------------------------------

@synthesize window;
@synthesize gameViewController;
@synthesize cheatSheetViewController;

//-------------------------------------------------------------------------
// Action methods
//-------------------------------------------------------------------------

- (IBAction)showGameView
{
    NSLog(@"showGameView");
}

- (IBAction)showCheatSheetView
{
    NSLog(@"showGameView");
}

//-------------------------------------------------------------------------
// UIApplication delegate methods
//-------------------------------------------------------------------------

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    // Set up a view controller to manage the GameView.
    GameViewController *aViewController =
        [[GameViewController alloc]
            initWithNibName:@"GameView" bundle:[NSBundle mainBundle]];
    self.gameViewController = aViewController;
    [aViewController release];

    // Set up a view controller to manage the GameView.
    aViewController =
    [[CheatSheetViewController alloc]
     initWithNibName:@"CheatSheetView" bundle:[NSBundle mainBundle]];
    self.cheatSheetViewController = aViewController;
    [aViewController release];
    
    // Add the GameView to the application window.
    UIView *gameView = [gameViewController view];
    [window addSubview:gameView];
    [window makeKeyAndVisible];
}

@end
