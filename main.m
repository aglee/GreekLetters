#import <UIKit/UIKit.h>

int main(int argc, char *argv[])
{
    srand(time(NULL));

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
