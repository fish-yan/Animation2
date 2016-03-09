//
//  ViewController.swift
//  Animation2
//
//  Created by 薛焱 on 16/3/8.
//  Copyright © 2016年 薛焱. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var balloon: UIImageView!
    @IBOutlet weak var animationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func animationAction(sender: AnyObject) {

        //CALayer
//        layerAnimation()
        //CABasicAnimation
//        basicAnimation()
        //关键帧动画
//        keyFrameAnimation()
        //过度动画
//        transitionAnimation()
        //分组动画
        animationGroup()
    }
    
        //CALayer 动画
    func layerAnimation(){
        //锚点 anchorPoint 锚点决定layer层上的那个点是position点 锚点默认是(0.5,0.5)跟视图的中心点重合
        //基准点 position 决定当前视图的layer在父视图上得位置,他以父视图的坐标系为准,
         //视图创建出来的时候锚点,中心点,基准点是重合的,
        animationView.layer.anchorPoint = CGPointMake(0.5, 0);
        animationView.transform = CGAffineTransformRotate(self.animationView.transform, CGFloat(M_PI_4));
        animationView.layer.position = CGPointMake(200, 300);
    }
    //MARK: - CAAnimation
    //CABasicAnimation
    func basicAnimation(){
        //CA动画是根据KVC的原理去修改layer层的属性,以达到做动画的效果
        //keypath一般为"position"和"transform"，以及他们等点出来的属性
        let basic = CABasicAnimation(keyPath: "position.x")
        basic.duration = 3.0
        basic.repeatCount = 5
        basic.fromValue = -80
        basic.toValue = 500
        animationView.layer.addAnimation(basic, forKey: nil)
    }
    //关键帧动画
    func keyFrameAnimation(){
        let keyFrame = CAKeyframeAnimation(keyPath: "position")
        keyFrame.duration = 5
        keyFrame.repeatCount = 5
        //节点位置
        let point1 = animationView.center
        let point2 = CGPoint(x: 200, y: 100)
        let point3 = CGPoint(x: 100, y: point1.y)
        let point4 = CGPoint(x: 300, y: point1.y)
        let value1 = NSValue(CGPoint: point1)
        let value2 = NSValue(CGPoint: point2)
        let value3 = NSValue(CGPoint: point3)
        let value4 = NSValue(CGPoint: point4)
        //将节点位置加入到values中
        keyFrame.values = [value1, value4, value2, value3, value1]
        self.animationView.layer.addAnimation(keyFrame, forKey: nil)
    }
    //CALayer过度动画
    func transitionAnimation(){
        let transiton = CATransition()
        transiton.duration = 1
        transiton.repeatCount = 5
        transiton.type = "rippleEffect"
        self.view.layer.addAnimation(transiton, forKey: nil)
        /*
        *  各种动画效果  其中除了'fade', `moveIn', `push' , `reveal' ,其他属于私有的API(我是这么认为的,可以点进去看下注释).
        
        *  ↑↑↑上面四个可以分别使用'kCATransitionFade', 'kCATransitionMoveIn', 'kCATransitionPush', 'kCATransitionReveal'来调用.
        
        *  @"cube"                     立方体翻滚效果
        
        *  @"moveIn"                   新视图移到旧视图上面
        
        *  @"reveal"                   显露效果(将旧视图移开,显示下面的新视图)
        
        *  @"fade"                     交叉淡化过渡(不支持过渡方向)             (默认为此效果)
        
        *  @"pageCurl"                 向上翻一页
        
        *  @"pageUnCurl"               向下翻一页
        
        *  @"suckEffect"               收缩效果，类似系统最小化窗口时的神奇效果(不支持过渡方向)
        
        *  @"rippleEffect"             滴水效果,(不支持过渡方向)
        
        *  @"oglFlip"                  上下左右翻转效果
        
        *  @"rotate"                   旋转效果
        
        *  @"push"
        
        *  @"cameraIrisHollowOpen"     相机镜头打开效果(不支持过渡方向)
        
        *  @"cameraIrisHollowClose"    相机镜头关上效果(不支持过渡方向)
        
        */
    }
    //CAAnimationGroup分组动画
    func animationGroup(){
        //创建第一个关键帧动画,给热气球提供一个运动轨迹,
        let keyFramePath = CAKeyframeAnimation(keyPath: "position")
        //贝赛尔曲线
        //1.指定贝塞尔曲线的半径
        //CGFloat radius = kScreenHeight;
        //01.圆心
        //02.半径
        //03.开始角度
        //04.结束角度
        //05.旋转方向,YES是顺时针,NO是逆时针
        let path = UIBezierPath(arcCenter: CGPoint(x: -100, y: 300), radius: 300, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(M_PI_2), clockwise: true)
        keyFramePath.path = path.CGPath
        //2设置动画执行完毕后，不删除动画
        keyFramePath.removedOnCompletion = false
        //3设置保存动画的最新状态
        keyFramePath.fillMode = kCAFillModeForwards
        //1.4设置动画执行的时间
        keyFramePath.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        //创建第二个关键帧动画,让热气球运动的时候由小-->大-->小
        let keyFrameScale = CAKeyframeAnimation(keyPath: "transform.scale")
        keyFrameScale.values = [1.0,1.2,1.4,1.8,2.2,1.8,1.4,1.2,1.0]
        let group = CAAnimationGroup()
        group.duration = 8
        group.repeatCount = 100
        //将两个动画效果添加到分组动画中
        group.animations = [keyFramePath, keyFrameScale]
        balloon.layer.addAnimation(group, forKey: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

