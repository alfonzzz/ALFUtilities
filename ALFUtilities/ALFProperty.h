//
//  ALFProperty.h
//
//  Created by Allon Freedman on 8/12/13.
//  Copyright (c) 2013 Alfonzzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALFProperty : NSObject

- (instancetype)initWithName:(NSString *)name clazz:(Class)clazz;

@property (copy, nonatomic) NSString *name;
@property (readonly, nonatomic) Class clazz;
@property (copy, nonatomic, readonly) NSSet *protocols;

@end
