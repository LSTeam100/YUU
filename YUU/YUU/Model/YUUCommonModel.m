//
//  YUUCommonModel.m
//  YUU
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUCommonModel.h"

@implementation YUUCommonModel
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.token forKey:@"_token"];
    [coder encodeObject:self.headphoto forKey:@"_headphoto"];
    [coder encodeObject:self.membergrade forKey:@"_membergrade"];
    [coder encodeObject:self.memberid forKey:@"_memberid"];
    [coder encodeObject:self.certification forKey:@"_certification"];
    [coder encodeObject:self.propertynum forKey:@"_propertynum"];
    [coder encodeObject:self.canuseyuu forKey:@"_canuseyuu"];
    [coder encodeObject:self.frozenyuu forKey:@"_frozenyuu"];
    [coder encodeObject:self.lockedyuu forKey:@"_lockedyuu"];
    [coder encodeObject:self.newnews forKey:@"_newnews"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _token = [aDecoder decodeObjectForKey:@"_token"];
        _headphoto = [aDecoder decodeObjectForKey:@"_headphoto"];
        _membergrade = [aDecoder decodeObjectForKey:@"_membergrade"];
        _memberid = [aDecoder decodeObjectForKey:@"_memberid"];
        _certification = [aDecoder decodeObjectForKey:@"_certification"];
        _propertynum = [aDecoder decodeObjectForKey:@"_propertynum"];
        _canuseyuu = [aDecoder decodeObjectForKey:@"_canuseyuu"];
        _frozenyuu = [aDecoder decodeObjectForKey:@"_frozenyuu"];
        _lockedyuu = [aDecoder decodeObjectForKey:@"_lockedyuu"];
        _newnews = [aDecoder decodeObjectForKey:@"_newnews"];
        
    }
    return self;
}
@end
