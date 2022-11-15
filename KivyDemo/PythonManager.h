//
//  PythonManager.h
//  KivyDemo
//
//  Created by 樋川大聖 on 2022/11/14.
//

#import <Foundation/Foundation.h>

@interface PythonManager : NSObject

+ (void)callPython: (NSString*)fileName funcName:(NSString*)funcName;

@end
