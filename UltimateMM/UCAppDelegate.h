//
//  UCAppDelegate.h
//  GDT Legend
//
//  Created by Joshua Kac on 1/13/14.
//  Copyright (c) 2014 UnivereseCrafters. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Webkit/WebKit.h>

@interface UCAppDelegate : NSObject <NSApplicationDelegate> {
    
    //Windows
    
    IBOutlet NSWindow *SecondaryWindow;
    IBOutlet NSWindow *MainWindow;
    
    //TextFeilds
    
    IBOutlet NSTextField *ModNamer;
    
    //Combo Boxes
    
    IBOutlet NSComboBox *Young;
    IBOutlet NSComboBox *Everyone;
    IBOutlet NSComboBox *Mature;
    

}

@property (strong) IBOutlet NSButton *GDTB;
@property (strong) IBOutlet NSButton *SaveB;
@property (strong) IBOutlet NSButton *EventB;
@property (strong) IBOutlet NSBox *logInBox;
@property (strong) IBOutlet NSBox *mainMenuBox;
@property (strong) IBOutlet NSBox *GDTMenuBox;


#pragma mark Dictionaries

@property (nonatomic, assign) NSMutableDictionary *modificationInfo;

#pragma mark INt

@property (nonatomic, assign) int i;
@property (nonatomic, assign) int DevMode;

#pragma mark BOOLS

@property (nonatomic, assign) BOOL TTT;
@property (nonatomic, assign) BOOL SSS;
@property (nonatomic, assign) BOOL Installed;
@property (nonatomic, assign) BOOL tClicked;
@property (nonatomic, assign) BOOL tClicked2;
@property (nonatomic, assign) BOOL tClicked3;
@property (nonatomic, assign) BOOL tClicked4;
@property (nonatomic, assign) BOOL tClicked5;
@property (nonatomic, assign) BOOL fileExists;
@property (nonatomic, assign) BOOL exists;

#pragma mark Floats

@property (nonatomic, assign) float ActionV;
@property (nonatomic, assign) float AdventureV;
@property (nonatomic, assign) float RpgV;
@property (nonatomic, assign) float SimulationV;
@property (nonatomic, assign) float StrategyV;
@property (nonatomic, assign) float CasualV;
@property (nonatomic, assign) float YoungV;
@property (nonatomic, assign) float EveryoneV;
@property (nonatomic, assign) float MatureV;
@property (nonatomic, assign) float YoungValue;
@property (nonatomic, assign) float EveryoneValue;
@property (nonatomic, assign) float MatureValue;

#pragma mark Buttons

@property (strong) IBOutlet NSButton *MCButton;
@property (strong) IBOutlet NSButton *AddButton;
@property (strong) IBOutlet NSComboBox *Version;
@property (strong) IBOutlet NSComboBox *Buttons1111;
@property (strong) IBOutlet NSButton *Apply;
@property (strong) IBOutlet NSButton *TestBuild;
@property (strong) IBOutlet NSComboBox *Modis;
@property (strong) IBOutlet NSButton *Load;
@property (strong) IBOutlet NSButton *modif;
@property (strong) IBOutlet NSMenuItem *event1;
@property (strong) IBOutlet NSMenuItem *openb;
@property (strong) IBOutlet NSMenuItem *ModMenu;
@property (strong) IBOutlet NSButton *rAdd;
@property (strong) IBOutlet NSButton *rButton;
@property (strong) IBOutlet NSButton *Load2;
@property (strong) IBOutlet NSProgressIndicator *loadBar;
@property (strong) IBOutlet NSButton *rememberMe;


#pragma mark Sliders

@property (strong) IBOutlet NSSlider *Young;
@property (strong) IBOutlet NSSlider *Everyone;
@property (strong) IBOutlet NSSlider *Mature;
@property (strong) IBOutlet NSSlider *Action;
@property (strong) IBOutlet NSSlider *Adventure;
@property (strong) IBOutlet NSSlider *RPG;
@property (strong) IBOutlet NSSlider *Simulation;
@property (strong) IBOutlet NSSlider *Strategy;
@property (strong) IBOutlet NSSlider *Casual;

#pragma mark Windows

@property (strong) IBOutlet NSWindow *MCSCREEN;
@property (strong) IBOutlet NSWindow *MCSERVER;
@property (strong) IBOutlet NSWindow *SecondaryWindow;
@property (strong) IBOutlet NSWindow *MainWindow;
@property (strong) IBOutlet NSWindow *Window;
@property (unsafe_unretained) IBOutlet NSWindow *Mods;

#pragma mark Text Feilds

@property (strong) IBOutlet NSTextField *YoungLabel;
@property (strong) IBOutlet NSTextField *EveryoneLabel;
@property (strong) IBOutlet NSTextField *MatureLabel;
@property (strong) IBOutlet NSTextField *TopicName;
@property (strong) IBOutlet NSTextField *ModName;
@property (strong) IBOutlet NSTextField *VersionL1;
@property (strong) IBOutlet NSTextField *VersionL2;
@property (strong) IBOutlet NSTextView *CS;
@property (strong) IBOutlet NSTextField *TXTFeild;
@property (nonatomic, retain) NSString *nameNotInUse;
@property (nonatomic, retain) NSMutableString *namesInUse;
@property (nonatomic, retain) NSMutableArray *TopicPR;
@property (nonatomic, retain) NSMutableString *Topic;
@property (nonatomic, retain) NSMutableString *LoadString;
@property (nonatomic, retain) NSMutableString *SettingsContent;
@property (nonatomic, retain) NSMutableString *ModText;
@property (nonatomic, retain) NSMutableString *package;
@property (nonatomic, retain) NSMutableString *js;
@property (nonatomic, retain) NSMutableString *Save;
@property (nonatomic, retain) NSMutableString *Event;
@property (nonatomic, retain) NSMutableString *SettingsValues;
@property (nonatomic, retain) NSMutableString *CSToMove;
@property (nonatomic, retain) NSMutableString *StuffValues;
@property (strong) IBOutlet NSTextField *ModInfotxt;
@property (strong) IBOutlet NSTextField *BT3;
@property (strong) IBOutlet NSTextField *BT2;
@property (strong) IBOutlet NSTextField *BT1;
@property (strong) IBOutlet NSTextField *Eventname;
@property (strong) IBOutlet NSTextField *Year;
@property (strong) IBOutlet NSTextField *Month;
@property (strong) IBOutlet NSTextField *Week;
@property (strong) IBOutlet NSTextField *labels;
@property (strong) IBOutlet NSTextField *whatsNew;
@property (strong) IBOutlet NSTextField *versionTXT;
@property (strong) IBOutlet NSTextField *authors;
@property (strong) IBOutlet NSTextField *URL;
@property (strong) IBOutlet NSTextView *modDescription;
@property (strong) IBOutlet NSTextField *rName;
@property (strong) IBOutlet NSTextField *techLevel;
@property (strong) IBOutlet NSComboBox *whereCan;
@property (strong) IBOutlet NSTextField *whereCanText;
@property (strong) IBOutlet NSTextField *searchReference;
@property (strong) IBOutlet NSScrollView *helpScroll;
@property (strong) IBOutlet NSComboBox *Mode;
@property (strong) IBOutlet NSTextField *userNameTxtFeild;
@property (strong) IBOutlet NSSecureTextField *passwordTxtFeild;
@property (strong) IBOutlet NSTextField *usernameLabel;
@property (strong) IBOutlet NSTextField *errorLogInTxtFeild;
@property (strong) IBOutlet NSButton *settingsA8;
@property (strong) IBOutlet NSButton *settingsA9;
@property (strong) IBOutlet NSTextField *mainMenuError;
@property (nonatomic, retain) NSMutableString *betaValue;
@property (nonatomic, retain) NSMutableString *versionValue;
@property (nonatomic, retain) NSMutableString *modeValue;
@property (strong) IBOutlet NSTextView *console;
@property (strong) IBOutlet NSTextField *modNametxt2;





#pragma mark Photos

@property (strong) IBOutlet NSImageView *ActionP;
@property (strong) IBOutlet NSImageView *AdventureP;
@property (strong) IBOutlet NSImageView *RPGP;
@property (strong) IBOutlet NSImageView *SimP;
@property (strong) IBOutlet NSImageView *StrategyP;
@property (strong) IBOutlet NSImageView *CasualP;
@property (strong) IBOutlet NSBox *BCKG;
@property (strong) IBOutlet NSBox *BCKG2;
@property (strong) IBOutlet NSBox *BCKG3;
@property (strong) IBOutlet NSBox *BCKG4;
@property (strong) IBOutlet NSBox *BCKG5;



#pragma mark MineCraft

#pragma mark Text Feilds
@property (strong) IBOutlet NSTextField *serverName;
@property (strong) IBOutlet NSTextField *ram;
@property (strong) IBOutlet NSTextField *message;
@property (strong) IBOutlet NSTextField *mineCraftWorldSavename;
@property (strong) IBOutlet NSTextField *IPAdress;
@property (strong) IBOutlet NSTextField *port;
@property (strong) IBOutlet NSTextField *buildHeight;
@property (strong) IBOutlet NSTextField *seed;
@property (strong) IBOutlet NSTextField *viewDistance;
@property (strong) IBOutlet NSTextField *gameMode;
@property (strong) IBOutlet NSTextField *spawnProtection;
@property (strong) IBOutlet NSTextField *difficulty;
@property (strong) IBOutlet NSTextField *playerIdleTimeOut;
@property (strong) IBOutlet NSTextField *maxPlayers;

#pragma mark Buttons
@property (strong) IBOutlet NSButton *mineCraftServerFinish;
@property (strong) IBOutlet NSButton *onlineMode;
@property (strong) IBOutlet NSButton *pvp;
@property (strong) IBOutlet NSButton *spawnNPCS;
@property (strong) IBOutlet NSProgressIndicator *downloadProgress;

#pragma mark NSStrings

@property (nonatomic, retain) NSMutableString* serverProperties;
@property (nonatomic, retain) NSMutableString* server;

#pragma mark Variables

@property (nonatomic, retain) NSURLResponse* downloadResponse;
@property (nonatomic) NSInteger bytesReceived;


#pragma mark Prison Architect

#pragma mark Buttons


@property (strong) IBOutlet NSButton *prisonArchitectMainButton;


#pragma mark Boxes

@property (strong) IBOutlet NSBox *prisonArchitectMainMenu;














@end
