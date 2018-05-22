//
//  UINavigationBar+TFEasyCoder.m
//  TFEasyCoder
//
//  Created by ztf on 16/10/26.
//  Copyright © 2016年 ztf. All rights reserved.
//

#import "UINavigationBar+TFEasyCoder.h"
#import "NSObject+TFExecute.h"


@implementation UINavigationBar (TFEasyCoder)

+( UINavigationBar *)easyCoder:(UINavigationBarEasyCoderBlock)block{
    return [NSObject tf_execute:[self class] back:^(id ins) {
        if (block) {
            block(( UINavigationBar *)ins);
        }
    }];
}

-( UINavigationBar *)easyCoder:(UINavigationBarEasyCoderBlock)block{
    if (block) {
        __weak typeof(self) weakSelf = self;
        block(weakSelf);
    }
    return self;
}



-(UINavigationBar  *(^)(long long  barStyle))set_barStyle{
    __weak typeof(self) weakSelf = self;
    return ^(long long  barStyle){
        weakSelf.barStyle = barStyle;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(id<UINavigationBarDelegate>    delegate))set_delegate{
    __weak typeof(self) weakSelf = self;
    return ^(id<UINavigationBarDelegate>    delegate){
        weakSelf.delegate = delegate;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(BOOL  translucent))set_translucent{
    __weak typeof(self) weakSelf = self;
    return ^(BOOL  translucent){
        weakSelf.translucent = translucent;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(NSArray *  items))set_items{
    __weak typeof(self) weakSelf = self;
    return ^(NSArray *  items){
        weakSelf.items = items;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(UIColor *  tintColor))set_tintColor{
    __weak typeof(self) weakSelf = self;
    return ^(UIColor *  tintColor){
        weakSelf.tintColor = tintColor;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(UIColor *  barTintColor))set_barTintColor{
    __weak typeof(self) weakSelf = self;
    return ^(UIColor *  barTintColor){
        weakSelf.barTintColor = barTintColor;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(UIImage *  shadowImage))set_shadowImage{
    __weak typeof(self) weakSelf = self;
    return ^(UIImage *  shadowImage){
        weakSelf.shadowImage = shadowImage;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(NSDictionary *  titleTextAttributes))set_titleTextAttributes{
    __weak typeof(self) weakSelf = self;
    return ^(NSDictionary *  titleTextAttributes){
        weakSelf.titleTextAttributes = titleTextAttributes;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(UIImage *  backIndicatorImage))set_backIndicatorImage{
    __weak typeof(self) weakSelf = self;
    return ^(UIImage *  backIndicatorImage){
        weakSelf.backIndicatorImage = backIndicatorImage;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(UIImage *  backIndicatorTransitionMaskImage))set_backIndicatorTransitionMaskImage{
    __weak typeof(self) weakSelf = self;
    return ^(UIImage *  backIndicatorTransitionMaskImage){
        weakSelf.backIndicatorTransitionMaskImage = backIndicatorTransitionMaskImage;
        return weakSelf;
    };
}





//superclass pros UIView
-(UINavigationBar  *(^)(UIView *  maskView))set_maskView{
    __weak typeof(self) weakSelf = self;
    return ^(UIView *  maskView){
        weakSelf.maskView = maskView;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(BOOL  userInteractionEnabled))set_userInteractionEnabled{
    __weak typeof(self) weakSelf = self;
    return ^(BOOL  userInteractionEnabled){
        weakSelf.userInteractionEnabled = userInteractionEnabled;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(long long  tag))set_tag{
    __weak typeof(self) weakSelf = self;
    return ^(long long  tag){
        weakSelf.tag = tag;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(long long  semanticContentAttribute))set_semanticContentAttribute{
    __weak typeof(self) weakSelf = self;
    return ^(long long  semanticContentAttribute){
        weakSelf.semanticContentAttribute = semanticContentAttribute;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(CGPoint  center))set_center{
    __weak typeof(self) weakSelf = self;
    return ^(CGPoint  center){
        weakSelf.center = center;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(CGRect  frame))set_frame{
    __weak typeof(self) weakSelf = self;
    return ^(CGRect  frame){
        weakSelf.frame = frame;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(UIColor *  backgroundColor))set_backgroundColor{
    __weak typeof(self) weakSelf = self;
    return ^(UIColor *  backgroundColor){
        weakSelf.backgroundColor = backgroundColor;
        return weakSelf;
    };
}

//superclass pros UIResponder
-(UINavigationBar  *(^)(NSUserActivity *  userActivity))set_userActivity{
    __weak typeof(self) weakSelf = self;
    return ^(NSUserActivity *  userActivity){
        weakSelf.userActivity = userActivity;
        return weakSelf;
    };
}

//superclass pros NSObject
-(UINavigationBar  *(^)(NSArray *  accessibilityElements))set_accessibilityElements{
    __weak typeof(self) weakSelf = self;
    return ^(NSArray *  accessibilityElements){
        weakSelf.accessibilityElements = accessibilityElements;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(NSArray *  accessibilityCustomActions))set_accessibilityCustomActions{
    __weak typeof(self) weakSelf = self;
    return ^(NSArray *  accessibilityCustomActions){
        weakSelf.accessibilityCustomActions = accessibilityCustomActions;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(BOOL  isAccessibilityElement))set_isAccessibilityElement{
    __weak typeof(self) weakSelf = self;
    return ^(BOOL  isAccessibilityElement){
        weakSelf.isAccessibilityElement = isAccessibilityElement;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(NSString *  accessibilityLabel))set_accessibilityLabel{
    __weak typeof(self) weakSelf = self;
    return ^(NSString *  accessibilityLabel){
        weakSelf.accessibilityLabel = accessibilityLabel;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(NSString *  accessibilityHint))set_accessibilityHint{
    __weak typeof(self) weakSelf = self;
    return ^(NSString *  accessibilityHint){
        weakSelf.accessibilityHint = accessibilityHint;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(NSString *  accessibilityValue))set_accessibilityValue{
    __weak typeof(self) weakSelf = self;
    return ^(NSString *  accessibilityValue){
        weakSelf.accessibilityValue = accessibilityValue;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(unsigned long long  accessibilityTraits))set_accessibilityTraits{
    __weak typeof(self) weakSelf = self;
    return ^(unsigned long long  accessibilityTraits){
        weakSelf.accessibilityTraits = accessibilityTraits;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(UIBezierPath *  accessibilityPath))set_accessibilityPath{
    __weak typeof(self) weakSelf = self;
    return ^(UIBezierPath *  accessibilityPath){
        weakSelf.accessibilityPath = accessibilityPath;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(CGPoint  accessibilityActivationPoint))set_accessibilityActivationPoint{
    __weak typeof(self) weakSelf = self;
    return ^(CGPoint  accessibilityActivationPoint){
        weakSelf.accessibilityActivationPoint = accessibilityActivationPoint;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(NSString *  accessibilityLanguage))set_accessibilityLanguage{
    __weak typeof(self) weakSelf = self;
    return ^(NSString *  accessibilityLanguage){
        weakSelf.accessibilityLanguage = accessibilityLanguage;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(BOOL  accessibilityElementsHidden))set_accessibilityElementsHidden{
    __weak typeof(self) weakSelf = self;
    return ^(BOOL  accessibilityElementsHidden){
        weakSelf.accessibilityElementsHidden = accessibilityElementsHidden;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(BOOL  accessibilityViewIsModal))set_accessibilityViewIsModal{
    __weak typeof(self) weakSelf = self;
    return ^(BOOL  accessibilityViewIsModal){
        weakSelf.accessibilityViewIsModal = accessibilityViewIsModal;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(BOOL  shouldGroupAccessibilityChildren))set_shouldGroupAccessibilityChildren{
    __weak typeof(self) weakSelf = self;
    return ^(BOOL  shouldGroupAccessibilityChildren){
        weakSelf.shouldGroupAccessibilityChildren = shouldGroupAccessibilityChildren;
        return weakSelf;
    };
}

-(UINavigationBar  *(^)(long long  accessibilityNavigationStyle))set_accessibilityNavigationStyle{
    __weak typeof(self) weakSelf = self;
    return ^(long long  accessibilityNavigationStyle){
        weakSelf.accessibilityNavigationStyle = accessibilityNavigationStyle;
        return weakSelf;
    };
}






-(UINavigationBar *(^)(id value,NSString *key))set_ValueKey{
    __weak typeof(self) weakSelf = self;
    return ^(id value,NSString *key){
        [NSObject tf_setTargetValue:weakSelf withValue:value forKey:key];
        return weakSelf;
    };
}


@end
