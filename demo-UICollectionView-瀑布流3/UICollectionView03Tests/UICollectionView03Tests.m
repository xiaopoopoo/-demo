//
//  UICollectionView03Tests.m
//  UICollectionView03Tests
//
//  Created by zhutaofeng on 15/4/28.
//  Copyright (c) 2015年 Hyacinth.TaskTinkle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface UICollectionView03Tests : XCTestCase

@end

@implementation UICollectionView03Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
