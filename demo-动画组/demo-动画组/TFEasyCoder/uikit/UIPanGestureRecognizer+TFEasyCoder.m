//
//  UIPanGestureRecognizer+TFEasyCoder.m
//  TFEasyCoder
//
//  Created by ztf on 16/10/26.
//  Copyright © 2016年 ztf. All rights reserved.
//

#import "UIPanGestureRecognizer+TFEasyCoder.h"
#import "NSObject+TFExecute.h"

@implementation UIPanGestureRecognizer (TFEasyCoder)

+( UIPanGestureRecognizer *)easyCoder:(UIPanGestureRecognizerEasyCoderBlock)block{
    return [NSObject tf_execute:[self class] back:^(id ins) {
        if (block) {
            block(( UIPanGestureRecognizer *)ins);
        }
    }];
}

-( UIPanGestureRecognizer *)easyCoder:(UIPanGestureRecognizerEasyCoderBlock)block{
    if (block) {
        __weak typeof(self) weakSelf = self;
        block(weakSelf);
    }
    return self;
}



-(UIPanGestureRecognizer  *(^)(unsigned long long  minimumNumberOfTouches))set_minimumNumberOfTouches{
    __weak typeof(self) weakSelf = self;
    return ^(unsigned long long  minimumNumberOfTouches){
        weakSelf.minimumNumberOfTouches = minimumNumberOfTouches;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(unsigned long long  maximumNumberOfTouches))set_maximumNumberOfTouches{
    __weak typeof(self) weakSelf = self;
    return ^(unsigned long long  maximumNumberOfTouches){
        weakSelf.maximumNumberOfTouches = maximumNumberOfTouches;
        return weakSelf;
    };
}





//superclass pros UIGestureRecognizer
-(UIPanGestureRecognizer  *(^)(BOOL  enabled))set_enabled{
    __weak typeof(self) weakSelf = self;
    return ^(BOOL  enabled){
        weakSelf.enabled = enabled;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(BOOL  cancelsTouchesInView))set_cancelsTouchesInView{
    __weak typeof(self) weakSelf = self;
    return ^(BOOL  cancelsTouchesInView){
        weakSelf.cancelsTouchesInView = cancelsTouchesInView;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(BOOL  delaysTouchesBegan))set_delaysTouchesBegan{
    __weak typeof(self) weakSelf = self;
    return ^(BOOL  delaysTouchesBegan){
        weakSelf.delaysTouchesBegan = delaysTouchesBegan;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(BOOL  delaysTouchesEnded))set_delaysTouchesEnded{
    __weak typeof(self) weakSelf = self;
    return ^(BOOL  delaysTouchesEnded){
        weakSelf.delaysTouchesEnded = delaysTouchesEnded;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(NSArray *  allowedTouchTypes))set_allowedTouchTypes{
    __weak typeof(self) weakSelf = self;
    return ^(NSArray *  allowedTouchTypes){
        weakSelf.allowedTouchTypes = allowedTouchTypes;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(NSArray *  allowedPressTypes))set_allowedPressTypes{
    __weak typeof(self) weakSelf = self;
    return ^(NSArray *  allowedPressTypes){
        weakSelf.allowedPressTypes = allowedPressTypes;
        return weakSelf;
    };
}

//superclass pros NSObject
-(UIPanGestureRecognizer  *(^)(NSArray *  accessibilityElements))set_accessibilityElements{
    __weak typeof(self) weakSelf = self;
    return ^(NSArray *  accessibilityElements){
        weakSelf.accessibilityElements = accessibilityElements;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(NSArray *  accessibilityCustomActions))set_accessibilityCustomActions{
    __weak typeof(self) weakSelf = self;
    return ^(NSArray *  accessibilityCustomActions){
        weakSelf.accessibilityCustomActions = accessibilityCustomActions;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(BOOL  isAccessibilityElement))set_isAccessibilityElement{
    __weak typeof(self) weakSelf = self;
    return ^(BOOL  isAccessibilityElement){
        weakSelf.isAccessibilityElement = isAccessibilityElement;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(NSString *  accessibilityLabel))set_accessibilityLabel{
    __weak typeof(self) weakSelf = self;
    return ^(NSString *  accessibilityLabel){
        weakSelf.accessibilityLabel = accessibilityLabel;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(NSString *  accessibilityHint))set_accessibilityHint{
    __weak typeof(self) weakSelf = self;
    return ^(NSString *  accessibilityHint){
        weakSelf.accessibilityHint = accessibilityHint;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(NSString *  accessibilityValue))set_accessibilityValue{
    __weak typeof(self) weakSelf = self;
    return ^(NSString *  accessibilityValue){
        weakSelf.accessibilityValue = accessibilityValue;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(unsigned long long  accessibilityTraits))set_accessibilityTraits{
    __weak typeof(self) weakSelf = self;
    return ^(unsigned long long  accessibilityTraits){
        weakSelf.accessibilityTraits = accessibilityTraits;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(UIBezierPath *  accessibilityPath))set_accessibilityPath{
    __weak typeof(self) weakSelf = self;
    return ^(UIBezierPath *  accessibilityPath){
        weakSelf.accessibilityPath = accessibilityPath;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(CGPoint  accessibilityActivationPoint))set_accessibilityActivationPoint{
    __weak typeof(self) weakSelf = self;
    return ^(CGPoint  accessibilityActivationPoint){
        weakSelf.accessibilityActivationPoint = accessibilityActivationPoint;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(NSString *  accessibilityLanguage))set_accessibilityLanguage{
    __weak typeof(self) weakSelf = self;
    return ^(NSString *  accessibilityLanguage){
        weakSelf.accessibilityLanguage = accessibilityLanguage;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(BOOL  accessibilityElementsHidden))set_accessibilityElementsHidden{
    __weak typeof(self) weakSelf = self;
    return ^(BOOL  accessibilityElementsHidden){
        weakSelf.accessibilityElementsHidden = accessibilityElementsHidden;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(BOOL  accessibilityViewIsModal))set_accessibilityViewIsModal{
    __weak typeof(self) weakSelf = self;
    return ^(BOOL  accessibilityViewIsModal){
        weakSelf.accessibilityViewIsModal = accessibilityViewIsModal;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(BOOL  shouldGroupAccessibilityChildren))set_shouldGroupAccessibilityChildren{
    __weak typeof(self) weakSelf = self;
    return ^(BOOL  shouldGroupAccessibilityChildren){
        weakSelf.shouldGroupAccessibilityChildren = shouldGroupAccessibilityChildren;
        return weakSelf;
    };
}

-(UIPanGestureRecognizer  *(^)(long long  accessibilityNavigationStyle))set_accessibilityNavigationStyle{
    __weak typeof(self) weakSelf = self;
    return ^(long long  accessibilityNavigationStyle){
        weakSelf.accessibilityNavigationStyle = accessibilityNavigationStyle;
        return weakSelf;
    };
}






-(UIPanGestureRecognizer *(^)(id value,NSString *key))set_ValueKey{
    __weak typeof(self) weakSelf = self;
    return ^(id value,NSString *key){
        [NSObject tf_setTargetValue:weakSelf withValue:value forKey:key];
        return weakSelf;
    };
}


@end