//
//  ObjCHirliteViewController.m
//  objc-rlite
//
//  Created by Sebastian Waisbrot on 02/28/2015.
//  Copyright (c) 2014 Sebastian Waisbrot. All rights reserved.
//

#import "ObjCHirliteViewController.h"
#import <objc-rlite/ObjCHirlite.h>

@interface ObjCHirliteViewController ()

@end

@implementation ObjCHirliteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString* path = [documentsDirectory stringByAppendingPathComponent:@"mydb.rld"];

    lastLaunch = [[UILabel alloc] initWithFrame:self.view.frame];
    lastLaunch.textAlignment = NSTextAlignmentCenter;
    lastLaunch.numberOfLines = 2;
    [self.view addSubview:lastLaunch];

    ObjCHirlite* rlite = [[ObjCHirlite alloc] initWithPath:path];
    id time = [rlite command:@[@"get", @"previous"]];
    [rlite command:@[@"set", @"previous", [NSNumber numberWithDouble:[NSDate timeIntervalSinceReferenceDate]]]];
    if ([time isKindOfClass:[NSString class]]) {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterLongStyle;
        dateFormatter.timeStyle = NSDateFormatterLongStyle;
        NSDate* date = [NSDate dateWithTimeIntervalSinceReferenceDate:[time doubleValue]];
        lastLaunch.text = [NSString stringWithFormat:@"Last launch\n%@", [dateFormatter stringFromDate:date]];
    } else {
        lastLaunch.text = @"First launch!";
    }
}

@end
