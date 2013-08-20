//
//  ALFProperty.m
//
//  Created by Allon Freedman on 8/12/13.
//  Copyright (c) 2013 Alfonzzz. All rights reserved.
//

#import "ALFProperty.h"

@implementation ALFProperty

@synthesize protocols = _protocols;

- (instancetype)initWithName:(NSString *)name clazz:(Class)clazz;
{
    self = [super init];
    if (self) {
        _name = name;
        _clazz = clazz;
    }
    return self;
}
- (NSSet *)protocols {
    if (_protocols == nil) {
        
    }
    
    return _protocols;
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    // TODO: Use runtime introspection instead of creating an instance
    return [[[self.clazz alloc] init] conformsToProtocol:aProtocol];
}

@end
