//
//  CCPictureList.m
//  CrazyCartoon
//
//  Created by Tarena on 16/4/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CCPictureList.h"


@implementation CCPictureList
+(NSArray *)getPictureList{
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i < 77; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];

        [arr addObject:image];
    }
    return arr;
}
@end
