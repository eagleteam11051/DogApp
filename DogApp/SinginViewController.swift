//
//  SinginViewController.swift
//  DogApp
//
//  Created by Admin on 7/3/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
class SinginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func btnLogin(_ sender: Any) {
//        guard let a = txtEmail.text else{ return}
//        guard let b = txtPass.text else{return}
        
        let headers: HTTPHeaders = [
            "X-API-KEY": "8s0wswowcgc4owoc0oc8g00cwok8gkw800k8o08w",
            "Accept": "application/json"
        ]
        
        Alamofire.request("http://shipx.vn/api/index.php/VinterSignin/?token=da&mobile=0945333445&password=123456&phone_os=2",headers: headers).responseJSON {(response) in
           // let Value = response.result.value as! [String: Any]
            let Value = response.result.value as! [String: Any]
            let Status = Value["status"] as! String
            if (Status == "success"){
                 var Response = Value["response"] as! [String: Any]
                let Token = Response["token"] as! String
                heroID  = Response["hero_id"] as! String
                name  = Response["fullname"] as? String ?? " "
                tien = Response["balance"] as? String ?? " "
                diachi = Response["address"] as? String ?? " "
                linkima = Response["image"] as? String ?? " "
                
//                self.Response(present("homepage", animated: true, completion: nil))
//                self.Token(present("homepage", animated: true, completion: nil))
//                self.Hero(present("homepage", animated: true, completion: nil))
                
                if (Token.isEmpty){
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
                let homePage = self.storyboard?.instantiateViewController(withIdentifier: "homepage")
                self.present(homePage!, animated: true, completion: nil)
            }
            if (Status == "error"){
                let alert = UIAlertController(title: "Chưa đăng nhập được", message: "Tài khoản mật khẩu không đúng", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "Canncl", style: .default){
                    (action) in print("This is ")
                }
                alert.addAction(action1)
                _ = self.present(alert, animated: true, completion: nil)
            }
            
           
                
            
            
        }
    }
}
