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

