//
//  CCPictureList.h
//  CrazyCartoon
//
//  Created by Tarena on 16/4/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CCPictureList : NSObject
/** 图片列表 */
@property (nonatomic, strong) NSArray *pictureList;
+(NSArray *)getPictureList;
@end
