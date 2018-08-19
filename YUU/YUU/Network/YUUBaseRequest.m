//
//  YUUBaseRequest.m
//  YUU
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YUUBaseRequest.h"
#import "AFNetworking.h"
@implementation YUUBaseRequest
{
    onSuccessCallback _onSuccess;
    onFailureCallback _onFailure;
    NSDictionary * _parameters;
    NSDictionary * _headers;
    YUUResponse * _response;
}
-(id)initWithSuccessCallback: (onSuccessCallback)success failureCallback:(onFailureCallback) failed{
    self=[super init];
    if(self){
        _onSuccess=success;
        _onFailure=failed;
    }
    return self;
}
-(NSString*) getURL{
    return nil;
}


-(NSString*)getMethod{
    return @"GET";
}
-(onFailureCallback)failCallback{
    return _onFailure;
}

-(void)setParameters:(NSDictionary *)parameters{
    _parameters=parameters;
}

-(YUUResponse *)getResponse{
    return _response;
}
-(void)processResponse:(NSDictionary *)responseDictionary{
    _response=[[YUUResponse alloc]init];
//    if(responseDictionary!=nil){
//        NSNumber *statusCode=(NSNumber *)responseDictionary[@"returnCode"];
//        _response.statusCode=[statusCode intValue];
//    }
}
-(void)start{
    if([[self getMethod] isEqualToString:@"GET"]){
        [self onGet];
    }else if([[self getMethod] isEqualToString:@"POST"]){
        [self onPost];
    }
}
-(void) onGet{
    NSString* url=[BaseAddress stringByAppendingString:[self getURL]];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval=10.0f;
    manager.requestSerializer=[AFJSONRequestSerializer serializerWithWritingOptions:0];
    if(_headers!=nil){
        [_headers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"application/json", @"text/html",@"text/json",@"text/javascript"]];
    manager.securityPolicy.allowInvalidCertificates=YES;
    [manager GET:url parameters:_parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * result=responseObject;
        [self processResponse:result];
        //        if([_response isSucceed]){
        //            if(_onSuccess!=nil){
        //                _onSuccess(self);
        //            }
        //        }else{
        //            [_response setErrorMessage:result[@"errorMessage"]];
        //            if(_onFailure!=nil){
        //                _onFailure(self);
        //            }
        //        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self processError:error];
        //        if(_onFailure!=nil){
        //            _onFailure(self);
        //        }
        
    }];
    
}

-(void)onPost{
    NSString* url=[BaseAddress stringByAppendingString:[self getURL]];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializerWithWritingOptions:0];
    manager.requestSerializer.timeoutInterval=10.0f;
    
    if(_headers!=nil){
        [_headers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/xml"]];
    //manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/x-json"];
    manager.securityPolicy.allowInvalidCertificates=YES;
    [manager POST:url parameters:_parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * result=responseObject;
        [self processResponse:result];
        
//        if([_response isSucceed]){
//            if(_onSuccess!=nil){
//                _onSuccess(self);
//            }
//        }else{
//            [_response setErrorMessage:result[@"errorMessage"]];
//            if(_onFailure!=nil){
//                _onFailure(self);
//            }
//        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self processError:error];
//        if(_onFailure!=nil){
//            _onFailure(self);
//        }

    }];
    
}


-(void) processError:(NSError *)error{
    _response=[[YUUResponse alloc]init];
//    if([error code]==-1001||[error code]==-1009 || [error code]==-1004){
//        _response.errorMessage=@"您当前无法正常访问服务，请确认网络是否正常";
//        _response.statusCode=-100;
//    }else{
//        _response.statusCode=(int)error.code;
//        _response.errorMessage=error.description;
//    }
    
}


@end