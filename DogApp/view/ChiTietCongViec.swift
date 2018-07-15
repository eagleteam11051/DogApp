//
//  ChiTietCongViec.swift
//  DogApp
//
//  Created by Admin on 7/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit


class ChiTietCongViec: UIViewController {

    @IBAction func banDo(_ sender: Any) {
        let bando = storyboard?.instantiateViewController(withIdentifier: "bando") as! BanDoCongViec
        bando.order = self.order
        self.present(bando, animated: true, completion: nil)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBOutlet weak var diemnhan: UILabel!
    @IBOutlet weak var diemgiao: UILabel!
    @IBOutlet weak var khoangcach: UILabel!
    @IBOutlet weak var sodienthoai: UILabel!
    @IBOutlet weak var yeucau: UILabel!
    @IBOutlet weak var tienthuho: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dn:String = (order?.pickup?.address!)!
        diemnhan.text = "Điểm Nhận: \(dn)"
        let dg:String = (order?.dropoff?.address!)!
        diemgiao.text = "Điểm Giao: \(dg)"
        let kc:String = (order?.distance!)!
        khoangcach.text = "Khoảng Cách: \(kc) Km"
        let sdt:String = (order?.pickup?.mobile ?? "null")!
        sodienthoai.text = "Số Điện Thoại: \(sdt)"
        let yc:String = (order?.note!)!
        yeucau.text = "Yêu Cầu: \(yc)"
        let tth:String = (order?.money_first!)!
        tienthuho.text = "Tiền Thu Hộ: \(tth)đ"
        // Do any additional setup after loading the view.
    }
    
    var order:Order?

}
