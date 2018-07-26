//
//  ChiTietCongViec.swift
//  DogApp
//
//  Created by Admin on 7/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit


class ChiTietCongViec: UIViewController {
    func time(){
        let timeInterval = NSDate().timeIntervalSince1970
        print(timeInterval)
        //create_time_int
        let timeDat: String = (order?.create_time_int!)!
        let time = Int(timeDat)! - Int(timeInterval)
        let time1 = Int(timeInterval) - Int(timeDat)!
        print(timeDat)
        seconds = time
        print(time)
        print(time1)
    }
    var seconds: Int = 0
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    @IBAction func banDo(_ sender: Any) {
        let bando = storyboard?.instantiateViewController(withIdentifier: "bando") as! BanDoCongViec
        bando.order = self.order
        self.present(bando, animated: true, completion: nil)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var diemnhan: UILabel!
    @IBOutlet weak var diemgiao: UILabel!
    @IBOutlet weak var khoangcach: UILabel!
    @IBOutlet weak var sodienthoai: UILabel!
    @IBOutlet weak var sdtnguoinhan: UILabel!
    @IBOutlet weak var yeucau: UILabel!
    @IBOutlet weak var tienthuho: UILabel!
    @IBOutlet weak var Tongtien: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dn:String = (order?.pickup?.address!)!
        diemnhan.text = "Điểm Nhận: \(dn)"
        let dg:String = (order?.dropoff?.address!)!
        diemgiao.text = "Điểm Giao: \(dg)"
        let kc:String = (order?.distance!)!
        khoangcach.text = "Khoảng Cách: \(kc) Km"
        let sdtnn:String = (order?.phone_number ?? "Trống")!
        sdtnguoinhan.text = "SDT Người Nhận: \(sdtnn)"
        let sdt:String = (order?.pickup?.mobile ?? "Trống")!
        sodienthoai.text = "Số Điện Thoại: \(sdt)"
        let yc:String = (order?.note!)!
        yeucau.text = "Yêu Cầu: \(yc)"
        let tth:String = (order?.money_first!)!
        tienthuho.text = "Tiền Thu Hộ: \(tth)đ"
        var tiennhan: String = (order?.fee!)!
        let tongtien: String = (order?.total!)!
        Tongtien.text = "Tổng tiền: \(tongtien)đ"
        // Do any additional setup after loading the view.
        runTimer()
        time()
    }
    @IBAction func btnSDT(_ sender: Any) {
        let sdt:String = (order?.pickup?.mobile ?? "Trống")!
       
        if #available(iOS 10.0, *) {
            
           let phonenumber = URL(string:"tel:" + sdt)
            UIApplication.shared.open(phonenumber!)
        } else {
            var url: NSURL = NSURL(string:"tel://" + sdt)!
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func btnSDTN(_ sender: Any) {
         let sdtnn:String = (order?.phone_number ?? "Trống")!
        if #available(iOS 10.0, *) {
            let phonenumber = URL(string:"tel:" + sdtnn )
            UIApplication.shared.open(phonenumber!)
        } else {
            var url: NSURL = NSURL(string:"tel://" + sdtnn)!
            UIApplication.shared.openURL(url as URL)
        }
    }
    var order:Order?
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ChiTietCongViec.updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        if seconds < 1 {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
            timerLabel.textColor = UIColor.red
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
            timerLabel.textColor = UIColor.blue
        }
    }
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"⏰ %02i:%02i:%02i", hours, minutes, seconds)
    }

}
