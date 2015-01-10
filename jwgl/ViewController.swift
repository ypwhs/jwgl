//
//  ViewController.swift
//  jwgl
//
//  Created by 杨培文 on 14/12/10.
//  Copyright (c) 2014年 杨培文. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var yzmImageView: UIImageView!
    
    @IBAction func getPictureAction(sender: AnyObject) {
        var a = NSURLRequest(URL: NSURL(string: "http://jwgl.btbu.edu.cn/verifycode.servlet")!)
        var res:NSURLResponse?
        var data:NSData?
        xiancheng({
            data = NSURLConnection.sendSynchronousRequest(a, returningResponse: &res, error: nil)
            if data != nil {
                if let img = UIImage(data: data!){
                    self.getyzm(img)
                }
            }
            data = nil
            res = nil
        })
    }
    func getyzm(img:UIImage) -> String {
        let cg = img.CGImage
        let w = Int(CGImageGetWidth(cg))
        let h = Int(CGImageGetHeight(cg))
        let provider = CGImageGetDataProvider(cg)
        let cfdata = CGDataProviderCopyData(provider)
        let data = NSData(data: cfdata)
        var yzm = ""
        yzm = oc().shibie(data, withW: w, withH: h)
        println(yzm)
        ui({
            self.yzmlabel.text = yzm
            self.yzmImageView.image=img
        })
        return yzm
    }
    
    @IBAction func getPicture2(sender: AnyObject) {
        var a = NSURLRequest(URL: NSURL(string: "http://www.btbu.edu.cn/cms/modules/showimage.jsp")!)
        var res:NSURLResponse?
        var data:NSData?
        xiancheng({
            data = NSURLConnection.sendSynchronousRequest(a, returningResponse: &res, error: nil)
            if data != nil {
                if let img = UIImage(data: data!){
                    self.getyzm2(img)
                }
            }
            data = nil
            res = nil
        })
    }
    func getyzm2(img:UIImage) -> String {
        let cg = img.CGImage
        let w = Int(CGImageGetWidth(cg))
        let h = Int(CGImageGetHeight(cg))
        let provider = CGImageGetDataProvider(cg)
        let cfdata = CGDataProviderCopyData(provider)
        let data = NSData(data: cfdata)
        var yzm = ""
        yzm = oc().shibiew(data, withW: w, withH: h)
        println(yzm)
        
        let x=6
        let y=3
        let width=10
        let height=13
        
        var i1 = UIImage(CGImage: CGImageCreateWithImageInRect(img.CGImage, CGRect(x: x, y: y, width: width, height: height)))
        
        var i2 = UIImage(CGImage: CGImageCreateWithImageInRect(img.CGImage, CGRect(x: x+13, y: y, width: width, height: height)))
        
        var i3 = UIImage(CGImage: CGImageCreateWithImageInRect(img.CGImage, CGRect(x: x+13*2, y: y, width: width, height: height)))
        
        var i4 = UIImage(CGImage: CGImageCreateWithImageInRect(img.CGImage, CGRect(x: x+13*3, y: y, width: width, height: height)))

        
        
        ui({
            self.yzmlabel2.text = yzm
            self.yzmImageView2.image=img
            self.yzm1.image = i1
            self.yzm2.image = i2
            self.yzm3.image = i3
            self.yzm4.image = i4
        })
        return yzm
    }
    @IBOutlet weak var yzm1: UIImageView!
    @IBOutlet weak var yzm2: UIImageView!
    @IBOutlet weak var yzm3: UIImageView!
    @IBOutlet weak var yzm4: UIImageView!
    
    @IBOutlet weak var yzmImageView2: UIImageView!
    @IBOutlet weak var yzmlabel2: UILabel!
    
    @IBOutlet weak var yzmlabel: UILabel!
    
    @IBAction func suiji(sender: AnyObject) {
        var str = "中午把电脑和手机都设置好了，但是下午上完课回来以后就再也连不上auto了，熄灯以后，不管是btbu还是auto都连不上啊？！！！！！！好好的btbu为什么要改啊，本来我们用着挺方便的，但是你这一改，手机已经几个月都是在用自己流量啊，话费撑不住啊！！对于一个宿舍没有装外网的人，好多天都没有见过外网啊！！！"
//        var com = ["win7","windows8","win8","xp","mac","OS X"]
        var su = [["老师您好","老师好","老师","您好","崩溃了","好烦啊","到底有没有完","为什么会这样"],[",",""],["我的手机是","我用的是","我手机"],["安卓的","ios设备","苹果","iphone","三星手机","小米手机","wp系统","华为手机","新买的"],[","],["连接"],["BTBU","BTBU-AUTO","btbu","Btbu","AUTO"],["的时候","一直都","总是","老是","一直",""],["连不上","一直要身份验证","没反应"],[","],["弄了好几次","删除了重新添加了","加*和不加*都试过了","重新看过上网步骤了","换了地方重试","我整个人都不好了还",],["都一样","也不行","也不可以","都连不上","还是不行"],[","],["到底","究竟",""],["让不让人上","为什么要加密码","还能不能上","为什么上不去","让不让人选课了","我整个人都快崩溃了"],["啊","","!!!"]]
//        var su2 = [["上午","早上","昨天"],["刚","才",""],["按照教程","","对照官网","按照操作"],["把电脑设置好了","","设置好电脑"],[","]]
        var test = ""
        for i in 0..<su.count{
            test+=su[i][ran(su[i].count)]
        }
        println(test)
        
    }
    
    func ran(a:Int)->Int{
        return Int(arc4random())%a
    }
    
    func show(show:String){
        ui({
            UIAlertView(title: "", message: show, delegate: nil, cancelButtonTitle: "确定").show()
        })
    }
    
    func xiancheng(code:dispatch_block_t){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), code)
    }
    func ui(code:dispatch_block_t){
        dispatch_async(dispatch_get_main_queue(), code)
    }

}

