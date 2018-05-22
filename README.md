# anmition
动画的继承结构

CAAnimation(动画根类，不可直接使用){
    CAPropertyAnimation（属性动画，抽象类，不能直接使用）{
        CABasicAnimation（基本动画，可直接使用）{
              CASpringAnimation（弹性动画，可直接使用，iOS9新加）
        }
        CAKeyframeAnimation（关键帧动画，可直接使用）
    }
    CATransition（转场动画，可直接使用）
    CAAnimationGroup （组动画，可直接使用）
}

1､CAAnimation 

属性：
//动画的代理回调
@property(nullable, strong) id delegate;
//动画执行完以后是否移除动画,默认YES
@property(getter=isRemovedOnCompletion) BOOL removedOnCompletion;
//动画的动作规则,包含以下值
//kCAMediaTimingFunctionLinear 匀速
//kCAMediaTimingFunctionEaseIn 慢进快出
//kCAMediaTimingFunctionEaseOut 快进慢出
//kCAMediaTimingFunctionEaseInEaseOut 慢进慢出 中间加速
//kCAMediaTimingFunctionDefault 默认
@property(nullable, strong) CAMediaTimingFunction *timingFunction;

属性的详解：

委托：动画执行的代理，在动画开始前设定，不用显式的写在代码里，它包含两个方法：
动画开始回调
- (void)animationDidStart:(CAAnimation *)anim;
动画结束回调
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
removedOnCompletion：动画完成后是否移除动画默认为YES此属性为YES时，在fillMode不可用，具体为什么不可用，可以自己结合两个属性分析一下，这里不再赘述。
timingFunction设置动画速度曲线，默认值上面已经给出下面说它的几个方法：
。这两个方法是一样的如果我们对系统自带的速度函数不满意，可以通过这两个函数创建一个自己喜欢的速度曲线函数，具体用法可以参考这篇文章CAMediaTimingFunction使用的
+ (instancetype)functionWithControlPoints:(float)c1x :(float)c1y :(float)c2x :(float)c2y;
- (instancetype)initWithControlPoints:(float)c1x :(float)c1y :(float)c2x :(float)c2y;
电子杂志曲线的函数的缓冲点，具体用法可以参考这篇文章：iOS-核心动画高级编程/ 10-缓冲
- (void)getControlPointAtIndex:(size_t)idx values:(float[2])ptr;



2､CAAnimation <CAMediaTiming>协议的属性

属性：
//开始时间.这个属性比较复杂,傻瓜用法为:CACurrentMediaTime() + x,
//其中x为延迟时间.如果设置 beginTime = CACurrentMediaTime() + 1.0,产生的效果为延迟一秒执行动画,下面详解原理
@property CFTimeInterval beginTime;
//动画执行时间,此属性和speed有关系speed默认为1.0,如果speed设置为2.0,那么动画执行时间则为duration*(1.0/2.0).
@property CFTimeInterval duration;
//动画执行速度,它duration的关系参考上面解释
@property float speed;
//动画的时间延迟,这个属性比较复杂,下面详解
@property CFTimeInterval timeOffset;
//重复执行次数
@property float repeatCount;
//重复执行时间,此属性优先级大于repeatCount.也就是说如果repeatDuration设置为1秒重复10次,那么它会在1秒内执行完动画.
@property CFTimeInterval repeatDuration;
//是否自动翻转动画,默认NO.如果设置YES,那么整个动画的执行效果为A->B->A.
@property BOOL autoreverses;
//动画的填充方式,默认为: kCAFillModeRemoved,包含以下值
//kCAFillModeForwards//动画结束后回到准备状态
//kCAFillModeBackwards//动画结束后保持最后状态
//kCAFillModeBoth//动画结束后回到准备状态,并保持最后状态
//kCAFillModeRemoved//执行完成移除动画
@property(copy) NSString *fillMode;


属性的详解：

BEGINTIME：刚才上面简单解释了下这个属性的用法：CACurrentMediaTime()+ x。会使动画延迟执行点¯x秒不知道到这里有没有人想过如果-x？会出现怎么样效果假设我们有执行一个3秒的动画，设置然后beginTime = CACurrentMediaTime()- 1.5那么执行动画你会发现动画只会执行后半段，就是也。只执行后面的3-1.5s的动画。为什么会这样？其实动画都有一个时间表（时间线）的概念。动画开始执行都是基于这个时间线的绝对时间，这个时间和它的父类有关（系统的属性注释可以看到）。默认的CALayer的的BEGINTIME为零，如果这个值为零的话，系统会把它设置为CACurrentMediaTime（），那么这个时间就是正常执行动画的时间：立即执行所以如果设置你beginTime=CACurrentMediaTime()+x;它会把它的执行时间线推迟x秒，就是也。晚执行x秒，如果你beginTime=CACurrentMediaTime()-x;那它开始的时候会从你动画对应的绝对时间开始执行。
timeOffset：时间偏移量，默认为0;既然它是时间偏移量，那么它即和动画时间相关这么解释：假设我们设置一个动画时间为5秒，动画执行的过程为1->2->3->4->5，这时候如果你设置timeOffset = 2s它那么的执行过程就会变成3->4->5->1->2如果你设置timeOffset = 4s那么它的执行过程就会变成5->1->2->3->4，这么说应该很明白了吧？

3､CAPropertyAnimation属性动画，抽象类，不能直接使用

属性：
//需要动画的属性值
@property(nullable, copy) NSString *keyPath;
//属性动画是否以当前动画效果为基础,默认为NO
@property(getter=isAdditive) BOOL additive;
//指定动画是否为累加效果,默认为NO
@property(getter=isCumulative) BOOL cumulative;
//此属性相当于CALayer中的transform属性,下面会详解
@property(nullable, strong) CAValueFunction *valueFunction;


属性的详解：
CAPropertyAnimation是属性动画顾名思义也就是针对属性才可以做的动画那它可以对谁的属性可以做动画是的CALayer的属性，比如：？界限，位置等那么问题来了，我们改变的CALayer的位置可以。设置直接[CAPropertyAnimation animationWithKeyPath:@"position"]如果我们设置它的变换（CATransform3D）呢？CATransform3D是一个矩阵，如果我们想为它做动画怎么办？下面这个属性就是用来解决这个问题的。

valueFunction：我们来看它可以设置的值：
kCAValueFunctionRotateX
kCAValueFunctionRotateY
kCAValueFunctionRotateZ
kCAValueFunctionScale
kCAValueFunctionScaleX
kCAValueFunctionScaleY
kCAValueFunctionScaleZ
kCAValueFunctionTranslate
kCAValueFunctionTranslateX
kCAValueFunctionTranslateY
kCAValueFunctionTranslateZ


方法
//创建一个CAPropertyAnimation对象
+ (instancetype)animationWithKeyPath:(nullable NSString *)path;

属性归总：
CATransform3D{
rotation旋转
transform.rotation.x
transform.rotation.y
transform.rotation.z

scale缩放
transform.scale.x
transform.scale.y
transform.scale.z

translation平移
transform.translation.x
transform.translation.y
transform.translation.z
}

CGPoint{
position
position.x
position.y
}

CGRect{
bounds
bounds.size
bounds.size.width
bounds.size.height

bounds.origin
bounds.origin.x
bounds.origin.y
}

property{
opacity
backgroundColor
cornerRadius
borderWidth
contents

Shadow{
shadowColor
shadowOffset
shadowOpacity
shadowRadius
}
}
总结：CAAnimation是基类，CAPropertyAnimation是抽象类，两者都不可以直接使用，那我们只有使用它的子类了。


4､CABasicAnimation基本动画

属性：
//开始值
@property(nullable, strong) id fromValue;
//结束值
@property(nullable, strong) id toValue;
//结束值
@property(nullable, strong) id byValue;

属性详解：
这三个属性之间的规则

fromValue状语从句：toValue不为空，的动画会效果从fromValue的值变化到toValue。
fromValue状语从句：byValue都不为空，的动画效果将会从fromValue变化到fromValue+byValue
toValue状语从句：byValue都不为空，的动画效果将会从toValue-byValue变化到toValue
只有fromValue的值不为空，的动画效果将会从fromValue的值变化到当前的状态。
只有toValue的值不为空，的动画效果将会从当前状态的值变化到toValue的值。
只有byValue的值不为空，动画的效果将会从当前的值变化到（当前状态的值+ byValue）的值。
CABasicAnimation看起来不太复杂，但实际只用这个就足以可以做很多种动画了

主要代码：
-(void)animationBegin:(UIButton *)btn{
        CABasicAnimation *animation = nil;
        switch (btn.tag) {
        case 0:{
        //淡如淡出
        animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        [animation setFromValue:@1.0];
        [animation setToValue:@0.1];
        }break;
        case 1:{
        //缩放
        animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:@1.0];//设置起始值
        [animation setToValue:@0.1];//设置目标值
        }break;
        case 2:{
        //旋转
        animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        //setFromValue不设置,默认以当前状态为准
        [animation setToValue:@(M_PI)];
        }break;
        case 3:{
        //平移
        animation = [CABasicAnimation animationWithKeyPath:@"position"];
        //setFromValue不设置,默认以当前状态为准
        [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y + 200)]];
        }break;
        default:break;
        }
        [animation setDelegate:self];//代理回调
        [animation setDuration:0.25];//设置动画时间，单次动画时间
        [animation setRemovedOnCompletion:NO];//默认为YES,设置为NO时setFillMode有效
        /**
        *设置时间函数CAMediaTimingFunction
        *kCAMediaTimingFunctionLinear 匀速
        *kCAMediaTimingFunctionEaseIn 开始速度慢，后来速度快
        *kCAMediaTimingFunctionEaseOut 开始速度快 后来速度慢
        *kCAMediaTimingFunctionEaseInEaseOut = kCAMediaTimingFunctionDefault 中间速度快，两头速度慢
        */
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        //设置自动翻转
        //设置自动翻转以后单次动画时间不变，总动画时间增加一倍，它会让你前半部分的动画以相反的方式动画过来
        //比如说你设置执行一次动画，从a到b时间为1秒，设置自动翻转以后动画的执行方式为，先从a到b执行一秒，然后从b到a再执行一下动画结束
        [animation setAutoreverses:YES];
        //kCAFillModeForwards//动画结束后回到准备状态
        //kCAFillModeBackwards//动画结束后保持最后状态
        //kCAFillModeBoth//动画结束后回到准备状态,并保持最后状态
        //kCAFillModeRemoved//执行完成移除动画
        [animation setFillMode:kCAFillModeBoth];
        //将动画添加到layer,添加到图层开始执行动画，
        //注意:key值的设置与否会影响动画的效果
        //如果不设置key值每次执行都会创建一个动画，然后创建的动画会叠加在图层上
        //如果设置key值，系统执行这个动画时会先检查这个动画有没有被创建，如果没有的话就创建一个，如果有的话就重新从头开始执行这个动画
        //你可以通过key值获取或者删除一个动画:
        //[self.demoView.layer animationForKey:@""];
        //[self.demoView.layer removeAnimationForKey:@""]
        [self.demoView.layer addAnimation:animation forKey:@"baseanimation"];
}

/**
*  动画开始和动画结束时 self.demoView.center 是一直不变的，说明动画并没有改变视图本身的位置
*/
- (void)animationDidStart:(CAAnimation *)anim{
NSLog(@"动画开始------：%@",    NSStringFromCGPoint(self.demoView.center));
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
NSLog(@"动画结束------：%@",    NSStringFromCGPoint(self.demoView.center));
}


CASpringAnimation弹性动画

属性：
//理解下面的属性的时候可以结合现实物理现象,比如把它想象成一个弹簧上挂着一个金属小球
//质量,振幅和质量成反比
@property CGFloat mass;
//刚度系数(劲度系数/弹性系数),刚度系数越大,形变产生的力就越大,运动越快
@property CGFloat stiffness;
//阻尼系数,阻止弹簧伸缩的系数,阻尼系数越大,停止越快,可以认为它是阻力系数
@property CGFloat damping;
//初始速率,动画视图的初始速度大小速率为正数时,速度方向与运动方向一致,速率为负数时,速度方向与运动方向相反.
@property CGFloat initialVelocity;
//结算时间,只读.返回弹簧动画到停止时的估算时间，根据当前的动画参数估算通常弹簧动画的时间使用结算时间比较准确
@property(readonly) CFTimeInterval settlingDuration;

代码1:
CASpringAnimation *spring = [CASpringAnimation animationWithKeyPath:@"position.y"];
spring.damping = 5;
spring.stiffness = 100;
spring.mass = 1;
spring.initialVelocity = 0;
spring.duration = spring.settlingDuration;
spring.fromValue = @(self.demoView1.center.y);
spring.toValue = @(self.demoView1.center.y + (btn.selected?+200:-200));
spring.fillMode = kCAFillModeForwards;
[self.demoView1.layer addAnimation:spring forKey:nil];

代码2:自定义弹性动画
#import "UIView+ShakeAnimation.h"
#import <objc/runtime.h>
typedef void (^RunAnimationBlock)();
@interface UIView ()
@property (nonatomic,  copy)RunAnimationBlock block;
@end

@implementation UIView (ShakeAnimation)

-(void)startAnimationFromFrame:(CGRect)framef
toFrame:(CGRect)framet
duration:(CGFloat)duration
shakeTimes:(NSInteger)times
stretchPercent:(CGFloat)stretchPercent
completion:(void (^)(BOOL finished))completion
{
self.layer.masksToBounds = YES;

__block CGFloat perTime = duration / times;
__block CGFloat perx = (framet.origin.x - framef.origin.x) * stretchPercent / times;
__block CGFloat pery = (framet.origin.y - framef.origin.y) * stretchPercent / times;
__block CGFloat perw = (framet.size.width - framef.size.width) * stretchPercent / times;
__block CGFloat perh = (framet.size.height - framef.size.height) * stretchPercent / times;

__block UIView * tmpView = self;
__block NSInteger tmpTimes = (NSInteger)times;
__block NSInteger tmpsymbol = -1;

__weak typeof(self) weakSelf = self;
self.block = ^{

[UIView animateWithDuration:perTime animations:^{

CGFloat x = framet.origin.x + perx * tmpTimes;
CGFloat y = framet.origin.y + pery * tmpTimes;
CGFloat w = framet.size.width + perw * tmpTimes;
CGFloat h = framet.size.height + perh * tmpTimes;
CGRect rect = CGRectMake(x, y, w, h);

tmpView.frame = rect;
}completion:^(BOOL finished) {

tmpTimes = tmpTimes + tmpsymbol;
tmpTimes = - tmpTimes;
tmpsymbol = - tmpsymbol;
if (tmpTimes != 0) {
weakSelf.block();
}else{
[UIView animateWithDuration:perTime animations:^{
tmpView.frame = framet;
}completion:^(BOOL finished) {
completion(YES);
}];
}
}];
};

self.block();
}
static char RunAnimationBlockKey;
-(RunAnimationBlock)block{
return objc_getAssociatedObject(self, &RunAnimationBlockKey);
}
-(void)setBlock:(RunAnimationBlock)block{
objc_setAssociatedObject(self, &RunAnimationBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
调用：

[self.demoView2 startAnimationFromFrame:CGRectMake(10, 300, 100, 100)
toFrame:CGRectMake(10, 300, 300, 100)
duration:0.5
shakeTimes:5
stretchPercent:0.3
completion:^(BOOL finished) {
NSLog(@"======over======:%@",self.demoView1);
}];



5､CAKeyframeAnimation关键帧动画
属性：
//关键帧值数组,一组变化值
@property(nullable, copy) NSArray *values;
//关键帧帧路径,优先级比values大
@property(nullable) CGPathRef path;
//每一帧对应的时间,时间可以控制速度.它和每一个帧相对应,取值为0.0-1.0,不设则每一帧时间相等.
@property(nullable, copy) NSArray<NSNumber *> *keyTimes;
//每一帧对应的时间曲线函数,也就是每一帧的运动节奏
@property(nullable, copy) NSArray<CAMediaTimingFunction *> *timingFunctions;
//动画的计算模式,默认值: kCAAnimationLinear.有以下几个值:
//kCAAnimationLinear//关键帧为座标点的时候,关键帧之间直接直线相连进行插值计算;
//kCAAnimationDiscrete//离散的,也就是没有补间动画
//kCAAnimationPaced//平均，keyTimes跟timeFunctions失效
//kCAAnimationCubic对关键帧为座标点的关键帧进行圆滑曲线相连后插值计算,对于曲线的形状还可以通过tensionValues,continuityValues,biasValues来进行调整自定义,keyTimes跟timeFunctions失效
//kCAAnimationCubicPaced在kCAAnimationCubic的基础上使得动画运行变得均匀,就是系统时间内运动的距离相同,,keyTimes跟timeFunctions失效
@property(copy) NSString *calculationMode;
//动画的张力,当动画为立方计算模式的时候此属性提供了控制插值,因为每个关键帧都可能有张力所以连续性会有所偏差它的范围为[-1,1].同样是此作用
@property(nullable, copy) NSArray<NSNumber *> *tensionValues;
//动画的连续性值
@property(nullable, copy) NSArray<NSNumber *> *continuityValues;
//动画的偏斜率
@property(nullable, copy) NSArray<NSNumber *> *biasValues;
//动画沿路径旋转方式,默认为nil.它有两个值:
//kCAAnimationRotateAuto//自动旋转,
//kCAAnimationRotateAutoReverse//自动翻转
@property(nullable, copy) NSString *rotationMode;

6､CAAnimationGroup动画组

属性

//只有一个属性,数组中接受CAAnimation元素
@property(nullable, copy) NSArray<CAAnimation *> *animations;

可以看到CAAnimationGroup只有一个属性一个CAAnimation数组。而且它继承于CAAnimation，它具有CAAnimation的特性，所以它的用法和CAAnimation是一样的，不同的是他可以包含ñ个动画，也就是说他可以接受很多个CAAnimation并且可以让它们一起开始，这就造成了动画效果的叠加，效果就是ñ个动画同时进行。

7､CATransition转场动画

//转场类型,字符串类型参数.系统提供了四中动画形式:
//kCATransitionFade//逐渐消失
//kCATransitionMoveIn//移进来
//kCATransitionPush//推进来
//kCATransitionReveal//揭开
//另外,除了系统给的这几种动画效果,我们还可以使用系统私有的动画效果:
//@"cube",//立方体翻转效果
//@"oglFlip",//翻转效果
//@"suckEffect",//收缩效果,动画方向不可控
//@"rippleEffect",//水滴波纹效果,动画方向不可控
//@"pageCurl",//向上翻页效果
//@"pageUnCurl",//向下翻页效果
//@"cameralIrisHollowOpen",//摄像头打开效果,动画方向不可控
//@"cameraIrisHollowClose",//摄像头关闭效果,动画方向不可控
@property(copy) NSString *type;
//转场方向,系统一共提供四个方向:
//kCATransitionFromRight//从右开始
//kCATransitionFromLeft//从左开始
//kCATransitionFromTop//从上开始
//kCATransitionFromBottom//从下开始
@property(nullable, copy) NSString *subtype;
//开始进度,默认0.0.如果设置0.3,那么动画将从动画的0.3的部分开始
@property float startProgress;
//结束进度,默认1.0.如果设置0.6,那么动画将从动画的0.6部分以后就会结束
@property float endProgress;
//开始进度
@property(nullable, strong) id filter;

CATransition也是继承CAAnimation，系统默认提供了12种动画样式，加上4个动画方向，除了方向不可控的四种效果外，大概一共提供了36种动画。

另外系统还给UIView的添加了很多分类方法可以快速完成一些简单的动画，如下：

UIView（UIViewAnimation）

@interface UIView(UIViewAnimation)

+ (void)beginAnimations:(nullable NSString *)animationID context:(nullable void *)context;  // additional context info passed to will start/did stop selectors. begin/commit can be nested
//提交动画
+ (void)commitAnimations;
//设置代理
+ (void)setAnimationDelegate:(nullable id)delegate;                          //设置动画开始方法
+ (void)setAnimationWillStartSelector:(nullable SEL)selector;                
//设置动画结束方法
+ (void)setAnimationDidStopSelector:(nullable SEL)selector;
//设置动画时间:default = 0.2
+ (void)setAnimationDuration:(NSTimeInterval)duration;              
//设置动画延迟开始时间:default = 0.0
+ (void)setAnimationDelay:(NSTimeInterval)delay;
//设置动画延迟开始日期:default = now ([NSDate date])
+ (void)setAnimationStartDate:(NSDate *)startDate;                  
//设置动画运动曲线:default =UIViewAnimationCurveEaseInOut
//UIViewAnimationCurveEaseInOut,//慢进慢出
//UIViewAnimationCurveEaseIn, //慢进快出
//UIViewAnimationCurveEaseOut,//快进慢出
//UIViewAnimationCurveLinear//匀速
+ (void)setAnimationCurve:(UIViewAnimationCurve)curve;              
//设置重复次数: default = 0.0.  May be fractional
+ (void)setAnimationRepeatCount:(float)repeatCount;
//设置是否翻转动画: default = NO. used if repeat 
+ (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses;
//设置动画是否从当前状态开始:default = NO
+ (void)setAnimationBeginsFromCurrentState:(BOOL)fromCurrentState;
//设置动画类型
+ (void)setAnimationTransition:(UIViewAnimationTransition)transition forView:(UIView *)view cache:(BOOL)cache; 
//设置动画是否有效
+ (void)setAnimationsEnabled:(BOOL)enabled;
//
+ (BOOL)areAnimationsEnabled;
//
+ (void)performWithoutAnimation:(void (^)(void))actionsWithoutAnimation
//
+ (NSTimeInterval)inheritedAnimationDuration 
@end


UIView（UIViewAnimationWithBlocks）
@interface UIView(UIViewAnimationWithBlocks)
//以下方法都大同小异,就不一一做注释了
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;
+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion 
+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations;
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)dampingRatio initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion
+ (void)transitionWithView:(UIView *)view duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^ __nullable)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;
+ (void)transitionFromView:(UIView *)fromView toView:(UIView *)toView duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^ __nullable)(BOOL finished))completion;
+ (void)performSystemAnimation:(UISystemAnimation)animation onViews:(NSArray<__kindof UIView *> *)views options:(UIViewAnimationOptions)options animations:(void (^ __nullable)(void))parallelAnimations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);

@end


UIView（UIViewKeyframeAnimations）
+ (void)animateKeyframesWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewKeyframeAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;
+ (void)addKeyframeWithRelativeStartTime:(double)frameStartTime relativeDuration:(double)frameDuration animations:(void (^)(void))animations

//单视图转场动画
+ (void)transitionWithView:(UIView *)view
duration:(NSTimeInterval)duration 
options:(UIViewAnimationOptions)options
animations:(void (^ __nullable)(void))animations
completion:(void (^ __nullable)(BOOL finished))completion
//双视图转场动画
+ (void)transitionFromView:(UIView *)fromView
toView:(UIView *)toView 
duration:(NSTimeInterval)duration 
options:(UIViewAnimationOptions)options
completion:(void (^ __nullable)(BOOL finished))completion

这两个都是转场动画，不同的是第一个是单视图转场，第二个是双视图转场不过需要注意的是：单视图转场动画只能用作属性动画做不到的转场效果，比如属性动画不能给的UIImageView的形象赋值操作做动画效果等。

我们可以看到以上两个方法中都有一个共同的参数：
UIViewAnimationOptions
typedef NS_OPTIONS(NSUInteger, UIViewAnimationOptions) {
UIViewAnimationOptionLayoutSubviews            = 1 <<  0,
UIViewAnimationOptionAllowUserInteraction      = 1 <<  1, // turn on user interaction while animating
UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2, // start all views from current value, not initial value
UIViewAnimationOptionRepeat                    = 1 <<  3, // repeat animation indefinitely
UIViewAnimationOptionAutoreverse               = 1 <<  4, // if repeat, run animation back and forth
UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5, // ignore nested duration
UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6, // ignore nested curve
UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7, // animate contents (applies to transitions only)
UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8, // flip to/from hidden state instead of adding/removing
UIViewAnimationOptionOverrideInheritedOptions  = 1 <<  9, // do not inherit any options or animation type

UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // default
UIViewAnimationOptionCurveEaseIn               = 1 << 16,
UIViewAnimationOptionCurveEaseOut              = 2 << 16,
UIViewAnimationOptionCurveLinear               = 3 << 16,

UIViewAnimationOptionTransitionNone            = 0 << 20, // default
UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,
} NS_ENUM_AVAILABLE_IOS(4_0);

可以看到系统给到的是一个位移枚举，这就意味着这个枚举可以多个值同时使用，但是怎么用呢？其实那些枚举值可以分为三个部分。
我们分别看一下每个枚举的意思：
第一部分：动画效果
UIViewAnimationOptionTransitionNone//没有效果
UIViewAnimationOptionTransitionFlipFromLeft//从左水平翻转
UIViewAnimationOptionTransitionFlipFromRight//从右水平翻转
UIViewAnimationOptionTransitionCurlUp//翻书上掀
UIViewAnimationOptionTransitionCurlDown//翻书下盖UIViewAnimationOptionTransitionCrossDissolve//融合
UIViewAnimationOptionTransitionFlipFromTop//从上垂直翻转                    UIViewAnimationOptionTransitionFlipFromBottom//从下垂直翻转

第二部分：动画运动曲线
//开始慢，加速到中间，然后减慢到结束
UIViewAnimationOptionCurveEaseInOut
//开始慢，加速到结束
UIViewAnimationOptionCurveEaseIn
//开始快，减速到结束
UIViewAnimationOptionCurveEaseOut
//线性运动
UIViewAnimationOptionCurveLinear

第三部分：其他
//默认，跟父类作为一个整体
UIViewAnimationOptionLayoutSubviews
//设置了这个，主线程可以接收点击事件
UIViewAnimationOptionAllowUserInteraction
//从当前状态开始动画，父层动画运动期间，开始子层动画.
UIViewAnimationOptionBeginFromCurrentState
//重复执行动画，从开始到结束， 结束后直接跳到开始态
UIViewAnimationOptionRepeat
//反向执行动画，结束后会再从结束态->开始态
UIViewAnimationOptionAutoreverse
//忽略继承自父层持续时间，使用自己持续时间（如果存在）
UIViewAnimationOptionOverrideInheritedDuration
//忽略继承自父层的线性效果，使用自己的线性效果（如果存在）
UIViewAnimationOptionOverrideInheritedCurve
//允许同一个view的多个动画同时进行     
UIViewAnimationOptionAllowAnimatedContent     
//视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）             UIViewAnimationOptionShowHideTransitionViews
//不继承父动画设置或动画类型.
UIViewAnimationOptionOverrideInheritedOptions

这下可以看到，这些枚举功能都不一样但是可以随意组合，但是组合的时候需要注意，类型同一枚举的一起不能使用比如UIViewAnimationOptionCurveEaseIn状语从句：UIViewAnimationOptionCurveEaseOut



