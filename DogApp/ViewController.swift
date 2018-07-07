//
//  ViewController.swift
//  DogApp
//
//  Created by Admin on 7/3/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView
class ViewController: UIViewController {
    let kSuccessTitle = "Congratulations"
    let kErrorTitle = "Connection error"
    let kNoticeTitle = "Notice"
    let kWarningTitle = "Warning"
    let kInfoTitle = "Info"
    let kSubtitle = "You've just displayed this awesome Pop Up View"
    
    let kDefaultAnimationDuration = 2.0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        let headers: HTTPHeaders = [
            "X-API-KEY": "8s0wswowcgc4owoc0oc8g00cwok8gkw800k8o08w",
            "Accept": "application/json"
        ]
        let alert = SCLAlertView()
        
        var txtEmail = alert.addTextField("Enter your Email")
        var txtPass = alert.addTextField("Enter your Pass")
        let btn = alert.addButton("Login") {
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            
            let alert = SCLAlertView(appearance: appearance).showWait("Đang đăng nhập", subTitle: "Vui lòng chờ...", closeButtonTitle: nil, timeout: nil, colorStyle: nil, colorTextButton: 0x3f4449, circleIconImage: nil, animationStyle: SCLAnimationStyle.topToBottom)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                alert.close()
                let homePage = self.storyboard?.instantiateViewController(withIdentifier: "homepage")
                self.present(homePage!, animated: true, completion: nil)
            }
            Alamofire.request("http://shipx.vn/api/index.php/VinterSignin/?token=da&mobile=0945333445&password=123456&phone_os=2",headers: headers).responseJSON {(response) in
                let Value = response.result.value as! [String: Any]
                let Status = Value["status"] as! String
                if (Status == "success"){
                    var Response = Value["response"] as! [String: Any]
                    //let Token = Response["token"] as! String
                    heroID  = Response["hero_id"] as! String
                    name  = Response["fullname"] as? String ?? " "
                    tien = Response["balance"] as? String ?? " "
                    diachi = Response["address"] as? String ?? " "
                    linkima = Response["image"] as? String ?? " "
                    token = Response["token"] as? String ?? " "
                    print(token)
                    
                    
                }
                if (Status == "error"){
//                    let alert = UIAlertController(title: "Chưa đăng nhập được", message: "Tài khoản mật khẩu không đúng", preferredStyle: .alert)
//                    let action1 = UIAlertAction(title: "Canncl", style: .default){
//                        (action) in print("This is ")
//                    }
//                    alert.addAction(action1)
//                    _ = self.present(alert, animated: true, completion: nil)
                    _ = SCLAlertView().showError("Lỗi đăng nhập", subTitle:"Tài khoản mật khẩu không đúng", closeButtonTitle:"OK")
                }
        }
        }
                if (token.isEmpty){
                    let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
        
                        case .cancel:
                            print("cancel")
        
                        case .destructive:
                            print("destructive")
        
        
                        }}))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
        
            _ = alert.showSuccess(self.kSuccessTitle, subTitle: self.kSubtitle)
        }
        
        
    }
