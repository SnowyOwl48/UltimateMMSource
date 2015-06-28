//
//  UCAppDelegate.m
//  GDT Legend
//
//  Created by Joshua Kac on 1/13/14.
//  Copyright (c) 2014 UnivereseCrafters. All rights reserved.
//

#import "UCAppDelegate.h"
#import <Webkit/WebKit.h>
#import <Security/Security.h>


@interface UCAppDelegate ()
@end

@implementation UCAppDelegate

#pragma mark Application Start
/*-(BOOL)application:(NSApplication *)sender openFile:(NSString *)filename
{
    NSLog(@"Loading a file if any");
    NSError *error = nil;
    NSURL* URL;
    NSString *searchFilename = filename;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath:documentsDirectory];
    
    NSString *documentsSubpath;
    while (documentsSubpath = [direnum nextObject])
    {
        if (![documentsSubpath.lastPathComponent isEqual:searchFilename]) {
            continue;
        }
        
        NSLog(@"found %@", documentsSubpath);
    }
    [URL URLByAppendingPathComponent:documentsSubpath];
    NSLog(@"%@", URL);
    NSLog(@"Reading files");
    NSString *fileContents = [NSString stringWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"File Contents: %@", fileContents);
    self.CS.string = @"";
    self.LoadString = [NSMutableString string];
    self.ModText = [NSMutableString string];
    [self.CS insertText:fileContents];
    [self.LoadString appendString:fileContents];
    _TTT = true;
    _SSS = true;
    NSLog(@"Clear Topic and Added Save Values to Topic.");
    return [self fileExists];
}*/

- (NSString*)applicationSupportPath
{
    return [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,NSUserDomainMask, YES) firstObject];
}
- (NSString*)appPath
{
    return [NSSearchPathForDirectoriesInDomains(NSApplicationDirectory,NSUserDomainMask, YES) firstObject];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.CS.string = @"";
    //self.CS.string = [NSString stringWithFormat:@"var %@ = {};\n(function () {\n})();", [self.ModName stringValue]];

	NSError* error = nil;
	NSString* applicationSupportDirectory = [self applicationSupportPath];
	NSString *directoryToMove = [NSString stringWithFormat:@"%@/UltimateMM", applicationSupportDirectory ];
    NSString *filePathToMoveSettings = [directoryToMove stringByAppendingPathComponent:@"settings.settings"];
    
    self.ModName.stringValue = @"UltimateModMakerMod";
    self.SettingsValues = [NSMutableString string];
    self.StuffValues = [NSMutableString string];
    self.CSToMove = [NSMutableString string];
    self.ModText = [NSMutableString string];
    self.package = [NSMutableString string];
    self.js = [NSMutableString string];
    self.SettingsContent = [NSMutableString string];
    
    if ([self.Version isEqual:@"Alpha 9.1"]) {
        self.VersionL1.stringValue = @"Alpha 9.1";
        self.VersionL2.stringValue = @"Alpha 9.1";
        self.whatsNew.stringValue = @"Whats new?\n Alpha 9: New Look, \n Full file creating support, \n Users, \n Saving options.\n 9.1: Minor Bug Fixes";
        self.EventB.hidden = NO;
        self.SaveB.hidden = NO;
        self.Load.hidden = NO;
        self.Load2.hidden = NO;
        self.modif.hidden = NO;
        self.event1.hidden = NO;
        self.openb.hidden = NO;
        self.ModMenu.hidden = NO;
        self.rButton.hidden = NO;
        self.settingsA8.hidden = YES;
        self.settingsA9.hidden = NO;
        self.SaveB.hidden = NO;
        self.Load.hidden = YES;
        self.Load2.hidden = NO;
        self.prisonArchitectMainButton.enabled = NO;
    }
    
    self.labels.stringValue = @"Checking for files...";
    NSFileManager* mngr = [NSFileManager defaultManager];
    
    if ([mngr fileExistsAtPath:filePathToMoveSettings] == NO) {
        [self.console insertText:@"Settings Does not Exist\n"];
        NSLog(@"Settings Does not exist");
        self.labels.stringValue = @"Writing files...";
        self.exists = false;
    } else{
        self.exists = true;
        self.GDTB.enabled = true;
        [self.console insertText:@"Settings File Exists\n"];
        NSLog(@"Settings File Exists");
        self.labels.stringValue = @"Ready";
        NSString *fileContents = [NSString stringWithContentsOfFile:filePathToMoveSettings encoding:NSUTF8StringEncoding error:&error];
        [self.SettingsContent appendString:fileContents];
    }
    //Sets alot of values
    
    NSLog(@"Init");
    _TTT = false;
    self.tClicked = false;
    self.tClicked2 = false;
    self.TopicPR = [NSMutableArray array];
    self.Topic = [NSMutableString string];
    self.Event = [NSMutableString string];
    self.Save = [NSMutableString string];
    
    
    //Settings,
    
    [self.SettingsValues appendString:[NSString stringWithFormat:@"FullScreen:false;\nBetas:false;\nUpdate Auto:false;\nVersion:A9.1;\nMode:Normal;"]];
    
    //Creates file if necissarary.
    
    if (self.exists == false) {
		
		error = nil;
        if ([mngr createDirectoryAtURL:[NSURL fileURLWithPath:directoryToMove isDirectory:YES] 
		   withIntermediateDirectories:YES attributes:nil error:&error] == NO)
		{
            [self.console insertText:[NSString stringWithFormat:@"Error: %@\n", error]];
			NSLog(@"error: %@", error);
		}
        error = nil;
        if ([self.SettingsValues writeToURL:[NSURL fileURLWithPath:filePathToMoveSettings] atomically:YES encoding:NSUTF8StringEncoding error:&error] == NO)
        {
            [self.console insertText:[NSString stringWithFormat:@"Settings write rrror: %@\n", error]];
            NSLog(@"Settings write error: %@", error);
            
        }
        self.GDTB.enabled = true;
        [self.console insertText:@"File Created\n"];
        NSLog(@"File Created");
        self.labels.stringValue = @"Ready";
        
    }
    self.TTT = false;
    self.TTT = true;
    //[self.loadBar stopAnimation:nil];
    self.CS.string = @"";
    
    //Finds and adds profiles
    [self.console insertText:@"Finding Username and Password and adding them.\n"];
    NSLog(@"Finding Username and Password and adding them.");
    NSString* appPath = [self applicationSupportPath];
    NSString* directoryPath = [NSString stringWithFormat:@"%@/UltimateMM/13674628675.profile", appPath];
    NSString* profile = [NSMutableString stringWithContentsOfFile:directoryPath encoding:NSUTF8StringEncoding error:&error];
    NSScanner *scanner = [NSScanner scannerWithString:profile];
    scanner = [NSScanner scannerWithString:profile];
    [scanner scanUpToString:@"RememberMe:" intoString:nil];
    while(![scanner isAtEnd]) {
        NSString *rMV = nil;
        [scanner scanString:@"RememberMe:" intoString:nil];
        if([scanner scanUpToString:@";" intoString:&rMV]) {
            if ([rMV isEqualToString:@"true"]) {
                self.rememberMe.state = true;
                scanner = [NSScanner scannerWithString:profile];
                [scanner scanUpToString:@"Usr:" intoString:nil];
                while(![scanner isAtEnd]) {
                    NSString *username = nil;
                    [scanner scanString:@"Usr:" intoString:nil];
                    if([scanner scanUpToString:@";" intoString:&username]) {
                        self.userNameTxtFeild.stringValue = username;
                        [self.console insertText:[NSString stringWithFormat:@"Username: %@\n", username]];
                        NSLog(@"Username: %@", username);
                    }
                    [scanner scanUpToString:@"Usr:" intoString:nil];
                }
                [self.console insertText:@"Found Username moving on to password.\n"];
                NSLog(@"Found Username moving on to password.");
                scanner = [NSScanner scannerWithString:profile];
                [scanner scanUpToString:@"Pass:" intoString:nil];
                while(![scanner isAtEnd]) {
                    NSString *password = nil;
                    [scanner scanString:@"Pass:" intoString:nil];
                    if([scanner scanUpToString:@";" intoString:&password]) {
                        self.passwordTxtFeild.stringValue = password;
                        [self.console insertText:[NSString stringWithFormat:@"Password: %@\n", password]];
                        NSLog(@"Password: %@", password);
                    }
                    [scanner scanUpToString:@"Pass:" intoString:nil];
                }

            } else if ([rMV isEqualToString:@"false"]) {
                self.rememberMe.state = false;
            }
            [self.console insertText:[NSString stringWithFormat:@"Remember Me: %@\n", rMV]];
            NSLog(@"RememberMe: %@", rMV);
        }
        [scanner scanUpToString:@"RememberMe:" intoString:nil];
    }
    [self.console insertText:@"Added Profile if any.\n"];
    NSLog(@"Added Profile if any.");
    [self.console insertText:@"Getting settings...\n"];
    NSLog(@"Getting settings...");
    NSString* settingsPath = [NSString stringWithFormat:@"%@/UltimateMM/settings.settings", appPath];
    NSString* settings = [NSMutableString stringWithContentsOfFile:settingsPath encoding:NSUTF8StringEncoding error:&error];
    scanner = [NSScanner scannerWithString:settings];
    [scanner scanUpToString:@"Betas:" intoString:nil];
    while(![scanner isAtEnd]) {
        NSString *betasV = nil;
        [scanner scanString:@"Betas:" intoString:nil];
        if([scanner scanUpToString:@";" intoString:&betasV]) {
            [self.console insertText:[NSString stringWithFormat:@"Betas Value: %@\n", betasV]];
            NSLog(@"Betas Value: %@", betasV);
            if ([betasV isEqualTo:@"false"]) {
                self.TestBuild.state = false;
            } else if ([betasV isEqualTo:@"true"]) {
                self.TestBuild.state = true;
                if (self.TestBuild.state == true) {
                    [self.console insertText:@"Test Build state is true\n"];
                } else {
                    [self.console insertText:@"Test build state is false\n"];
                    [self.Version selectItemWithObjectValue:@"Alpha 9.1"];
                }
            }
        }
        [scanner scanUpToString:@"Betas:" intoString:nil];
    }
    scanner = [NSScanner scannerWithString:settings];
    [scanner scanUpToString:@"Version:" intoString:nil];
    while(![scanner isAtEnd]) {
        NSString *versionV = nil;
        [scanner scanString:@"Version:" intoString:nil];
        if([scanner scanUpToString:@";" intoString:&versionV]) {
            [self.console insertText:[NSString stringWithFormat:@"Version Value: %@\n", versionV]];
            NSLog(@"Version Value: %@", versionV);
            if ([versionV isEqualTo:@"A7.9"]) {
                [self.Version selectItemAtIndex:0];
                self.VersionL1.stringValue = @"Alpha 7.9";
                self.VersionL2.stringValue = @"Alpha 7.9";
                self.whatsNew.stringValue = @"Whats new?\n Added some new Ui and a new look!";
                self.EventB.hidden = YES;
                self.modif.hidden = YES;
                self.event1.hidden = YES;
                self.ModMenu.hidden = YES;
                self.rButton.hidden = YES;
                self.settingsA8.hidden = NO;
                self.settingsA9.hidden = YES;
                self.SaveB.hidden = YES;
                self.Load.hidden = YES;
                self.Load2.hidden = YES;
                self.prisonArchitectMainButton.enabled = NO;
            } else if ([versionV isEqualTo:@"A8"]) {
                [self.Version selectItemAtIndex:1];
                self.VersionL1.stringValue = @"Alpha 8";
                self.VersionL2.stringValue = @"Alpha 8";
                self.whatsNew.stringValue = @"Whats, new?\n A completely new look thats nice, new, clean, and fresh,\n New settings,\n New Beta Mode For Alpha 9,\n Added Events,\n Added Researches and Customizable features";
                self.EventB.hidden = NO;
                self.rButton.hidden = NO;
                self.Load.hidden = YES;
                self.modif.hidden = NO;
                self.event1.hidden = NO;
                self.openb.hidden = YES;
                self.ModMenu.hidden = NO;
                self.settingsA8.hidden = NO;
                self.settingsA9.hidden = YES;
                self.SaveB.hidden = YES;
                self.Load.hidden = YES;
                self.Load2.hidden = YES;
                self.prisonArchitectMainButton.enabled = NO;
            } else if ([versionV isEqualTo:@"A9.1"]) {
                [self.Version selectItemAtIndex:2];
                self.VersionL1.stringValue = @"Alpha 9.1";
                self.VersionL2.stringValue = @"Alpha 9.1";
                self.whatsNew.stringValue = @"Whats new?\n Alpha 9: New Look, \n Full file creating support, \n Users, \n Saving options.\n 9.1: Minor Bug Fixes";
                self.EventB.hidden = NO;
                self.SaveB.hidden = NO;
                self.Load.hidden = NO;
                self.Load2.hidden = NO;
                self.modif.hidden = NO;
                self.event1.hidden = NO;
                self.openb.hidden = NO;
                self.ModMenu.hidden = NO;
                self.rButton.hidden = NO;
                self.settingsA8.hidden = YES;
                self.settingsA9.hidden = NO;
                self.SaveB.hidden = NO;
                self.Load.hidden = YES;
                self.Load2.hidden = NO;
                self.prisonArchitectMainButton.enabled = NO;
            } else if ([versionV isEqualTo:@"TA10"]) {
                [self.Version addItemWithObjectValue:@"Test A10"];
                [self.Version selectItemAtIndex:3];
                self.VersionL1.stringValue = @"Test A10";
                self.VersionL2.stringValue = @"Test A10";
                self.whatsNew.stringValue = @"Whats new?\n Prison Architect support(WORK IN PROGRESS)";
                self.EventB.hidden = NO;
                self.SaveB.hidden = NO;
                self.Load.hidden = NO;
                self.Load2.hidden = NO;
                self.modif.hidden = NO;
                self.event1.hidden = NO;
                self.openb.hidden = NO;
                self.ModMenu.hidden = NO;
                self.rButton.hidden = NO;
                self.settingsA8.hidden = YES;
                self.settingsA9.hidden = NO;
                self.SaveB.hidden = NO;
                self.Load.hidden = YES;
                self.Load2.hidden = NO;
                self.prisonArchitectMainButton.enabled = YES;
            }
        }
        [scanner scanUpToString:@"Version:" intoString:nil];
    }
    scanner = [NSScanner scannerWithString:settings];
    [scanner scanUpToString:@"Mode:" intoString:nil];
    while(![scanner isAtEnd]) {
        NSString *modeV = nil;
        [scanner scanString:@"Mode:" intoString:nil];
        if([scanner scanUpToString:@";" intoString:&modeV]) {\
            [self.console insertText:[NSString stringWithFormat:@"Mode Value: %@\n", modeV]];
            NSLog(@"Mode Value: %@", modeV);
            if ([modeV isEqualTo:@"Norm"]) {
                [self.Mode selectItemAtIndex:0];
            } else if ([modeV isEqualTo:@"Adv"]) {
                [self.Mode selectItemAtIndex:1];
            } else if ([modeV isEqualTo:@"Pro"]) {
                [self.Mode selectItemAtIndex:2];
            } else if ([modeV isEqualTo:@"Dev"]) {
                [self.Mode addItemWithObjectValue:@"Developer"];
                [self.Mode selectItemAtIndex:3];
                NSWindow* keyTarget = self.MainWindow;
                NSRect frame = keyTarget.frame;
                frame.size.height = 650;
                self.modeValue = [NSMutableString stringWithFormat:@"Dev"];
                [self.MainWindow setFrame:frame display:NO animate:YES];
                if (self.DevMode == 1) {
                    [self.Version addItemWithObjectValue:@"Developer"];
                    self.DevMode = 0;
                } else {
                    [self.Version removeItemWithObjectValue:@"Developer"];
                    [self.Version selectItemWithObjectValue:@"Alpha 9.1"];
                    self.DevMode = 1;
                }
            }
        }
        [scanner scanUpToString:@"Mode:" intoString:nil];
    }
}
- (IBAction)rememberMe:(id)sender {
    if (self.rememberMe.state == true) {
        [self.console insertText:@"Creating profile path! \n"];
        NSLog(@"Creating profile path!");
        NSError* error = nil;
        NSString*appPath = [self applicationSupportPath];
        NSString* directoryPath = [NSString stringWithFormat:@"%@/UltimateMM/13674628675.profile", appPath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:directoryPath]){
            BOOL didRemove = [fileManager removeItemAtPath:directoryPath error:&error];
            if (didRemove == false) {\
                [self.console insertText:@"ERROR COULD NOT REMOVE PROFILE FROM PATH! SHUTTING DOWN PROGRAM!\n"];
                NSLog(@"ERROR COULD NOT REMOVE PROFILE FROM PATH! SHUTTING DOWN PROGRAM!");
                [[NSApplication sharedApplication] terminate:nil];
            }
        }
        [self.console insertText:@"Creating string holding username and password! \n"];
        NSLog(@"Creating string holding username and password!");
        NSString* profile = [NSString stringWithFormat:@"Usr:%@;\nPass:%@;\nRememberMe:true;", [self.userNameTxtFeild stringValue], [self.passwordTxtFeild stringValue]];
        [self.console insertText:@"Storing Profile \n"];
        NSLog(@"Storing Username: %@ Password: %@", [self.userNameTxtFeild stringValue], [self.passwordTxtFeild stringValue]);
        error = nil;
        BOOL didWrite = [profile writeToFile:directoryPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (didWrite == false) {
            [self.console insertText:[NSString stringWithFormat:@"Error saving profile, error code: %@\n", error]];
            NSLog(@"Error Saving Profile, Error Code: %@", error);
            self.mainMenuError.stringValue = [NSString stringWithFormat:@"Error remembering profile! Error saved to error log!"];
            NSString* errorTxt = [NSString stringWithFormat:@"%@", error];
            NSString* applicationSupportDirectory = [self applicationSupportPath];
            NSString *directoryToMove = [NSString stringWithFormat:@"%@/UltimateMM", applicationSupportDirectory ];
            NSString *filePathToMoveSettings = [directoryToMove stringByAppendingPathComponent:@"Error.log"];
            error = nil;
            BOOL didWrite2 = [errorTxt writeToFile:filePathToMoveSettings atomically:YES encoding:NSUTF8StringEncoding error:&error];
            if (didWrite2 == false) {\
                [self.console insertText:[NSString stringWithFormat:@"Error'd on writing error! Error code: %@ \n", error]];
                NSLog(@"Error'd on writing error! Error Code: %@", error);
            }
        }
    } else {
        [self.console insertText:@"Creating profile path \n"];
        NSLog(@"Creating profile path!");
        NSError* error = nil;
        NSString*appPath = [self applicationSupportPath];
        NSString* directoryPath = [NSString stringWithFormat:@"%@/UltimateMM/13674628675.profile", appPath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:directoryPath]){
            BOOL didRemove = [fileManager removeItemAtPath:directoryPath error:&error];
            if (didRemove == false) {
                [self.console insertText:@"ERROR COULD NOT REMOVE PROFILE FROM PATH! SHUTTING DOWN PROGRAM!\n"];
                NSLog(@"ERROR COULD NOT REMOVE PROFILE FROM PATH! SHUTTING DOWN PROGRAM!");
                [[NSApplication sharedApplication] terminate:nil];
            }
        }
        [self.console insertText:@"Creating string holding username and password! \n"];
        NSLog(@"Creating string holding username and password!");
        NSString* profile = [NSString stringWithFormat:@"Usr:%@;\nPass:%@;\nRememberMe:false;", [self.userNameTxtFeild stringValue], [self.passwordTxtFeild stringValue]];
        [self.console insertText:@"Storing Profile \n"];
        NSLog(@"Storing Username: %@ Password: %@", [self.userNameTxtFeild stringValue], [self.passwordTxtFeild stringValue]);
        error = nil;
        BOOL didWrite = [profile writeToFile:directoryPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (didWrite == false) {
            [self.console insertText:[NSString stringWithFormat:@"Error saving profile, error code: %@\n", error]];
            NSLog(@"Error Saving Profile, Error Code: %@", error);
            self.mainMenuError.stringValue = [NSString stringWithFormat:@"Error remembering profile! Error saved to error log!"];
            NSString* errorTxt = [NSString stringWithFormat:@"%@", error];
            NSString* applicationSupportDirectory = [self applicationSupportPath];
            NSString *directoryToMove = [NSString stringWithFormat:@"%@/UltimateMM", applicationSupportDirectory ];
            NSString *filePathToMoveSettings = [directoryToMove stringByAppendingPathComponent:@"Error.log"];
            error = nil;
            BOOL didWrite2 = [errorTxt writeToFile:filePathToMoveSettings atomically:YES encoding:NSUTF8StringEncoding error:&error];
            if (didWrite2 == false) {
                [self.console insertText:[NSString stringWithFormat:@"Error'd on writing error! Error code: %@ \n", error]];
                NSLog(@"Error'd on writing error! Error Code: %@", error);
            }
        }
    }

}

- (IBAction)logInClicked:(id)sender {
    [self.console insertText:@"Log in has been clicked.\n"];
    NSLog(@"Log in has been clicked.");
    self.usernameLabel.stringValue = @"guest!";
    if ([self.userNameTxtFeild.stringValue  isEqual: @"Joshua Kac"]) {
        if ([self.passwordTxtFeild.stringValue isEqualTo: @"Lego1com1"]) {
            [self.Mode selectItemAtIndex:3];
            if ([self.Mode.stringValue  isNotEqualTo:@"Developer"]) {
                [self.Mode addItemWithObjectValue:@"Developer"];
            }
            self.logInBox.hidden = true;
            [self.console insertText:@"Log in buttons and textfeilds have been hidden.\n"];
            NSLog(@"Log in buttons and textfeilds have been hidden.");
            self.mainMenuBox.hidden = false;
            [self.console insertText:@"Main menu buttons, labels, textfeilds, and more have been made visible.\n"];
            NSLog(@"Main Menu buttons, labels, textfeilds, and more have been made visible.");
            self.usernameLabel.stringValue = @"Joshua Kac!";
            //Checks to see if username and password should be remembered
            [self.console insertText:@"Checking to see if profile should be remembered\n"];
            NSLog(@"Checking to see if profile should be remembered!");
            if (self.rememberMe.state == true) {
                [self.console insertText:@"Saving profile\n"];
                NSLog(@"Saving profile!");
                [self.console insertText:@"Creating profile path\n"];
                NSLog(@"Creating profile path!");
                NSError* error = nil;
                NSString*appPath = [self applicationSupportPath];
                NSString* directoryPath = [NSString stringWithFormat:@"%@/UltimateMM/13674628675.profile", appPath];
                NSFileManager *fileManager = [NSFileManager defaultManager];
                if ([fileManager fileExistsAtPath:directoryPath]){
                    BOOL didRemove = [fileManager removeItemAtPath:directoryPath error:&error];
                    if (didRemove == false) {
                        [self.console insertText:@"ERROR COULD NOT REMOVE PROFILE FROM PATH! SHUTTING DOWN PROGRAM!\n"];
                        NSLog(@"ERROR COULD NOT REMOVE PROFILE FROM PATH! SHUTTING DOWN PROGRAM!");
                        [[NSApplication sharedApplication] terminate:nil];
                    }
                }
                [self.console insertText:@"Creating string holding username and password\n"];
                NSLog(@"Creating string holding username and password!");
                NSString* profile = [NSString stringWithFormat:@"Usr:%@;\nPass:%@;\nRememberMe:true;", [self.userNameTxtFeild stringValue], [self.passwordTxtFeild stringValue]];
                NSLog(@"Storing Username: %@ Password: %@", [self.userNameTxtFeild stringValue], [self.passwordTxtFeild stringValue]);
                error = nil;
                BOOL didWrite = [profile writeToFile:directoryPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
                if (didWrite == false) {
                    [self.console insertText:[NSString stringWithFormat:@"Error saving profile, error code: %@\n", error]];
                    NSLog(@"Error Saving Profile, Error Code: %@", error);
                    self.mainMenuError.stringValue = [NSString stringWithFormat:@"Error remembering profile! Error saved to error log!"];
                    NSString* errorTxt = [NSString stringWithFormat:@"%@", error];
                    NSString* applicationSupportDirectory = [self applicationSupportPath];
                    NSString *directoryToMove = [NSString stringWithFormat:@"%@/UltimateMM", applicationSupportDirectory ];
                    NSString *filePathToMoveSettings = [directoryToMove stringByAppendingPathComponent:@"Error.log"];
                    error = nil;
                    BOOL didWrite2 = [errorTxt writeToFile:filePathToMoveSettings atomically:YES encoding:NSUTF8StringEncoding error:&error];
                    if (didWrite2 == false) {
                        [self.console insertText:[NSString stringWithFormat:@"Error'd on writing error, error code: %@", error]];
                        NSLog(@"Error'd on writing error! Error Code: %@", error);
                    }
                }
            } else {
                [self.console insertText:@"Will not remember profile!\n"];
                NSLog(@"Will not remember profile!");
                NSLog(@"Username: %@ Password: %@", [self.userNameTxtFeild stringValue], [self.passwordTxtFeild stringValue]);
            }
        } else {
            [self.console insertText:@"Error Logging in as admin!\n"];
            NSLog(@"Error Logging in as admin.");
            self.errorLogInTxtFeild.stringValue = @"Error Logging in check username or passcode!";
        }
    } else if ([self.userNameTxtFeild isEqualTo: @""]) {
        [self.console insertText:@"Error loging in!\n"];
        self.errorLogInTxtFeild.stringValue = @"Error Logging in check username or passcode!";
    } else {
        [self.console insertText:@"Error loging in!\n"];
        self.errorLogInTxtFeild.stringValue = @"Error Logging in check username or passcode!";
    }
}
- (IBAction)continueAsGuestClicked:(id)sender {
    [self.console insertText:@"Continue as guest has been clicked\n"];
    NSLog(@"Continue as guest has been clicked.");
    self.logInBox.hidden = true;
    [self.console insertText:@"Log in menu has been made hidden\n"];
    NSLog(@"Log in buttons and textfeilds have been hidden.");
    self.mainMenuBox.hidden = false;
    [self.console insertText:@"Main Menu has been made visible\n"];
    NSLog(@"Main Menu buttons, labels, textfeilds, and more have been made visible.");
    self.usernameLabel.stringValue = @"Guest!";
}
- (IBAction)usernameEnter:(id)sender {
    [self.console insertText:@"Log in has been clicked.\n"];
    NSLog(@"Log in has been clicked.");
    self.usernameLabel.stringValue = @"guest!";
    if ([self.userNameTxtFeild.stringValue  isEqual: @"Joshua Kac"]) {
        if ([self.passwordTxtFeild.stringValue isEqualTo: @"Lego1com1"]) {
            [self.Mode selectItemAtIndex:3];
            if ([self.Mode.stringValue  isNotEqualTo:@"Developer"]) {
                [self.Mode addItemWithObjectValue:@"Developer"];
            }
            self.logInBox.hidden = true;
            [self.console insertText:@"Log in buttons and textfeilds have been hidden.\n"];
            NSLog(@"Log in buttons and textfeilds have been hidden.");
            self.mainMenuBox.hidden = false;
            [self.console insertText:@"Main menu buttons, labels, textfeilds, and more have been made visible.\n"];
            NSLog(@"Main Menu buttons, labels, textfeilds, and more have been made visible.");
            self.usernameLabel.stringValue = @"Joshua Kac!";
            //Checks to see if username and password should be remembered
            [self.console insertText:@"Checking to see if profile should be remembered\n"];
            NSLog(@"Checking to see if profile should be remembered!");
            if (self.rememberMe.state == true) {
                [self.console insertText:@"Saving profile\n"];
                NSLog(@"Saving profile!");
                [self.console insertText:@"Creating profile path\n"];
                NSLog(@"Creating profile path!");
                NSError* error = nil;
                NSString*appPath = [self applicationSupportPath];
                NSString* directoryPath = [NSString stringWithFormat:@"%@/UltimateMM/13674628675.profile", appPath];
                NSFileManager *fileManager = [NSFileManager defaultManager];
                if ([fileManager fileExistsAtPath:directoryPath]){
                    BOOL didRemove = [fileManager removeItemAtPath:directoryPath error:&error];
                    if (didRemove == false) {
                        [self.console insertText:@"ERROR COULD NOT REMOVE PROFILE FROM PATH! SHUTTING DOWN PROGRAM!\n"];
                        NSLog(@"ERROR COULD NOT REMOVE PROFILE FROM PATH! SHUTTING DOWN PROGRAM!");
                        [[NSApplication sharedApplication] terminate:nil];
                    }
                }
                [self.console insertText:@"Creating string holding username and password\n"];
                NSLog(@"Creating string holding username and password!");
                NSString* profile = [NSString stringWithFormat:@"Usr:%@;\nPass:%@;\nRememberMe:true;", [self.userNameTxtFeild stringValue], [self.passwordTxtFeild stringValue]];
                NSLog(@"Storing Username: %@ Password: %@", [self.userNameTxtFeild stringValue], [self.passwordTxtFeild stringValue]);
                error = nil;
                BOOL didWrite = [profile writeToFile:directoryPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
                if (didWrite == false) {
                    [self.console insertText:[NSString stringWithFormat:@"Error saving profile, error code: %@\n", error]];
                    NSLog(@"Error Saving Profile, Error Code: %@", error);
                    self.mainMenuError.stringValue = [NSString stringWithFormat:@"Error remembering profile! Error saved to error log!"];
                    NSString* errorTxt = [NSString stringWithFormat:@"%@", error];
                    NSString* applicationSupportDirectory = [self applicationSupportPath];
                    NSString *directoryToMove = [NSString stringWithFormat:@"%@/UltimateMM", applicationSupportDirectory ];
                    NSString *filePathToMoveSettings = [directoryToMove stringByAppendingPathComponent:@"Error.log"];
                    error = nil;
                    BOOL didWrite2 = [errorTxt writeToFile:filePathToMoveSettings atomically:YES encoding:NSUTF8StringEncoding error:&error];
                    if (didWrite2 == false) {
                        [self.console insertText:[NSString stringWithFormat:@"Error'd on writing error, error code: %@", error]];
                        NSLog(@"Error'd on writing error! Error Code: %@", error);
                    }
                }
            } else {
                [self.console insertText:@"Will not remember profile!\n"];
                NSLog(@"Will not remember profile!");
                NSLog(@"Username: %@ Password: %@", [self.userNameTxtFeild stringValue], [self.passwordTxtFeild stringValue]);
            }
        } else {
            [self.console insertText:@"Error Logging in as admin!\n"];
            NSLog(@"Error Logging in as admin.");
            self.errorLogInTxtFeild.stringValue = @"Error Logging in check username or passcode!";
        }
    } else if ([self.userNameTxtFeild isEqualTo: @""]) {
        [self.console insertText:@"Error loging in!\n"];
        self.errorLogInTxtFeild.stringValue = @"Error Logging in check username or passcode!";
    } else {
        [self.console insertText:@"Error loging in!\n"];
        self.errorLogInTxtFeild.stringValue = @"Error Logging in check username or passcode!";
    }
}
- (IBAction)passwordEnter:(id)sender {
    [self.console insertText:@"Log in has been clicked.\n"];
    NSLog(@"Log in has been clicked.");
    self.usernameLabel.stringValue = @"guest!";
    if ([self.userNameTxtFeild.stringValue  isEqual: @"Joshua Kac"]) {
        if ([self.passwordTxtFeild.stringValue isEqualTo: @"Lego1com1"]) {
            [self.Mode selectItemAtIndex:3];
            if ([self.Mode.stringValue  isNotEqualTo:@"Developer"]) {
                [self.Mode addItemWithObjectValue:@"Developer"];
            }
            self.logInBox.hidden = true;
            [self.console insertText:@"Log in buttons and textfeilds have been hidden.\n"];
            NSLog(@"Log in buttons and textfeilds have been hidden.");
            self.mainMenuBox.hidden = false;
            [self.console insertText:@"Main menu buttons, labels, textfeilds, and more have been made visible.\n"];
            NSLog(@"Main Menu buttons, labels, textfeilds, and more have been made visible.");
            self.usernameLabel.stringValue = @"Joshua Kac!";
            //Checks to see if username and password should be remembered
            [self.console insertText:@"Checking to see if profile should be remembered\n"];
            NSLog(@"Checking to see if profile should be remembered!");
            if (self.rememberMe.state == true) {
                [self.console insertText:@"Saving profile\n"];
                NSLog(@"Saving profile!");
                [self.console insertText:@"Creating profile path\n"];
                NSLog(@"Creating profile path!");
                NSError* error = nil;
                NSString*appPath = [self applicationSupportPath];
                NSString* directoryPath = [NSString stringWithFormat:@"%@/UltimateMM/13674628675.profile", appPath];
                NSFileManager *fileManager = [NSFileManager defaultManager];
                if ([fileManager fileExistsAtPath:directoryPath]){
                    BOOL didRemove = [fileManager removeItemAtPath:directoryPath error:&error];
                    if (didRemove == false) {
                        [self.console insertText:@"ERROR COULD NOT REMOVE PROFILE FROM PATH! SHUTTING DOWN PROGRAM!\n"];
                        NSLog(@"ERROR COULD NOT REMOVE PROFILE FROM PATH! SHUTTING DOWN PROGRAM!");
                        [[NSApplication sharedApplication] terminate:nil];
                    }
                }
                [self.console insertText:@"Creating string holding username and password\n"];
                NSLog(@"Creating string holding username and password!");
                NSString* profile = [NSString stringWithFormat:@"Usr:%@;\nPass:%@;\nRememberMe:true;", [self.userNameTxtFeild stringValue], [self.passwordTxtFeild stringValue]];
                NSLog(@"Storing Username: %@ Password: %@", [self.userNameTxtFeild stringValue], [self.passwordTxtFeild stringValue]);
                error = nil;
                BOOL didWrite = [profile writeToFile:directoryPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
                if (didWrite == false) {
                    [self.console insertText:[NSString stringWithFormat:@"Error saving profile, error code: %@\n", error]];
                    NSLog(@"Error Saving Profile, Error Code: %@", error);
                    self.mainMenuError.stringValue = [NSString stringWithFormat:@"Error remembering profile! Error saved to error log!"];
                    NSString* errorTxt = [NSString stringWithFormat:@"%@", error];
                    NSString* applicationSupportDirectory = [self applicationSupportPath];
                    NSString *directoryToMove = [NSString stringWithFormat:@"%@/UltimateMM", applicationSupportDirectory ];
                    NSString *filePathToMoveSettings = [directoryToMove stringByAppendingPathComponent:@"Error.log"];
                    error = nil;
                    BOOL didWrite2 = [errorTxt writeToFile:filePathToMoveSettings atomically:YES encoding:NSUTF8StringEncoding error:&error];
                    if (didWrite2 == false) {
                        [self.console insertText:[NSString stringWithFormat:@"Error'd on writing error, error code: %@", error]];
                        NSLog(@"Error'd on writing error! Error Code: %@", error);
                    }
                }
            } else {
                [self.console insertText:@"Will not remember profile!\n"];
                NSLog(@"Will not remember profile!");
                NSLog(@"Username: %@ Password: %@", [self.userNameTxtFeild stringValue], [self.passwordTxtFeild stringValue]);
            }
        } else {
            [self.console insertText:@"Error Logging in as admin!\n"];
            NSLog(@"Error Logging in as admin.");
            self.errorLogInTxtFeild.stringValue = @"Error Logging in check username or passcode!";
        }
    } else if ([self.userNameTxtFeild isEqualTo: @""]) {
        [self.console insertText:@"Error loging in!\n"];
        self.errorLogInTxtFeild.stringValue = @"Error Logging in check username or passcode!";
    } else {
        [self.console insertText:@"Error loging in!\n"];
        self.errorLogInTxtFeild.stringValue = @"Error Logging in check username or passcode!";
    }
}


#pragma mark MineCraft
- (void)download:(NSURLDownload *)download didReceiveResponse:(NSURLResponse *)response
{
    // Reset the progress, this might be called multiple times.
    // bytesReceived is an instance variable defined elsewhere.
    self.bytesReceived = 0;
    
    // Store the response to use later.
    [self setDownloadResponse:response];
}

- (void)download:(NSURLDownload *)download didReceiveDataOfLength:(unsigned)length
{
    long long expectedLength = [[self downloadResponse] expectedContentLength];
    
    self.bytesReceived = self.bytesReceived + length;
    
    if (expectedLength != NSURLResponseUnknownLength) {
        // If the expected content length is
        // available, display percent complete.
        float percentComplete = (self.bytesReceived/(float)expectedLength)*100.0;
        NSLog(@"Percent complete - %f",percentComplete);
        
    } else {
        // If the expected content length is
        // unknown, just log the progress.
        NSLog(@"Bytes received - %ld",(long)self.bytesReceived);
    }
}

#pragma mark Finish
- (IBAction)FinishServerClicked:(id)sender {
    NSLog(@"Finish Clicked");
    [self.serverProperties appendString:[NSString stringWithFormat:@"#Minecraft server properties\n#(File modification datestamp)\nspawn-protection=%@\nmax-tick-time=60000\ngenerator-settings= \nforce-gamemode=false \nallow-nether=true \ngamemode=%@ \nenable-query=false \nplayer-idle-timeout=%@ \ndifficulty=%@ \nspawn-monsters=true \nop-permission-level=4 \nresource-pack-hash= \nannounce-player-achievements=true \npvp=%@ \nsnooper-enabled=true \nlevel-type=DEFAULT \nhardcore=false \n-command-block=false \nmax-players=%@ \nnetwork-compression-threshold=256 \nmax-world-size=29999984 \nserver-port=%@ \nserver-ip=%@ \nspawn-npcs=%@ \nallow-flight=false \nlevel-name=%@ \nview-distance=%@ \nresource-pack= \nspawn-animals=true \nwhite-list=false \ngenerate-structures=true \nonline-mode=%@ \nmax-build-height=%@ \nlevel-seed=%@ \nmotd=%@ \nenable-rcon=false \n", [self.spawnProtection stringValue], [self.gameMode stringValue], [self.playerIdleTimeOut stringValue], [self.difficulty stringValue], self.pvp, [self.maxPlayers stringValue], [self.port stringValue], [self.IPAdress stringValue], self.spawnNPCS, [self.mineCraftWorldSavename stringValue], [self.viewDistance stringValue], self.onlineMode, [self.buildHeight stringValue], [self.seed stringValue], [self.message stringValue]]];
    NSWindow *keyTarget = [[NSApplication sharedApplication] keyWindow];
    NSSavePanel *spanel = [NSSavePanel savePanel];
    [spanel setCanCreateDirectories:NO];
    [spanel setCanSelectHiddenExtension:NO];
    [spanel setAllowedFileTypes:nil];
    [spanel setTreatsFilePackagesAsDirectories:YES];
    [spanel beginSheetModalForWindow:keyTarget  completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton)
        {
            NSError *error = nil;
            NSURL *directoryURL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:[[NSProcessInfo processInfo] globallyUniqueString]] isDirectory:YES];
            [[NSFileManager defaultManager] createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:&error];
            NSURL *fileURL1 = [directoryURL URLByAppendingPathComponent:self.serverName.stringValue];
            NSURL *fileURL2 = [directoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"/%@/server.properties", [self.serverName stringValue]]];
            NSURL *fileURL3 = [directoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"/%@/minecraft_server.1.8.jar", [self.serverName stringValue]]];
            NSURL *saveURL = [spanel URL];
            NSLog(@"%@", saveURL);
            if(_TTT == true) {
                [self.downloadProgress startAnimation:0];
                NSLog(@"Server Proccessing");
                NSFileManager *mngr = [NSFileManager defaultManager];
                error = nil;
                BOOL didWrite =[mngr createDirectoryAtURL:fileURL1 withIntermediateDirectories:YES attributes:nil error:&error];
                if (didWrite == NO) {
                    NSLog(@"Directory Main Write Error: %@", error);
                }
                //
                // Create the request.
                NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://s3.amazonaws.com/Minecraft.Download/versions/1.8/minecraft_server.1.8.jar"]
                                                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                        timeoutInterval:10.0];
                
                // Create the connection with the request and start loading the data.
                NSURLDownload  *theDownload = [[NSURLDownload alloc] initWithRequest:theRequest delegate:self];
                if (theDownload) {
                    // Set the destination file.
                    NSString* path = saveURL.path;
                    [theDownload setDestination:path allowOverwrite:YES];
                } else {
                    NSLog(@"Download failed! Error - %@ %@",
                          [error localizedDescription],
                          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
                }
                error = nil;
                BOOL didWrite2 =[self.serverProperties  writeToURL:fileURL2 atomically:YES encoding:NSUTF8StringEncoding error:&error];
                if (didWrite2 == NO) {
                    NSLog(@"Server Properties write error: %@", error);
                }
                error = nil;
                BOOL didMove = [mngr moveItemAtURL:fileURL1 toURL:saveURL error:&error];
                if (didMove == NO) {
                    NSLog(@"Server Move Error: %@", error);
                }
                error = nil;
            }
            _TTT = false;
            NSFileManager *mngr = [NSFileManager defaultManager];
            [mngr trashItemAtURL:directoryURL resultingItemURL:nil error:&error];
        }
    }];

}


#pragma mark Game Dev Tycoon



#pragma mark Mods Button

- (IBAction)Mods:(id)sender {
    [self.console insertText:@"Mods Button Pressed\n"];
    NSLog(@"Mods Button Pressed");
    if (self.tClicked2 == false) {
        self.BCKG2.hidden = NO;
        self.tClicked2 = true;
        self.BCKG.hidden = YES;
        self.BCKG3.hidden = YES;
        self.BCKG4.hidden = YES;
        self.BCKG5.hidden = YES;
        self.tClicked = false;
        self.tClicked2 = true;
        self.tClicked3 = false;
        self.tClicked4 = false;
        self.tClicked5 = false;
    } else if (self.tClicked2 == true) {
        self.BCKG2.hidden = YES;
        self.tClicked2 = false;
        self.BCKG.hidden = YES;
        self.BCKG3.hidden = YES;
        self.BCKG4.hidden = YES;
    }
}

#pragma mark Custom Script Button

- (IBAction)CustomScript:(id)sender {
    [self.console insertText:@"Custom Script button pressed\n"];
    NSLog(@"Custom Button Pressed");
    if (self.tClicked3 == false) {
        self.BCKG3.hidden = NO;
        self.tClicked3 = true;
        self.BCKG.hidden = YES;
        self.BCKG2.hidden = YES;
        self.BCKG4.hidden = YES;
        self.BCKG5.hidden = YES;
        self.tClicked = false;
        self.tClicked2 = false;
        self.tClicked3 = true;
        self.tClicked4 = false;
        self.tClicked5 = false;
    } else if (self.tClicked3 == true) {
        self.BCKG3.hidden = YES;
        self.tClicked3 = false;
        self.BCKG.hidden = YES;
        self.BCKG2.hidden = YES;
        self.BCKG4.hidden = YES;
    }
}

#pragma mark Topic Button

- (IBAction)TopicClicked:(id)sender {
    [self.console insertText:@"Create a topic button pressed\n"];
    NSLog(@"Topic Button Pressed");
    if (self.tClicked == false) {
        _AddButton.hidden = false;
        _TopicName.hidden = false;
        _EveryoneLabel.hidden = false;
        _YoungLabel.hidden = false;
        _MatureLabel.hidden = false;
        _ActionP.hidden = false;
        _AdventureP.hidden = false;
        _RPGP.hidden = false;
        _SimP.hidden = false;
        _StrategyP.hidden = false;
        _CasualP.hidden = false;
        _BCKG.hidden = NO;
        _Action.hidden = false;
        _Adventure.hidden = false;
        _RPG.hidden = false;
        _Simulation.hidden = false;
        _Strategy.hidden = false;
        _Casual.hidden = false;
        _Young.hidden = false;
        _Everyone.hidden = false;
        _Mature.hidden = false;
        self.tClicked = true;
        self.BCKG2.hidden = YES;
        self.BCKG3.hidden = YES;
        self.BCKG4.hidden = YES;
        self.BCKG5.hidden = YES;
        self.tClicked2= false;
        self.tClicked3 = false;
        self.tClicked4 = false;
        self.tClicked5 = false;
    } else if (self.tClicked == true) {
        _AddButton.hidden = true;
        _TopicName.hidden = true;
        _EveryoneLabel.hidden = true;
        _YoungLabel.hidden = true;
        _MatureLabel.hidden = true;
        _ActionP.hidden = true;
        _AdventureP.hidden = true;
        _RPGP.hidden = true;
        _SimP.hidden = true;
        _StrategyP.hidden = true;
        _CasualP.hidden = true;
        _BCKG.hidden = YES;
        _Action.hidden = true;
        _Adventure.hidden = true;
        _RPG.hidden = true;
        _Simulation.hidden = true;
        _Strategy.hidden = true;
        _Casual.hidden = true;
        _Young.hidden = true;
        _Everyone.hidden = true;
        _Mature.hidden = true;
        self.tClicked = false;
        self.BCKG2.hidden = YES;
        self.BCKG3.hidden = YES;
        self.BCKG4.hidden = YES;
    }
}

#pragma mark Other

- (IBAction)Started:(id)sender {
    [self.console insertText:@"Game Dev Tycoon button pressed\n"];
    NSLog(@"GDT Button Pressed");
    self.GDTMenuBox.hidden = false;
    self.mainMenuBox.hidden = true;
    self.logInBox.hidden = true;
        _TTT = false;
    NSWindow *keyTarget = self.MainWindow;
    if ([self.Mode.stringValue isEqual: @"Normal"]) {
        NSRect frame = keyTarget.frame;
        
        frame.size.width = 948;
        frame.size.height = 540;
        self.modeValue = [NSMutableString stringWithFormat:@"Norm"];
        
        [self.MainWindow setFrame:frame display:NO animate:YES];
    } else if ([self.Mode.stringValue isEqual: @"Advanced"]) {
        NSRect frame = keyTarget.frame;
        
        frame.size.width = 1165;
        frame.size.height = 540;
        self.modeValue = [NSMutableString stringWithFormat:@"Adv"];
        
        [self.MainWindow setFrame:frame display:NO animate:YES];
    }else if ([self.Mode.stringValue isEqual: @"Proffesional"]) {
        NSRect frame = keyTarget.frame;
        
        frame.size.width = 1165;
        frame.size.height = 540;
        self.modeValue = [NSMutableString stringWithFormat:@"Pro"];
        
        [self.MainWindow setFrame:frame display:NO animate:YES];
    } else if ([self.Mode.stringValue isEqual: @"Developer"]) {
        NSRect frame = keyTarget.frame;
        
        frame.size.width = 1165;
        
        frame.size.height = 650;
        self.modeValue = [NSMutableString stringWithFormat:@"Dev"];
        [self.MainWindow setFrame:frame display:NO animate:YES];
    }
}
- (IBAction)Quit:(id)sender {
    [self.console insertText:@"Quit button pressed\n"];
    NSLog(@"Quit Button Pressed");
    [[NSApplication sharedApplication] terminate:nil];
}
- (IBAction)Quit2:(id)sender {
    [self.console insertText:@"Quit Button Pressed\n"];
    NSLog(@"Quit Button Pressed");
    [[NSApplication sharedApplication] terminate:nil];
}
- (IBAction)BackMain:(id)sender {
    [self.console insertText:@"Game Dev tycoon menu button pressed\n"];
    NSLog(@"Back Button Pressed");
    self.GDTMenuBox.hidden = true;
    self.mainMenuBox.hidden = false;
    self.logInBox.hidden = true;
    _AddButton.hidden = true;
    _TopicName.hidden = true;
    _EveryoneLabel.hidden = true;
    _YoungLabel.hidden = true;
    _MatureLabel.hidden = true;
    _ActionP.hidden = true;
    _AdventureP.hidden = true;
    _RPGP.hidden = true;
    _SimP.hidden = true;
    _StrategyP.hidden = true;
    _CasualP.hidden = true;
    _BCKG.hidden = YES;
    _Action.hidden = true;
    _Adventure.hidden = true;
    _RPG.hidden = true;
    _Simulation.hidden = true;
    _Strategy.hidden = true;
    _Casual.hidden = true;
    _Young.hidden = true;
    _Everyone.hidden = true;
    _Mature.hidden = true;
    self.tClicked = false;
    self.BCKG2.hidden = YES;
    self.BCKG3.hidden = YES;
    self.BCKG4.hidden = YES;
    self.BCKG3.hidden = YES;
    self.BCKG5.hidden = YES;
    NSWindow* keyTarget = self.MainWindow;
    NSRect frame = keyTarget.frame;
    
    frame.size.width = 948;
    frame.size.height = 540;
    [self.MainWindow setFrame:frame display:NO animate:YES];

}

- (IBAction)ModNamer:(id)sender {
    [self.console insertText:@"Mod name changed\n"];
    NSLog(@"Mod Name Changed!");
    NSString *name = [ModNamer stringValue];
    [self.modNametxt2 setStringValue:name];
    [self.ModName setStringValue:name];
    [self.console insertText:@"Changing mod name in code (Disabled!!!!!)\n"];
    NSLog(@"Changing mod name in code");
    //Nothing is done here yet!
}

#pragma mark Custom Script Add

- (IBAction)CSAdd:(id)sender {
    [self.console insertText:@"Custom script button pressed\n"];
    NSLog(@"CS Button Pressed");;
    [self.Save appendString:[NSString stringWithFormat:@"4387=%@/\n", self.CS.string]];
    _TTT = true;
    _SSS = true;
}

#pragma mark Topic Add

- (IBAction)AddTopic:(id)sender {
    [self.console insertText:@"Add topic clicked"];
    self.Topic = [NSMutableString string];
    _TTT = true;
    self.YoungV = (self.Young.integerValue);
    self.EveryoneV = (self.Everyone.integerValue);
    self.MatureV = (self.Mature.integerValue);
    self.ActionV = (self.Action.floatValue);
    self.AdventureV = (self.Adventure.floatValue);
    self.RpgV = (self.RPG.floatValue);
    self.SimulationV = (self.Simulation.floatValue);
    self.StrategyV = (self.Strategy.floatValue);
    self.CasualV = (self.Casual.floatValue);
    
    if (self.YoungV == 1) _YoungValue = 0.3;
    if (self.YoungV == 2) _YoungValue = 0.7;
    if (self.YoungV == 3) _YoungValue = 1;
    if (self.EveryoneV == 1) _EveryoneValue = 0.3;
    if (self.EveryoneV == 2) _EveryoneValue = 0.7;
    if (self.EveryoneV == 3) _EveryoneValue = 1;
    if (self.MatureV == 1) _MatureValue = 0.3;
    if (self.MatureV == 2) _MatureValue = 0.7;
    if (self.MatureV == 3) _MatureValue = 1;
    
    if (self.TopicName.stringValue == self.TopicName.stringValue) {
        [self.namesInUse appendString:self.TopicName.stringValue];
        [self.console insertText:@"Add Topic button pressed, adding topic\n"];
        NSLog(@"AddTopic Button Pressed");
        
        // Adding New Topic Values To The Coding Text Feild;
        self.StuffValues = [NSMutableString stringWithFormat:@"\n 	%@.addTopic = function () { \n 		"
                                  "GDT.addTopics([{ \n			id: \"%@\", \n 						name: \"%@\".localize(\"game topic\"), \n 			genreWeightings:"
                                  "[%.1f, %.1f, %.1f, %.1f, %.1f, %.1f], \n 			audienceWeightings: [%.1f, %.1f, %.1f] \n 		} \n 		]); \n 	};\n ",
                             [self.ModName stringValue],[self.ModName stringValue],[_TopicName stringValue],self.ActionV,self.AdventureV,self.RpgV,self.SimulationV,self.StrategyV,_CasualV,self.YoungValue,self.EveryoneValue,self.MatureValue];
        [self.CS insertText:self.StuffValues];
        [self.console insertText:[NSString stringWithFormat:@"New Topic Values: %@", self.StuffValues]];
        
        // Adding New Topic Values To the save log values
        
        [self.Save appendString:[NSString stringWithFormat:@"554=%@/896=%.1f,%.1f,%.1f,%.1f,%.1f,%.1f/346978=%.1f,%.1f,%.1f'/\n",[_TopicName stringValue],self.ActionV,self.AdventureV,self.RpgV,self.SimulationV,self.StrategyV,_CasualV,self.YoungValue,self.EveryoneValue,self.MatureValue]];
        
        _SSS = true;
        
        // Sets the modification Info
    
        NSLog(@"New Topic Value: %@",self.StuffValues);
        [self.Modis addItemWithObjectValue:self.TopicName.stringValue];
        [self.Modis selectItemWithObjectValue:self.TopicName.stringValue];
        [self.modificationInfo setObject:self.namesInUse forKey:self.TopicName.stringValue];
        
        NSLog(@"New Topic Proccessed");
        [self.console insertText:@"New topic has been added\n"];
    }
}

#pragma mark Finish Button

- (IBAction)CreateMod:(id)sender {
    [self.console insertText:@"Finished button pressed, proccessing mod...\n"];
    NSLog(@"Finished Button Pressed");
    
    self.package = [NSMutableString stringWithFormat:@"{\n\"id\" : \"%@\",\n\"name\" : \"%@\",\n\"version\":\"%@\",\n\"author\":\"%@\",\n\"url\":\"%@\",\n\"description\" : \"%@\",\n\"main\" : \"./UltimateMM.js\",\n\"dependencies\" : {}\n}\n", [self.ModName stringValue], [self.ModName stringValue], [self.versionTXT stringValue], [self.authors stringValue], [self.URL stringValue], self.modDescription.string];
    self.js = [NSMutableString stringWithFormat:@"\n	var ready = function () {\n		%@.addTopic();\n		%@.addPlatform();\n		%@.addEvent();\n		%@.addResearch();\n	};\n\n	var error = function () {\n	};\n	GDT.loadJs([\"helpers/checks.js\",\n	\"api/persistence.js\",\n	\"api/events.js\",\n	\"api/platforms.js\",\n	\"api/topics.js\",\n	\"api/research.js\",\n	\"JS/CODE.js\"\n	], ready, error);\n", [self.ModName stringValue], [self.ModName stringValue], [self.ModName stringValue], [self.ModName stringValue]];

    self.ModText = [NSMutableString string];
    [self.ModText appendString:[NSString stringWithFormat:@"var %@ = {};\n(function () {\n%@\n})();", [self.ModName stringValue], self.CS.string]];
    
    NSWindow *keyTarget = [[NSApplication sharedApplication] keyWindow];
    NSSavePanel *spanel = [NSSavePanel savePanel];
    [spanel setCanCreateDirectories:NO];
    [spanel setCanSelectHiddenExtension:NO];
    [spanel setAllowedFileTypes:nil];
    [spanel setTreatsFilePackagesAsDirectories:YES];
    [spanel beginSheetModalForWindow:keyTarget  completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton)
        {
            NSError *error = nil;
            NSURL *directoryURL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:[[NSProcessInfo processInfo] globallyUniqueString]] isDirectory:YES];
            [[NSFileManager defaultManager] createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:&error];
            NSURL *fileURL1 = [directoryURL URLByAppendingPathComponent:self.ModName.stringValue];
            NSURL *fileURL2 = [directoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"/%@/JS", [self.ModName stringValue]]];
            NSURL *fileURL3 = [directoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"/%@/JS/CODE.js", [self.ModName stringValue]]];
            NSURL *fileURL4 = [directoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"/%@/package.json", [self.ModName stringValue]]];
            NSURL *fileURL5 = [directoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"/%@/UltimateMM.js", [self.ModName stringValue]]];
            NSURL *saveURL = [spanel URL];
            NSLog(@"%@", saveURL);
            if(_TTT == true) {
                
                NSLog(@"Mod Proccessing");
                NSFileManager *mngr = [NSFileManager defaultManager];
                error = nil;
                BOOL didWrite =[mngr createDirectoryAtURL:fileURL1 withIntermediateDirectories:YES attributes:nil error:&error];
                if (didWrite == NO) {
                    [self.console insertText:[NSString stringWithFormat:@"Directory main write error: %@\n", error]];
                    NSLog(@"Directory Main Write Error: %@", error);
                }
                error = nil;
                BOOL didWrite2 =[mngr createDirectoryAtURL:fileURL2 withIntermediateDirectories:YES attributes:nil error:&error];
                if (didWrite2 == NO) {
                    [self.console insertText:[NSString stringWithFormat:@"Directory co-main write error: %@\n", error]];
                    NSLog(@"Directory Co-Main Error: %@", error);
                }
                error = nil;
                BOOL didWrite3 = [self.ModText writeToURL:fileURL3 atomically:YES encoding:NSUTF8StringEncoding error:&error];
                if (didWrite3 == NO) {
                    [self.console insertText:[NSString stringWithFormat:@"topic.js write error: %@\n", error]];
                    NSLog(@"Topic.js Write Error: %@", error);
                }
                error = nil;
                BOOL didWrite4 = [self.package writeToURL:fileURL4 atomically:YES encoding:NSUTF8StringEncoding error:&error];
                if (didWrite4 == NO) {
                    [self.console insertText:[NSString stringWithFormat:@"package.json write error: %@\n", error]];
                    NSLog(@"package.json Write Error: %@", error);
                }
                error = nil;
                BOOL didWrite5 = [self.js writeToURL:fileURL5 atomically:YES encoding:NSUTF8StringEncoding error:&error];
                if (didWrite5 == NO) {
                    [self.console insertText:[NSString stringWithFormat:@"UltimateMM.js write error: %@\n", error]];
                    NSLog(@"UltimateMM.js Write Error: %@", error);
                }
                error = nil;
                BOOL didMove = [mngr moveItemAtURL:fileURL1 toURL:saveURL error:&error];
                if (didMove == NO) {
                    [self.console insertText:[NSString stringWithFormat:@"Topic.js move error: %@\n", error]];
                    NSLog(@"Topic Move Error: %@", error);
                }
                error = nil;
            }
            _TTT = false;
            NSFileManager *mngr = [NSFileManager defaultManager];
            [mngr trashItemAtURL:directoryURL resultingItemURL:nil error:&error];
        }
    }];
}

#pragma mark Other

- (IBAction)MCButton:(id)sender {
    [self.console insertText:@"MineCraft Button Pressed\n"];
    NSLog(@"MC Button Pressed");
    if (_Installed == true) {
        [_MainWindow close];
        [_MCSCREEN makeKeyAndOrderFront:nil];
    } else {
        _Installed = true;
        [_MainWindow close];
        [_MCSCREEN makeKeyAndOrderFront:nil];
    }
}
- (IBAction)BackM:(id)sender {
    [self.console insertText:@"MineCraft menu back button pressed\n"];
    NSLog(@"Back Button Pressed");
    [_MCSCREEN close];
    [_MainWindow makeKeyAndOrderFront:nil];
}
- (IBAction)BackServer:(id)sender {
    [self.console insertText:@"Minecraft server creation menu back button pressed\n"];
    NSLog(@"Back Button Pressed");
    [_MCSERVER close];
    [_MCSCREEN makeKeyAndOrderFront:nil];
}
- (IBAction)SERVER:(id)sender {
    [self.console insertText:@"Server button pressed\n"];
    NSLog(@"Server Button Pressed");
    [_MCSCREEN close];
    [_MCSERVER makeKeyAndOrderFront:nil];
}

#pragma mark Options Apply

- (IBAction)Apply:(id)sender {
    NSWindow *keyTarget = self.MainWindow;
    [self.console insertText:@"Options Apply button  pressed, saving options.\n"];
    NSLog(@"Options Apply Button Pressed");
    self.package = [NSMutableString stringWithFormat:@"{\n\"id\" : \"%@\",\n\"name\" : \"%@\",\n\"version\":\"%@\",\n\"author\":\"%@\",\n\"url\":\"%@\",\n\"description\" : \"%@\",\n\"main\" : \"./UltimateMM.js\",\n\"dependencies\" : {}\n}\n", [self.ModName stringValue], [self.ModName stringValue], [self.versionTXT stringValue], [self.authors stringValue], [self.URL stringValue], self.modDescription.string];
    if (self.mainMenuBox.hidden == true) {
        if ([self.Mode.stringValue isEqual: @"Normal"]) {
            NSRect frame = keyTarget.frame;
            
            frame.size.width = 948;
            frame.size.height = 540;
            self.modeValue = [NSMutableString stringWithFormat:@"Norm"];
            
            [self.MainWindow setFrame:frame display:NO animate:YES];
        } else if ([self.Mode.stringValue isEqual: @"Advanced"]) {
            NSRect frame = keyTarget.frame;
            
            frame.size.width = 1165;
            frame.size.height = 540;
            self.modeValue = [NSMutableString stringWithFormat:@"Adv"];
            
            [self.MainWindow setFrame:frame display:NO animate:YES];
        }else if ([self.Mode.stringValue isEqual: @"Proffesional"]) {
            NSRect frame = keyTarget.frame;
            
            frame.size.width = 1165;
            frame.size.height = 540;
            self.modeValue = [NSMutableString stringWithFormat:@"Pro"];
            
            [self.MainWindow setFrame:frame display:NO animate:YES];
        } else if ([self.Mode.stringValue isEqual: @"Developer"]) {
            NSRect frame = keyTarget.frame;
            
            frame.size.width = 1165;
            
            frame.size.height = 650;
            self.modeValue = [NSMutableString stringWithFormat:@"Dev"];
            [self.MainWindow setFrame:frame display:NO animate:YES];
        }

    }
    if ([self.Version.stringValue  isEqual: @"Alpha 7.9"]) {
        self.VersionL1.stringValue = @"Alpha 7.9";
        self.VersionL2.stringValue = @"Alpha 7.9";
        self.whatsNew.stringValue = @"Whats new?\n Added some new Ui and a new look!";
        self.EventB.hidden = YES;
        self.modif.hidden = YES;
        self.event1.hidden = YES;
        self.ModMenu.hidden = YES;
        self.rButton.hidden = YES;
        self.settingsA8.hidden = NO;
        self.settingsA9.hidden = YES;
        self.SaveB.hidden = YES;
        self.Load.hidden = YES;
        self.Load2.hidden = YES;
        self.versionValue = [NSMutableString stringWithFormat:@"A7.9"];
    } else {
        if ([self.Version.stringValue  isEqual: @"Alpha 8"]) {
            self.VersionL1.stringValue = @"Alpha 8";
            self.VersionL2.stringValue = @"Alpha 8";
            self.whatsNew.stringValue = @"Whats, new?\n A completely new look thats nice, new, clean, and fresh,\n New settings,\n New Beta Mode For Alpha 9,\n Added Events,\n Added Researches and Customizable features";
            self.EventB.hidden = NO;
            self.rButton.hidden = NO;
            self.Load.hidden = YES;
            self.modif.hidden = NO;
            self.event1.hidden = NO;
            self.openb.hidden = YES;
            self.ModMenu.hidden = NO;
            self.settingsA8.hidden = NO;
            self.settingsA9.hidden = YES;
            self.SaveB.hidden = YES;
            self.Load.hidden = YES;
            self.Load2.hidden = YES;
            self.versionValue = [NSMutableString stringWithFormat:@"A8"];
        } else if ([self.Version.stringValue isEqual: @"Alpha 9.1"]) {
            self.VersionL1.stringValue = @"Alpha 9.1";
            self.VersionL2.stringValue = @"Alpha 9.1";
            self.whatsNew.stringValue = @"Whats new?\n Alpha 9: New Look, \n Full file creating support, \n Users, \n Saving options.\n 9.1: Minor Bug Fixes";
            self.EventB.hidden = NO;
            self.SaveB.hidden = NO;
            self.Load.hidden = NO;
            self.Load2.hidden = NO;
            self.modif.hidden = NO;
            self.event1.hidden = NO;
            self.openb.hidden = NO;
            self.ModMenu.hidden = NO;
            self.rButton.hidden = NO;
            self.settingsA8.hidden = YES;
            self.settingsA9.hidden = NO;
            self.SaveB.hidden = NO;
            self.Load.hidden = YES;
            self.Load2.hidden = NO;
            self.prisonArchitectMainButton.enabled = NO;
            self.versionValue = [NSMutableString stringWithFormat:@"A9"];
        } else if ([self.Version.stringValue  isEqual: @"Developer"]) {
            self.VersionL1.stringValue = @"Dev";
            self.VersionL2.stringValue = @"Dev";
            self.whatsNew.stringValue = @"Currently in Developer Mode.";
            self.Load.hidden = YES;
        } else if ([self.Version.stringValue isEqual: @"Test A10"]) {
            self.VersionL1.stringValue = @"Test A10";
            self.VersionL2.stringValue = @"Test A10";
            self.whatsNew.stringValue = @"Whats new?\n Prison Architect support(WORK IN PROGRESS)";
            self.EventB.hidden = NO;
            self.SaveB.hidden = NO;
            self.Load.hidden = NO;
            self.Load2.hidden = NO;
            self.modif.hidden = NO;
            self.event1.hidden = NO;
            self.openb.hidden = NO;
            self.ModMenu.hidden = NO;
            self.rButton.hidden = NO;
            self.settingsA8.hidden = YES;
            self.settingsA9.hidden = NO;
            self.SaveB.hidden = NO;
            self.Load.hidden = YES;
            self.Load2.hidden = NO;
            self.prisonArchitectMainButton.enabled = YES;
            self.versionValue = [NSMutableString stringWithFormat:@"TA10"];
        }
    }
    if (self.TestBuild.state == true) {
        self.betaValue = [NSMutableString stringWithFormat:@"true"];
    } else if (self.TestBuild.state == true) {
        self.betaValue = [NSMutableString stringWithFormat:@"false"];
    }
    NSError* error = nil;
    NSString* applicationSupportDirectory = [self applicationSupportPath];
    NSString *directoryToMove = [NSString stringWithFormat:@"%@/UltimateMM", applicationSupportDirectory ];
    NSString *filePathToMoveSettings = [directoryToMove stringByAppendingPathComponent:@"settings.settings"];
    self.SettingsValues = [NSMutableString stringWithFormat:@"FullScreen:false;\nBetas:%@;\nUpdate Auto:false;\nVersion:%@;\nMode:%@;", self.betaValue, self.versionValue, self.modeValue];
    BOOL didWrite = [self.SettingsValues writeToFile:filePathToMoveSettings atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (didWrite == false) {
        NSLog(@"Error Saving settings with error: %@, gonna try again...", error);
        NSError* error = nil;
        NSString* applicationSupportDirectory = [self applicationSupportPath];
        NSString *directoryToMove = [NSString stringWithFormat:@"%@/UltimateMM", applicationSupportDirectory ];
        NSString *filePathToMoveSettings = [directoryToMove stringByAppendingPathComponent:@"settings.settings"];
        self.SettingsValues = [NSMutableString stringWithFormat:@"FullScreen:false;\nBetas:%@;\nUpdate Auto:false;\nVersion:%@;\nMode:%@;", self.betaValue, self.versionValue, self.modeValue];
        BOOL didWrite = [self.SettingsValues writeToFile:filePathToMoveSettings atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (didWrite == false) {
            NSLog(@"AGAIN! Error Saving settings with error: %@", error);
            NSLog(@"Saving Error to Error.log!");
            NSString* errorTxt = [NSString stringWithFormat:@"%@", error];
            NSString* applicationSupportDirectory = [self applicationSupportPath];
            NSString *directoryToMove = [NSString stringWithFormat:@"%@/UltimateMM", applicationSupportDirectory ];
            NSString *filePathToMoveSettings = [directoryToMove stringByAppendingPathComponent:@"Error.log"];
            error = nil;
            BOOL didWrite2 = [errorTxt writeToFile:filePathToMoveSettings atomically:YES encoding:NSUTF8StringEncoding error:&error];
            if (didWrite2 == false) {
                NSLog(@"Error'd on writing error! Error Code: %@", error);
            }

        }
    }

}

#pragma mark Options TestBuild

- (IBAction)TestBuild:(id)sender {
    [self.console insertText:@"Allow Test build button pressed\n"];
    NSLog(@"Allow Test Build Button Pressed");
    if (self.TestBuild.state == true) {
        [self.console insertText:@"Test Build state is true\n"];
    } else {
        [self.console insertText:@"Test build state is false\n"];
        [self.Version selectItemWithObjectValue:@"Alpha 9.1"];
    }
}

#pragma mark Modification Selector

- (IBAction)ModificationSelector:(id)sender {
    [self.console insertText:@"Modification selected\n"];
    [self.modificationInfo objectForKey:self.Modis.stringValue];
}
#pragma mark Event events
- (IBAction)Buttons:(id)sender {
    [self.console insertText:@"Event Buttons changed.\n"];
    if ([self.Buttons1111.stringValue  isEqual: @"1"]) {
        self.BT1.hidden =  NO;
        self.BT2.hidden =  YES;
        self.BT3.hidden =  YES;
    } else {
        if ([self.Buttons1111.stringValue  isEqual: @"2"]) {
            self.BT1.hidden =  NO;
            self.BT2.hidden =  NO;
            self.BT3.hidden =  YES;
        } else {
            self.BT1.hidden =  NO;
            self.BT2.hidden =  NO;
            self.BT3.hidden =  NO;
        }
    }
}
- (IBAction)Event:(id)sender {
    [self.console insertText:@"Event button clicked\n"];
    if (self.tClicked4 == false) {
        self.BCKG4.hidden = NO;
        self.tClicked= false;
        self.tClicked2 = false;
        self.tClicked3 = false;
        self.tClicked4 = true;
        self.BCKG.hidden = YES;
        self.BCKG2.hidden = YES;
        self.BCKG3.hidden = YES;
        self.BCKG5.hidden = YES;
    } else if (self.tClicked4 == true) {
        self.BCKG4.hidden = YES;
        self.tClicked4 = false;
        self.BCKG.hidden = YES;
        self.BCKG2.hidden = YES;
        self.BCKG3.hidden = YES;
    }
}
- (IBAction)EventAdd:(id)sender {
    [self.console insertText:@"Event add button pressed (Does nothing!!!!!)\n"];
    if ([self.Buttons1111.stringValue  isEqual: @"1"]) {
            self.Topic = [NSMutableString string];
            [self.CS insertText:[NSString stringWithFormat:@""]];
    }
    _TTT = true;
    _SSS = true;
    [self.Modis addItemWithObjectValue:self.Eventname.stringValue];
    [self.Modis selectItemWithObjectValue:self.Eventname.stringValue];
}

#pragma mark Load

- (IBAction)Load:(id)sender {
    //Loads the entire mod.
    [self.console insertText:@"Load Button Pressed\n"];
    NSLog(@"Load Button Pressed");
    NSWindow *keyTarget = [[NSApplication sharedApplication] keyWindow];
    NSFileManager *mngr = [NSFileManager defaultManager];
    
    NSOpenPanel* opanel = [NSOpenPanel openPanel];
    [opanel setCanCreateDirectories:NO];
    [opanel setCanSelectHiddenExtension:NO];
    [opanel setCanChooseFiles:NO];
    [opanel setCanChooseDirectories:YES];
    [opanel setAllowsMultipleSelection:NO];
    [opanel setMessage:@"Choose the folder of your mod you'd like to load."];
    [opanel beginSheetModalForWindow:keyTarget completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton)
        {
            NSError *error = nil;
            NSURL* URL = [opanel URL];
            NSLog(@"%@", URL);
            [self.console insertText:@"Reading files\n"];
            NSLog(@"Reading files");
            NSString* path = [NSString stringWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:&error];
            NSString* codePath = [NSString stringWithFormat:@"%@/JS/CODE.js", path];
            NSLog(@"Code.js Path: %@", codePath);
            NSString* packagePath = [NSString stringWithFormat:@"%@/package.json", path];
            NSLog(@"package.json Path: %@", packagePath);
            NSString* ultimatemmPath = [NSString stringWithFormat:@"%@/UltimateMM.js", path];
            NSLog(@"UltimateMM.js Path: %@", ultimatemmPath);
            if ([mngr fileExistsAtPath:codePath] == true) {
                if ([mngr fileExistsAtPath:packagePath] == true) {
                    if ([mngr fileExistsAtPath:ultimatemmPath] == true) {
                        [self.console insertText:@"Prep to go throguh all files and add values\n"];
                        NSLog(@"Preparing to go through all files and add values.");
                        NSString* CODE = [NSMutableString stringWithContentsOfFile:codePath encoding:NSUTF8StringEncoding error:&error];
                        NSString* package = [NSMutableString stringWithContentsOfFile:packagePath encoding:NSUTF8StringEncoding error:&error];
                        NSScanner *scanner = [NSScanner scannerWithString:CODE];
                        //Scans for code in CODE.js
                        scanner = [NSScanner scannerWithString:CODE];
                        [scanner scanUpToString:@"(function () {" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"(function () {" intoString:nil];
                            if([scanner scanUpToString:@"})();" intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"(function () { %@ })();", rMV]];
                                NSLog(@"(function () { %@ })();", rMV);
                                self.CS.string = @"";
                                [self.CS insertText:rMV];
                            }
                            [scanner scanUpToString:@"(function () {" intoString:nil];
                        }
                        [self.console insertText:@"Loaded Code...\n"];
                        NSLog(@"Loaded Code...");
                        [self.console insertText:@"Moving on to version in package.json\n"];
                        NSLog(@"Moving on to version in package.json!");
                        //Scans for values in package.json
                        scanner = [NSScanner scannerWithString:package];
                        [scanner scanUpToString:@"\"version\":\"" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"\"version\":\"" intoString:nil];
                            if([scanner scanUpToString:@"\"," intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"version: %@", rMV]];
                                NSLog(@"version: %@", rMV);
                                self.versionTXT.stringValue = rMV;
                            }
                            [scanner scanUpToString:@"\"version\":\"" intoString:nil];
                        }
                        [self.console insertText:@"Loaded Version...\n"];
                        NSLog(@"Loaded Version...");
                        [self.console insertText:@"Moving on to mod name in package.json\n"];
                        NSLog(@"Moving on to mod name in package.json!");
                        scanner = [NSScanner scannerWithString:package];
                        [scanner scanUpToString:@"\"name\" : \"" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"\"name\" : \"" intoString:nil];
                            if([scanner scanUpToString:@"\"," intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"Mod Name: %@", rMV]];
                                NSLog(@"Mod Name: %@", rMV);
                                self.ModName.stringValue = rMV;
                            }
                            [scanner scanUpToString:@"\"name\" : \"" intoString:nil];
                        }
                        [self.console insertText:@"Loaded Mod Name...\n"];
                        NSLog(@"Loaded Mod Name...");
                        [self.console insertText:@"Moving on to author in package.json\n"];
                        NSLog(@"Moving on to author in package.json!");
                        scanner = [NSScanner scannerWithString:package];
                        [scanner scanUpToString:@"\"author\" : \"" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"\"author\" : \"" intoString:nil];
                            if([scanner scanUpToString:@"\"," intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"Author: %@", rMV]];
                                NSLog(@"Author: %@", rMV);
                                self.authors.stringValue = rMV;
                            }
                            [scanner scanUpToString:@"\"author\" : \"" intoString:nil];
                        }
                        [self.console insertText:@"Loaded Author(S)...\n"];
                        NSLog(@"Loaded Author(S)...");
                        [self.console insertText:@"Moving on to URL in package.json\n"];
                        NSLog(@"Moving on to URL in package.json!");
                        scanner = [NSScanner scannerWithString:package];
                        [scanner scanUpToString:@"\"url\" : \"" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"\"url\" : \"" intoString:nil];
                            if([scanner scanUpToString:@"\"," intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"URL: %@", rMV]];
                                NSLog(@"URL: %@", rMV);
                                self.URL.stringValue = rMV;
                            }
                            [scanner scanUpToString:@"\"url\" : \"" intoString:nil];
                        }
                        [self.console insertText:@"Loaded URL...\n"];
                        NSLog(@"Loaded URL...");
                        [self.console insertText:@"Moving on to desc in package.json\n"];
                        NSLog(@"Moving on to description in package.json!");
                        scanner = [NSScanner scannerWithString:package];
                        [scanner scanUpToString:@"\"description\" : \"" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"\"description\" : \"" intoString:nil];
                            if([scanner scanUpToString:@"\"," intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"Description: %@", rMV]];
                                NSLog(@"Description: %@", rMV);
                                self.modDescription.string = @"";
                                [self.modDescription insertText:rMV];
                            }
                            [scanner scanUpToString:@"\"description\" : \"" intoString:nil];
                        }
                    }
                }
            }
        }
    }];
}

#pragma mark Open

- (IBAction)Open:(id)sender {
    //Loads the entire mod.
    [self.console insertText:@"Load Button Pressed\n"];
    NSLog(@"Load Button Pressed");
    NSWindow *keyTarget = [[NSApplication sharedApplication] keyWindow];
    NSFileManager *mngr = [NSFileManager defaultManager];
    
    NSOpenPanel* opanel = [NSOpenPanel openPanel];
    [opanel setCanCreateDirectories:NO];
    [opanel setCanSelectHiddenExtension:NO];
    [opanel setCanChooseFiles:NO];
    [opanel setCanChooseDirectories:YES];
    [opanel setAllowsMultipleSelection:NO];
    [opanel setMessage:@"Choose the folder of your mod you'd like to load."];
    [opanel beginSheetModalForWindow:keyTarget completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton)
        {
            NSError *error = nil;
            NSURL* URL = [opanel URL];
            NSLog(@"%@", URL);
            [self.console insertText:@"Reading files\n"];
            NSLog(@"Reading files");
            NSString* path = [NSString stringWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:&error];
            NSString* codePath = [NSString stringWithFormat:@"%@/JS/CODE.js", path];
            NSLog(@"Code.js Path: %@", codePath);
            NSString* packagePath = [NSString stringWithFormat:@"%@/package.json", path];
            NSLog(@"package.json Path: %@", packagePath);
            NSString* ultimatemmPath = [NSString stringWithFormat:@"%@/UltimateMM.js", path];
            NSLog(@"UltimateMM.js Path: %@", ultimatemmPath);
            if ([mngr fileExistsAtPath:codePath] == true) {
                if ([mngr fileExistsAtPath:packagePath] == true) {
                    if ([mngr fileExistsAtPath:ultimatemmPath] == true) {
                        [self.console insertText:@"Prep to go throguh all files and add values\n"];
                        NSLog(@"Preparing to go through all files and add values.");
                        NSString* CODE = [NSMutableString stringWithContentsOfFile:codePath encoding:NSUTF8StringEncoding error:&error];
                        NSString* package = [NSMutableString stringWithContentsOfFile:packagePath encoding:NSUTF8StringEncoding error:&error];
                        NSScanner *scanner = [NSScanner scannerWithString:CODE];
                        //Scans for code in CODE.js
                        scanner = [NSScanner scannerWithString:CODE];
                        [scanner scanUpToString:@"(function () {" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"(function () {" intoString:nil];
                            if([scanner scanUpToString:@"})();" intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"(function () { %@ })();", rMV]];
                                NSLog(@"(function () { %@ })();", rMV);
                                self.CS.string = @"";
                                [self.CS insertText:rMV];
                            }
                            [scanner scanUpToString:@"(function () {" intoString:nil];
                        }
                        [self.console insertText:@"Loaded Code...\n"];
                        NSLog(@"Loaded Code...");
                        [self.console insertText:@"Moving on to version in package.json\n"];
                        NSLog(@"Moving on to version in package.json!");
                        //Scans for values in package.json
                        scanner = [NSScanner scannerWithString:package];
                        [scanner scanUpToString:@"\"version\":\"" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"\"version\":\"" intoString:nil];
                            if([scanner scanUpToString:@"\"," intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"version: %@", rMV]];
                                NSLog(@"version: %@", rMV);
                                self.versionTXT.stringValue = rMV;
                            }
                            [scanner scanUpToString:@"\"version\":\"" intoString:nil];
                        }
                        [self.console insertText:@"Loaded Version...\n"];
                        NSLog(@"Loaded Version...");
                        [self.console insertText:@"Moving on to mod name in package.json\n"];
                        NSLog(@"Moving on to mod name in package.json!");
                        scanner = [NSScanner scannerWithString:package];
                        [scanner scanUpToString:@"\"name\" : \"" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"\"name\" : \"" intoString:nil];
                            if([scanner scanUpToString:@"\"," intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"Mod Name: %@", rMV]];
                                NSLog(@"Mod Name: %@", rMV);
                                self.ModName.stringValue = rMV;
                            }
                            [scanner scanUpToString:@"\"name\" : \"" intoString:nil];
                        }
                        [self.console insertText:@"Loaded Mod Name...\n"];
                        NSLog(@"Loaded Mod Name...");
                        [self.console insertText:@"Moving on to author in package.json\n"];
                        NSLog(@"Moving on to author in package.json!");
                        scanner = [NSScanner scannerWithString:package];
                        [scanner scanUpToString:@"\"author\" : \"" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"\"author\" : \"" intoString:nil];
                            if([scanner scanUpToString:@"\"," intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"Author: %@", rMV]];
                                NSLog(@"Author: %@", rMV);
                                self.authors.stringValue = rMV;
                            }
                            [scanner scanUpToString:@"\"author\" : \"" intoString:nil];
                        }
                        [self.console insertText:@"Loaded Author(S)...\n"];
                        NSLog(@"Loaded Author(S)...");
                        [self.console insertText:@"Moving on to URL in package.json\n"];
                        NSLog(@"Moving on to URL in package.json!");
                        scanner = [NSScanner scannerWithString:package];
                        [scanner scanUpToString:@"\"url\" : \"" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"\"url\" : \"" intoString:nil];
                            if([scanner scanUpToString:@"\"," intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"URL: %@", rMV]];
                                NSLog(@"URL: %@", rMV);
                                self.URL.stringValue = rMV;
                            }
                            [scanner scanUpToString:@"\"url\" : \"" intoString:nil];
                        }
                        [self.console insertText:@"Loaded URL...\n"];
                        NSLog(@"Loaded URL...");
                        [self.console insertText:@"Moving on to desc in package.json\n"];
                        NSLog(@"Moving on to description in package.json!");
                        scanner = [NSScanner scannerWithString:package];
                        [scanner scanUpToString:@"\"description\" : \"" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"\"description\" : \"" intoString:nil];
                            if([scanner scanUpToString:@"\"," intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"Description: %@", rMV]];
                                NSLog(@"Description: %@", rMV);
                                self.modDescription.string = @"";
                                [self.modDescription insertText:rMV];
                            }
                            [scanner scanUpToString:@"\"description\" : \"" intoString:nil];
                        }
                    }
                }
            }
        }
    }];
}
#pragma mark Tab Bar Buttons
- (IBAction)NewTopic:(id)sender {
    NSLog(@"Topic Button Pressed");
    if (self.tClicked == false) {
        _AddButton.hidden = false;
        _TopicName.hidden = false;
        _EveryoneLabel.hidden = false;
        _YoungLabel.hidden = false;
        _MatureLabel.hidden = false;
        _ActionP.hidden = false;
        _AdventureP.hidden = false;
        _RPGP.hidden = false;
        _SimP.hidden = false;
        _StrategyP.hidden = false;
        _CasualP.hidden = false;
        _BCKG.hidden = NO;
        _Action.hidden = false;
        _Adventure.hidden = false;
        _RPG.hidden = false;
        _Simulation.hidden = false;
        _Strategy.hidden = false;
        _Casual.hidden = false;
        _Young.hidden = false;
        _Everyone.hidden = false;
        _Mature.hidden = false;
        self.tClicked = true;
        self.BCKG2.hidden = YES;
        self.BCKG3.hidden = YES;
        self.BCKG4.hidden = YES;
        self.BCKG5.hidden = YES;
        self.tClicked2= false;
        self.tClicked3 = false;
        self.tClicked4 = false;
        self.tClicked5 = false;
    } else {
        _AddButton.hidden = true;
        _TopicName.hidden = true;
        _EveryoneLabel.hidden = true;
        _YoungLabel.hidden = true;
        _MatureLabel.hidden = true;
        _ActionP.hidden = true;
        _AdventureP.hidden = true;
        _RPGP.hidden = true;
        _SimP.hidden = true;
        _StrategyP.hidden = true;
        _CasualP.hidden = true;
        _BCKG.hidden = YES;
        _Action.hidden = true;
        _Adventure.hidden = true;
        _RPG.hidden = true;
        _Simulation.hidden = true;
        _Strategy.hidden = true;
        _Casual.hidden = true;
        _Young.hidden = true;
        _Everyone.hidden = true;
        _Mature.hidden = true;
        self.tClicked = false;
    }
}
- (IBAction)NewEvent:(id)sender {
    if (self.tClicked4 == false) {
        self.BCKG4.hidden = NO;
        self.tClicked= false;
        self.tClicked2 = false;
        self.tClicked3 = false;
        self.tClicked4 = true;
        self.tClicked5 = false;
        self.BCKG.hidden = YES;
        self.BCKG2.hidden = YES;
        self.BCKG3.hidden = YES;
        self.BCKG5.hidden = YES;
    } else {
        self.BCKG4.hidden = YES;
        self.tClicked4 = false;
    }
}
- (IBAction)Finish:(id)sender {
    NSLog(@"Finished Button Pressed");
    
    self.package = [NSMutableString stringWithFormat:@"{\n\"id\" : \"%@\",\n\"name\" : \"%@\",\n\"version\":\"%@\",\n\"author\":\"%@\",\n\"url\":\"%@\",\n\"description\" : \"%@\",\n\"main\" : \"./UltimateMM.js\",\n\"dependencies\" : {}\n}\n", [self.ModName stringValue], [self.ModName stringValue], [self.versionTXT stringValue], [self.authors stringValue], [self.URL stringValue], self.modDescription.string];
    self.js = [NSMutableString stringWithFormat:@"\n	var ready = function () {\n		%@.addTopic();\n		%@.addPlatform();\n		%@.addEvent();\n		%@.addResearch();\n	};\n\n	var error = function () {\n	};\n	GDT.loadJs([\"helpers/checks.js\",\n	\"api/persistence.js\",\n	\"api/events.js\",\n	\"api/platforms.js\",\n	\"api/topics.js\",\n	\"api/research.js\",\n	\"JS/CODE.js\"\n	], ready, error);\n", [self.ModName stringValue], [self.ModName stringValue], [self.ModName stringValue], [self.ModName stringValue]];
    
    self.ModText = [NSMutableString string];
    [self.ModText appendString:[NSString stringWithFormat:@"var %@ = {};\n(function () {\n%@\n})();", [self.ModName stringValue], self.CS]];
    NSWindow *keyTarget = [[NSApplication sharedApplication] keyWindow];
    NSSavePanel *spanel = [NSSavePanel savePanel];
    [spanel setCanCreateDirectories:NO];
    [spanel setCanSelectHiddenExtension:NO];
    [spanel setAllowedFileTypes:nil];
    [spanel setTreatsFilePackagesAsDirectories:YES];
    [spanel beginSheetModalForWindow:keyTarget  completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton)
        {
            NSError *error = nil;
            NSURL *directoryURL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:[[NSProcessInfo processInfo] globallyUniqueString]] isDirectory:YES];
            [[NSFileManager defaultManager] createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:&error];
            NSURL *fileURL1 = [directoryURL URLByAppendingPathComponent:self.ModName.stringValue];
            NSURL *fileURL2 = [directoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"/%@/JS", [self.ModName stringValue]]];
            NSURL *fileURL3 = [directoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"/%@/JS/CODE.js", [self.ModName stringValue]]];
            NSURL *fileURL4 = [directoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"/%@/package.json", [self.ModName stringValue]]];
            NSURL *fileURL5 = [directoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"/%@/UltimateMM.js", [self.ModName stringValue]]];
            NSURL *saveURL = [spanel URL];
            NSLog(@"%@", saveURL);
            if(_TTT == true) {
                
                NSLog(@"Mod Proccessing");
                NSFileManager *mngr = [NSFileManager defaultManager];
                error = nil;
                BOOL didWrite =[mngr createDirectoryAtURL:fileURL1 withIntermediateDirectories:YES attributes:nil error:&error];
                if (didWrite == NO) {
                    NSLog(@"Directory Main Write Error: %@", error);
                }
                error = nil;
                BOOL didWrite2 =[mngr createDirectoryAtURL:fileURL2 withIntermediateDirectories:YES attributes:nil error:&error];
                if (didWrite2 == NO) {
                    NSLog(@"Directory Co-Main Error: %@", error);
                }
                error = nil;
                BOOL didWrite3 = [self.ModText writeToURL:fileURL3 atomically:YES encoding:NSUTF8StringEncoding error:&error];
                if (didWrite3 == NO) {
                    NSLog(@"Topic.js Write Error: %@", error);
                }
                error = nil;
                BOOL didWrite4 = [self.package writeToURL:fileURL4 atomically:YES encoding:NSUTF8StringEncoding error:&error];
                if (didWrite4 == NO) {
                    NSLog(@"package.json Write Error: %@", error);
                }
                error = nil;
                BOOL didWrite5 = [self.js writeToURL:fileURL5 atomically:YES encoding:NSUTF8StringEncoding error:&error];
                if (didWrite5 == NO) {
                    NSLog(@"UltimateMM.js Write Error: %@", error);
                }
                error = nil;
                BOOL didMove = [mngr moveItemAtURL:fileURL1 toURL:saveURL error:&error];
                if (didMove == NO) {
                    NSLog(@"Topic Move Error: %@", error);
                }
                error = nil;
            }
            _TTT = false;
            NSFileManager *mngr = [NSFileManager defaultManager];
            [mngr trashItemAtURL:directoryURL resultingItemURL:nil error:&error];
        }
    }];

}
- (IBAction)CustomScriptMenuItem:(id)sender {
    NSLog(@"Custom Button Pressed");
    if (self.tClicked3 == false) {
        self.BCKG3.hidden = NO;
        self.tClicked3 = true;
        self.BCKG.hidden = YES;
        self.BCKG2.hidden = YES;
        self.BCKG4.hidden = YES;
        self.BCKG5.hidden = YES;
        self.tClicked = false;
        self.tClicked2 = false;
        self.tClicked3 = true;
        self.tClicked4 = false;
        self.tClicked5 = false;
    } else {
        self.BCKG3.hidden = YES;
        self.tClicked3 = false;
    }
}

- (IBAction)ModMenuItem:(id)sender {
    NSLog(@"Mods Button Pressed");
    if (self.tClicked2 == false) {
        self.BCKG2.hidden = NO;
        self.tClicked2 = true;
        self.BCKG.hidden = YES;
        self.BCKG3.hidden = YES;
        self.BCKG4.hidden = YES;
        self.BCKG5.hidden = YES;
        self.tClicked = false;
        self.tClicked2 = true;
        self.tClicked3 = false;
        self.tClicked4 = false;
        self.tClicked5 = false;
    } else {
        self.BCKG2.hidden = YES;
        self.tClicked2 = false;
    }
}

#pragma mark Research Add Button

- (IBAction)AddResearch:(id)sender {
    NSLog(@"Add Research Button Pressed");
   // self.StuffValues = [NSMutableString string];
    //NSString *text = [[self.CS textStorage] string];
    //self.CSToMove = [NSMutableString string];
    //[self.CSToMove appendString:text];
    //self.CS.string = @"";
    //self.CSToMove.string = @"";
    //NSLog(@"Code Moved over, %@", self.CSToMove);
    [self.StuffValues appendString:[NSString stringWithFormat:@"	%@.addResearch = function () {\n		GDT.addResearchItem(\n		{\n			id: \"%@\",\n			name: \"%@\".localize(),\n			v: %@,\n			canResearch: function (company) {\n			return LevelCalculator.getMissionLevel(\"%@\") > %@\n			},\n			category: \"%@\",\n			categoryDisplayName: '%@'.localize()\n		});\n	};\n", [self.ModName stringValue], [self.rName stringValue], [self.rName stringValue], [self.techLevel stringValue], [self.whereCan stringValue], [self.whereCanText stringValue], [self.whereCan stringValue], [self.whereCan stringValue]]];
    [self.CS insertText:self.StuffValues];
    NSLog(@"New Research Values: %@", self.StuffValues);
    //[self.CS insertText:[NSString stringWithFormat:@"var %@ = {};\n(function () {\n%@\n%@\n})();", [self.ModName stringValue], self.CSToMove, self.StuffValues]];
    [self.Modis addItemWithObjectValue:self.rName.stringValue];
    [self.Modis selectItemWithObjectValue:self.rName.stringValue];
    _TTT = true;
    _SSS = true;
}

#pragma mark Research Menu Item

- (IBAction)AddResearchMenuItem:(id)sender {
    NSLog(@"Research Button Pressed");
    if (self.tClicked5 == false) {
        self.BCKG.hidden = YES;
        self.BCKG2.hidden = YES;
        self.BCKG3.hidden = YES;
        self.BCKG4.hidden = YES;
        self.BCKG5.hidden = NO;
        self.tClicked = false;
        self.tClicked2 = true;
        self.tClicked3 = false;
        self.tClicked4 = false;
        self.tClicked5 = true;
    } else if (self.tClicked5 == true) {
        self.BCKG5.hidden = YES;
        self.tClicked5 = false;
    }
}

#pragma mark Research

- (IBAction)ShowResarch:(id)sender {
    NSLog(@"Research Button Pressed");
    if (self.tClicked5 == false) {
        self.BCKG.hidden = YES;
        self.BCKG2.hidden = YES;
        self.BCKG3.hidden = YES;
        self.BCKG4.hidden = YES;
        self.BCKG5.hidden = NO;
        self.tClicked = false;
        self.tClicked2 = true;
        self.tClicked3 = false;
        self.tClicked4 = false;
        self.tClicked5 = true;
    } else if (self.tClicked5 == true) {
        self.BCKG5.hidden = YES;
        self.tClicked5 = false;
    }
}

#pragma mark Tab Bars and other

- (IBAction)SearchR:(id)sender {
}
- (IBAction)Load2:(id)sender {
    //Loads the entire mod.
    [self.console insertText:@"Load Button Pressed\n"];
    NSLog(@"Load Button Pressed");
    NSWindow *keyTarget = [[NSApplication sharedApplication] keyWindow];
    NSFileManager *mngr = [NSFileManager defaultManager];
    
    NSOpenPanel* opanel = [NSOpenPanel openPanel];
    [opanel setCanCreateDirectories:NO];
    [opanel setCanSelectHiddenExtension:NO];
    [opanel setCanChooseFiles:NO];
    [opanel setCanChooseDirectories:YES];
    [opanel setAllowsMultipleSelection:NO];
    [opanel setMessage:@"Choose the folder of your mod you'd like to load."];
    [opanel beginSheetModalForWindow:keyTarget completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton)
        {
            NSError *error = nil;
            NSURL* URL = [opanel URL];
            NSLog(@"%@", URL);
            [self.console insertText:@"Reading files\n"];
            NSLog(@"Reading files");
            NSString* path = [NSString stringWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:&error];
            NSString* codePath = [NSString stringWithFormat:@"%@/JS/CODE.js", path];
            NSLog(@"Code.js Path: %@", codePath);
            NSString* packagePath = [NSString stringWithFormat:@"%@/package.json", path];
            NSLog(@"package.json Path: %@", packagePath);
            NSString* ultimatemmPath = [NSString stringWithFormat:@"%@/UltimateMM.js", path];
            NSLog(@"UltimateMM.js Path: %@", ultimatemmPath);
            if ([mngr fileExistsAtPath:codePath] == true) {
                if ([mngr fileExistsAtPath:packagePath] == true) {
                    if ([mngr fileExistsAtPath:ultimatemmPath] == true) {
                        [self.console insertText:@"Prep to go throguh all files and add values\n"];
                        NSLog(@"Preparing to go through all files and add values.");
                        NSString* CODE = [NSMutableString stringWithContentsOfFile:codePath encoding:NSUTF8StringEncoding error:&error];
                        NSString* package = [NSMutableString stringWithContentsOfFile:packagePath encoding:NSUTF8StringEncoding error:&error];
                        NSScanner *scanner = [NSScanner scannerWithString:CODE];
                        //Scans for code in CODE.js
                        scanner = [NSScanner scannerWithString:CODE];
                        [scanner scanUpToString:@"(function () {" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"(function () {" intoString:nil];
                            if([scanner scanUpToString:@"})();" intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"(function () { %@ })();", rMV]];
                                NSLog(@"(function () { %@ })();", rMV);
                                self.CS.string = @"";
                                [self.CS insertText:rMV];
                            }
                            [scanner scanUpToString:@"(function () {" intoString:nil];
                        }
                        [self.console insertText:@"Loaded Code...\n"];
                        NSLog(@"Loaded Code...");
                        [self.console insertText:@"Moving on to version in package.json\n"];
                        NSLog(@"Moving on to version in package.json!");
                        //Scans for values in package.json
                        scanner = [NSScanner scannerWithString:package];
                        [scanner scanUpToString:@"\"version\":\"" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"\"version\":\"" intoString:nil];
                            if([scanner scanUpToString:@"\"," intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"version: %@", rMV]];
                                NSLog(@"version: %@", rMV);
                                self.versionTXT.stringValue = rMV;
                            }
                            [scanner scanUpToString:@"\"version\":\"" intoString:nil];
                        }
                        [self.console insertText:@"Loaded Version...\n"];
                        NSLog(@"Loaded Version...");
                        [self.console insertText:@"Moving on to mod name in package.json\n"];
                        NSLog(@"Moving on to mod name in package.json!");
                        scanner = [NSScanner scannerWithString:package];
                        [scanner scanUpToString:@"\"name\" : \"" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"\"name\" : \"" intoString:nil];
                            if([scanner scanUpToString:@"\"," intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"Mod Name: %@", rMV]];
                                NSLog(@"Mod Name: %@", rMV);
                                self.ModName.stringValue = rMV;
                            }
                            [scanner scanUpToString:@"\"name\" : \"" intoString:nil];
                        }
                        [self.console insertText:@"Loaded Mod Name...\n"];
                        NSLog(@"Loaded Mod Name...");
                        [self.console insertText:@"Moving on to author in package.json\n"];
                        NSLog(@"Moving on to author in package.json!");
                        scanner = [NSScanner scannerWithString:package];
                        [scanner scanUpToString:@"\"author\" : \"" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"\"author\" : \"" intoString:nil];
                            if([scanner scanUpToString:@"\"," intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"Author: %@", rMV]];
                                NSLog(@"Author: %@", rMV);
                                self.authors.stringValue = rMV;
                            }
                            [scanner scanUpToString:@"\"author\" : \"" intoString:nil];
                        }
                        [self.console insertText:@"Loaded Author(S)...\n"];
                        NSLog(@"Loaded Author(S)...");
                        [self.console insertText:@"Moving on to URL in package.json\n"];
                        NSLog(@"Moving on to URL in package.json!");
                        scanner = [NSScanner scannerWithString:package];
                        [scanner scanUpToString:@"\"url\" : \"" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"\"url\" : \"" intoString:nil];
                            if([scanner scanUpToString:@"\"," intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"URL: %@", rMV]];
                                NSLog(@"URL: %@", rMV);
                                self.URL.stringValue = rMV;
                            }
                            [scanner scanUpToString:@"\"url\" : \"" intoString:nil];
                        }
                        [self.console insertText:@"Loaded URL...\n"];
                        NSLog(@"Loaded URL...");
                        [self.console insertText:@"Moving on to desc in package.json\n"];
                        NSLog(@"Moving on to description in package.json!");
                        scanner = [NSScanner scannerWithString:package];
                        [scanner scanUpToString:@"\"description\" : \"" intoString:nil];
                        while(![scanner isAtEnd]) {
                            NSString *rMV = nil;
                            [scanner scanString:@"\"description\" : \"" intoString:nil];
                            if([scanner scanUpToString:@"\"," intoString:&rMV]) {
                                [self.console insertText:[NSString stringWithFormat:@"Description: %@", rMV]];
                                NSLog(@"Description: %@", rMV);
                                self.modDescription.string = @"";
                                [self.modDescription insertText:rMV];
                            }
                            [scanner scanUpToString:@"\"description\" : \"" intoString:nil];
                        }
                    }
                }
            }
        }
    }];

}


#pragma mark Prison Architect

#pragma mark Main Menu Button Clicked

- (IBAction)prisonArchitectMainMenuButtonPressed:(id)sender {
    NSLog(@"Prison Architect Main Menu Button Has been clicked");
    [self.console insertText:@"Prison Architect main menu button has been clicked\n"];
    self.mainMenuBox.hidden = true;
    [self.console insertText:@"Main Menu has been made hidden\n"];
    self.prisonArchitectMainMenu.hidden = false;
    [self.console insertText:@"Prison Architect main menu has been made visible\n"];
    NSWindow *keyTarget = self.MainWindow;
    if ([self.Mode.stringValue isEqual: @"Normal"]) {
        [self.console insertText:@"Setting to normal\n"];
        NSRect frame = keyTarget.frame;
        
        frame.size.width = 948;
        frame.size.height = 530;
        self.modeValue = [NSMutableString stringWithFormat:@"Norm"];
        
        [self.MainWindow setFrame:frame display:NO animate:YES];
    } else if ([self.Mode.stringValue isEqual: @"Advanced"]) {
        [self.console insertText:@"Setting to advanced\n"];
        NSRect frame = keyTarget.frame;
        
        frame.size.width = 1165;
        frame.size.height = 530;
        self.modeValue = [NSMutableString stringWithFormat:@"Adv"];
        
        [self.MainWindow setFrame:frame display:NO animate:YES];
    }else if ([self.Mode.stringValue isEqual: @"Proffesional"]) {
        [self.console insertText:@"Setting to Proffesional\n"];
        NSRect frame = keyTarget.frame;
        
        frame.size.width = 1165;
        frame.size.height = 530;
        self.modeValue = [NSMutableString stringWithFormat:@"Pro"];
        
        [self.MainWindow setFrame:frame display:NO animate:YES];
    } else if ([self.Mode.stringValue isEqual: @"Developer"]) {
        [self.console insertText:@"Setting to Developer\n"];
        NSRect frame = keyTarget.frame;
        
        frame.size.width = 1165;
        
        frame.size.height = 650;
        self.modeValue = [NSMutableString stringWithFormat:@"Dev"];
        [self.MainWindow setFrame:frame display:NO animate:YES];
        if (self.DevMode == 1) {
            [self.Version addItemWithObjectValue:@"Developer"];
            self.DevMode = 0;
        } else {
            [self.Version removeItemWithObjectValue:@"Developer"];
            [self.Version selectItemWithObjectValue:@"Alpha 8"];
            self.DevMode = 1;
        }
    }

}

#pragma mark Prison Architect Back button pressed

- (IBAction)PABackclicked:(id)sender {
    NSLog(@"Prison Architect Back button has been clicked");
    [self.console insertText:@"Prison Architect Back button has been clicked\n"];
    self.mainMenuBox.hidden = false;
    [self.console insertText:@"Main Menu has been made visible\n"];
    self.prisonArchitectMainMenu.hidden = true;
    [self.console insertText:@"Prison Architect main menu has been made hidden\n"];
    self.GDTMenuBox.hidden = true;
    self.logInBox.hidden = true;
    _AddButton.hidden = true;
    _TopicName.hidden = true;
    _EveryoneLabel.hidden = true;
    _YoungLabel.hidden = true;
    _MatureLabel.hidden = true;
    _ActionP.hidden = true;
    _AdventureP.hidden = true;
    _RPGP.hidden = true;
    _SimP.hidden = true;
    _StrategyP.hidden = true;
    _CasualP.hidden = true;
    _BCKG.hidden = YES;
    _Action.hidden = true;
    _Adventure.hidden = true;
    _RPG.hidden = true;
    _Simulation.hidden = true;
    _Strategy.hidden = true;
    _Casual.hidden = true;
    _Young.hidden = true;
    _Everyone.hidden = true;
    _Mature.hidden = true;
    self.tClicked = false;
    self.BCKG2.hidden = YES;
    self.BCKG3.hidden = YES;
    self.BCKG4.hidden = YES;
    self.BCKG3.hidden = YES;
    self.BCKG5.hidden = YES;
    NSWindow* keyTarget = self.MainWindow;
    NSRect frame = keyTarget.frame;
    
    frame.size.width = 948;
    [self.MainWindow setFrame:frame display:NO animate:YES];

}








@end
