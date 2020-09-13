#import "NSTask.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SBIconController : UIViewController
- (void)executeCmd;
@end

BOOL timerAdded = NO;
NSDictionary *cmdlPrefsDict;

%hook SBIconController
- (void)viewDidLoad {
    %orig;

    NSLog(@"cmdLooper: helo_world!");
    cmdlPrefsDict = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/dev.quiprr.cmdlooper.plist"];
    BOOL shouldEnablecmdLooper = [[cmdlPrefsDict objectForKey:@"enableTweak"] boolValue];
    NSNumber *timerDelay = [cmdlPrefsDict objectForKey:@"timerDelay"];
    double putIntoNSTimer = [timerDelay doubleValue];
    NSLog(@"cmdLooper: putIntoNSTimer: %@", putIntoNSTimer);
    NSLog(@"cmdLooper: shouldEnablecmdLooper: %@", shouldEnablecmdLooper);

    if (shouldEnablecmdLooper) {
        if (!timerAdded) {
            timerAdded = YES;
            NSLog(@"cmdLooper: timer started");
            [NSTimer scheduledTimerWithTimeInterval:putIntoNSTimer target:self selector:@selector(executeCmd) userInfo:nil repeats:YES];
        }
    }
}

%new

- (void)executeCmd {

    NSLog(@"cmdLooper: executeCmd called!!!!");
    NSString *command = [cmdlPrefsDict objectForKey:@"command"];
    NSLog (@"cmdlooper: command: %@", command);
    NSTask *runCommand = [[NSTask alloc] init];
    runCommand.launchPath = command;
    [runCommand launch];

}
%end
