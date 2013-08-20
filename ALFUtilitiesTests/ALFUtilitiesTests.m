//
//  ALFUtilitiesTests.m
//
//  Created by Allon Freedman on 8/5/13.
//  Copyright (c) 2013 Alfonzzz. All rights reserved.
//

#import "ALFUtilitiesTests.h"
#import "NSObject+ALFDictionariable.h"
#import "NSObject+ALFJson.h"

@class ALFAnimal;

@interface ALFPerson : NSObject

@property (copy, nonatomic) NSString *name;
@property (nonatomic) int age;
@property (nonatomic) BOOL married;
@property (strong, nonatomic) ALFPerson *child;
@property (strong, nonatomic) ALFAnimal *pet;

@end

@implementation ALFPerson

@end

@interface ALFAnimal : NSObject

@property (copy, nonatomic) NSString *name;

@end

@implementation ALFAnimal

@end

@interface ALFUtilitiesTests()

@property (strong, nonatomic) ALFPerson *person;

@end

@implementation ALFUtilitiesTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    
    ALFPerson *peter = [[ALFPerson alloc] init];
    peter.name = @"Peter";
    peter.age = 40;
    peter.married = YES;
    
    ALFPerson *stewie = [[ALFPerson alloc] init];
    stewie.name = @"Stewie";
    stewie.age = 1;
    stewie.married = NO;
    peter.child = stewie;
    
    ALFAnimal *brian = [[ALFAnimal alloc] init];
    brian.name = @"Brian";
    peter.pet = brian;
    
    self.person = peter;
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
    
    self.person = nil;
}

- (void)testClone
{
    ALFPerson *peter = self.person;
    NSLog(@"\nPeter:\n%@", [peter ALFDescription]);
    
    ALFPerson *peterClone = [peter clone];
    NSLog(@"\nPeter clone:\n%@", [peterClone ALFDescription]);
    
    STAssertTrue([peter ALFisEqual:peterClone], nil);
}

- (void)testJson
{
    ALFPerson *peter = self.person;
    NSString *peterJson = [peter asJson];
    NSLog(@"\nPeter:\n%@", [peter ALFDescription]);
    NSLog(@"\nPeter json:\n%@", peterJson);
    
    ALFPerson *peterCloneFromJson = [[ALFPerson alloc] initFromJson:peterJson];
    NSLog(@"\nPeter clone:\n%@", [peterCloneFromJson ALFDescription]);
    NSLog(@"\nPeter clone json:\n%@", [peterCloneFromJson asJson]);
    
    STAssertTrue([peter ALFisEqual:peterCloneFromJson], nil);
}

@end
