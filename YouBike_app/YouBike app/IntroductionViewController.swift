//
//  IntroductionViewController.swift
//  week_2_part_3
//
//  Created by 許雅筑 on 2016/9/8.
//  Copyright © 2016年 許雅筑. All rights reserved.
//

import UIKit
import SafariServices


class IntroductionViewController: UIViewController,SFSafariViewControllerDelegate {
    var facebookLinkUrl: String = ""
    @IBOutlet weak var headImage: UIImageView!
    
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var profileView: UIView!
    
//    let myLogin:LogInFacebookViewController = LogInFacebookViewController()
    var myPictureUrl: String = ""
    
    var myName: String = ""
    
    // for picture
//    func loadImageFromUrl(url: String, view: UIImageView){
        
        // Create Url from string
//        let url = NSURL(string: url)!
        // Download task:
        // - sharedSession = global NSURLCache, NSHTTPCookieStorage and NSURLCredentialStorage objects.
//        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (responseData, responseUrl, error) -> Void in
            // if responseData is not null...
//            if let data = responseData{
                // execute in UI thread
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    view.image = UIImage(data: data)
//                })
//            }
//        }
        
        // Run task
//        task.resume()
//    }
    @IBOutlet weak var clearView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //圖片
//        myPictureUrl = myLogin.userDefault.objectForKey("userPictureURL") as! String
//        loadImageFromUrl(myPictureUrl, view: headImage)
        
        
        clearView.layer.masksToBounds = false
        clearView.layer.cornerRadius = headImage.frame.size.width/2
        clearView.clipsToBounds = true
        clearView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.25)
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "pattern-wood")!)

        headImage.layer.masksToBounds = false
        headImage.layer.cornerRadius = headImage.frame.size.width/2
        headImage.clipsToBounds = true

//        myNameLabel.text = myLogin.userDefault.objectForKey("userName") as? String

        
        // Add rounded corners
        //不可在這邊，右邊不能用
//       let maskLayer = CAShapeLayer()
//       maskLayer.frame = profileView.bounds
//       maskLayer.path = UIBezierPath(roundedRect: profileView.bounds, byRoundingCorners: [ .BottomRight, .BottomLeft], cornerRadii: CGSize(width: 10, height: 10)).CGPath
//       profileView.layer.mask = maskLayer
        
    }
    
    override func viewDidLayoutSubviews() {

        profileView.backgroundColor = UIColor.clear
        profileView.layer.shadowColor = UIColor.black.cgColor
        profileView.layer.shadowOffset = CGSize(width: 1, height: 2)
        profileView.layer.shadowOpacity = 0.7
        profileView.layer.shadowRadius = 2.5
        
        // 圓角，多創一層
        let borderView = UIView()
        borderView.frame = profileView.bounds
        borderView.layer.cornerRadius = 20
        borderView.layer.backgroundColor = UIColor(red: 254/255, green: 240/255, blue: 220/255, alpha: 1).cgColor
        borderView.layer.masksToBounds = true
        profileView.addSubview(borderView)
        //cornerRadius shadow 與 border 相同
        profileView.layer.shadowPath = UIBezierPath(roundedRect: profileView.bounds, cornerRadius: 20).cgPath
        profileView.layer.insertSublayer(borderView.layer, at: 0)

        profileView.layer.shouldRasterize = true
        profileView.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    }

