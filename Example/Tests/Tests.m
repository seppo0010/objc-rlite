//
//  objc-rliteTests.m
//  objc-rliteTests
//
//  Created by Sebastian Waisbrot on 02/28/2015.
//  Copyright (c) 2014 Sebastian Waisbrot. All rights reserved.
//

#import <objc-rlite/ObjCHirlite.h>

SpecBegin(Hirlite)

static NSString* key = @"key";
static NSString* value = @"\xe2\x98\x83";
static ObjCHirlite* rlite;
describe(@"these will pass", ^{
    beforeEach(^{
        rlite = [[ObjCHirlite alloc] init];
    });

    it(@"supports null", ^{
        id reply = [rlite command:@[@"get", key]];
        XCTAssertEqualObjects([NSNull null], reply);
    });

    it(@"supports ok", ^{
        id reply = [rlite command:@[@"set", key, value]];
        XCTAssertEqualObjects([NSNumber numberWithBool:TRUE], reply);
    });
    
    it(@"supports unicode string", ^{
        [rlite command:@[@"set", key, value]];
        id reply = [rlite command:@[@"get", key]];
        XCTAssertEqualObjects(value, reply);
    });
    
    it(@"supports integer", ^{
        id reply = [rlite command:@[@"lpush", key, value, value]];
        XCTAssertEqualObjects([NSNumber numberWithInt:2], reply);
    });

    it(@"supports error", ^{
        id reply = [rlite command:@[@"set", key]];
        XCTAssertEqualObjects([reply class], [NSException class]);
    });
    
    it(@"supports array", ^{
        [rlite command:@[@"rpush", key, @"1", @"2", @"3"]];
        id reply = [rlite command:@[@"lrange", key, @0, @-1]];
        id expected = @[@"1", @"2", @"3"];
        XCTAssertEqualObjects(expected, reply);
    });
});

describe(@"these will pass", ^{
    beforeEach(^{
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        NSString* path = [documentsDirectory stringByAppendingPathComponent:@"mydb.rld"];

        rlite = [[ObjCHirlite alloc] initWithPath:path];
    });
    
    it(@"creates persistent data", ^{
        [rlite command:@[@"set", key, value]];
    });

    it(@"reads persistent data", ^{
        id reply = [rlite command:@[@"get", key]];
        XCTAssertEqualObjects(value, reply);
    });
});

SpecEnd