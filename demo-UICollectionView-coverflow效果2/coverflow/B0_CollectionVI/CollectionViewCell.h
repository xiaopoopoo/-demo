//
//  CollectionViewCell.h
//  UICollectionView01
//
//  Created by zhutaofeng on 15/4/20.
//  Copyright (c) 2015年 Hyacinth.TaskTinkle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (assign, nonatomic) IBOutlet UIImageView *imageView;


-(void)setCellData:(NSString *)data;

@end
