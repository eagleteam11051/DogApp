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
    
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tokenfb = getCache(key: "tokenfb") ?? ""
        mail1 = getCache(key: "mail") ?? ""
        pass1 = getCache(key: "pass") ?? ""
        if CheckInternet.Connection(){
        if(getCache(key: "mail") != nil && getCache(key: "pass") != nil){
            login(mail: getCache(key: "mail")!, pass: getCache(key: "pass")!)
        }
        }else{
            let alertController = UIAlertController(title: "Thông Báo", message: "Máy bạn hiện không có kết nối Internet vui lòng bật dữ liệu mạng và thử lại.", preferredStyle: .alert)
            
            
            let okAction = UIAlertAction(title: "OK", style:.default) {
                UIAlertAction in
                NSLog("OK Pressed")
                
            }
            
            // Add the actions
            alertController.addAction(okAction)
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
        }
        

        

    }

    
    func login(mail:String,pass:String){
        
        
            let headers: HTTPHeaders = [
                "X-API-KEY": "8s0wswowcgc4owoc0oc8g00cwok8gkw800k8o08w"]
            Alamofire.request("http://shipx.vn/api/index.php/VinterSignin/?mobile=\(mail)&password=\(pass)&token=\(tokenfb)&phone_os=2",headers: headers).responseJSON {(response) in
                print("value",response)
                let Value = response.result.value as! [String: Any]
                let Status = Value["status"] as! String
                print(Status)
                if (Status == "success"){
                    print("da oke")
                    var Response = Value["response"] as! [String: Any]
                    //let Token = Response["token"] as! String
                    heroID  = Response["hero_id"] as! String
                    name  = Response["fullname"] as? String ?? " "
                    tien = Response["balance"] as? String ?? " "
                    diachi = Response["address"] as? String ?? " "
                    linkima = Response["image"] as? String ?? " "
                    tokenlogin = Response["token"] as? String ?? " "
                    saveCache(key: "mail", value: mail)
                    saveCache(key: "pass", value: pass)
                    
                    //  UserDefaults.standard.set(true, forKey: "tokenfb")
                    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "homepage")
                    self.present(homePage!, animated: true, completion: nil)
                    
                }
                if (Status == "error"){
                    _ = SCLAlertView().showError("Lỗi đăng nhập", subTitle:"Tài khoản mật khẩu không đúng", closeButtonTitle:"OK")
                }
                
        }
    }
    
    @IBAction func btnSingin(_ sender: Any) {
        let mail = txtEmail.text!
        let pass = txtPass.text!
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alert = SCLAlertView(appearance: appearance).showWait("Đang đăng nhập", subTitle: "Vui lòng chờ...", closeButtonTitle: nil, timeout: nil, colorStyle: nil, colorTextButton: 0x3f4449, circleIconImage: nil, animationStyle: SCLAnimationStyle.topToBottom)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            alert.close()
            if CheckInternet.Connection(){
                self.login(mail: mail, pass: pass)
            }else{
                let alertController = UIAlertController(title: "Thông Báo", message: "Máy bạn hiện không có kết nối Internet vui lòng bật dữ liệu mạng và thử lại.", preferredStyle: .alert)
                
                
                let okAction = UIAlertAction(title: "OK", style:.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                    
                }
                
                // Add the actions
                alertController.addAction(okAction)
                // Present the controller
                self.present(alertController, animated: true, completion: nil)
            }
            
        //let dn:String = (order?.pickup?.address!)!
        //diemnhan.text = "Điểm Nhận: \(dn)"
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return (true)
    }

}
