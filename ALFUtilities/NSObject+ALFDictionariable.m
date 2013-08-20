//
//  NSObject+ALFDictionariable.m
//
//  Created by Allon Freedman on 8/5/13.
//  Copyright (c) 2013 Alfonzzz. All rights reserved.
//

#import "NSObject+ALFDictionariable.h"
#import "NSObject+ALFRuntime.h"
#import "ALFProperty.h"

@implementation NSObject (ALFDictionariable)

- (instancetype)initFromDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    if (self) {
         // TODO usually not a good idea to do this within the init method...
        [self setDictionary:dictionary];
    }
    return self;
}

- (void)setDictionary:(NSDictionary *)keyedValues {
    if (keyedValues == nil) {
        return;
    }
    
    NSArray *properties = [self properties];
    NSMutableDictionary *dictionaryToSet = [NSMutableDictionary dictionaryWithCapacity:properties.count];
    
    for (ALFProperty *property in properties) {
        id propertyValue = keyedValues[property.name];
        if (propertyValue == nil || propertyValue == [NSNull null]) {
            continue;
        }
        
        if ([propertyValue isKindOfClass:[NSDictionary class]]) {
            propertyValue = [[property.clazz alloc] initFromDictionary:propertyValue];
        }
        
        dictionaryToSet[property.name] = propertyValue;
    }
    
    [self setValuesForKeysWithDictionary:dictionaryToSet];
}

- (NSDictionary *)asDictionary {
    NSArray *propertyNames = [self propertyNames];
    if (propertyNames == nil || propertyNames.count == 0) {
        return nil;
    };
    
    NSDictionary *dictionary = [self dictionaryWithValuesForKeys:propertyNames];
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id propertyName, id propertyValue, BOOL *stop) {
        if ([NSNull null] == propertyValue) {
            return;
        }
        
        NSDictionary *propertyValueAsDictionary = [propertyValue asDictionary];
        properties[propertyName] = propertyValueAsDictionary == nil ? propertyValue : propertyValueAsDictionary;
    }];
    
    return properties;
}

- (NSString *)ALFDescription {
    return [[self asDictionary] description];
}

- (instancetype)clone {
    return [[[self class] alloc] initFromDictionary:[self asDictionary]];
}

- (BOOL)ALFisEqual:(id)object {
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [[self asDictionary] isEqual:[object asDictionary]];
}

@end
