//
//  ChiTietThongBao.swift
//  DogApp
//
//  Created by Admin on 7/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ChiTietThongBao: UIViewController {
    var thongBao:ThongBaoObj? = nil
    
    @IBOutlet weak var lblThoiGian: UILabel!
    @IBOutlet weak var lblNoiDung: UILabel!
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tgian:String = (thongBao?.created_time!)!
        lblThoiGian.text = "⏰ \(tgian)"
       
        
        let mess:String = (thongBao?.message!)!
        lblNoiDung.text = "\(mess)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
