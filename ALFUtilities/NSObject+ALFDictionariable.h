//
//  NSObject+ALFDictionariable.h
//
//  Created by Allon Freedman on 8/5/13.
//  Copyright (c) 2013 Alfonzzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ALFDictionariable)

- (instancetype)initFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)asDictionary;

- (NSString *)ALFDescription;
- (instancetype)clone;
- (BOOL)ALFisEqual:(id)object;

@end
