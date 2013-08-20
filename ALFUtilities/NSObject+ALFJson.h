//
//  NSObject+ALFJson.h
//
//  Created by Allon Freedman on 8/14/13.
//  Copyright (c) 2013 Alfonzzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ALFJson)

- (instancetype)initFromJson:(NSString *)json;
- (NSString *)asJson;

@end
