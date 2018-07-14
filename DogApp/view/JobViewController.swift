//
//  JobViewController.swift
//  DogApp
//
//  Created by Admin on 7/10/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class JobViewController: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var txtDiemNhan: UILabel!
    @IBOutlet weak var txtDiemGiao: UILabel!
    @IBOutlet weak var txtKhoangCach: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtDiemNhan.text = DiemNhan
        txtDiemGiao.text = DiemGiao
        txtKhoangCach.text = KhoangCach
        let time = timePicker.date
        let gio = Calendar.current.component(.hour, from: time)
        let phut = Calendar.current.component(.minute, from: time)
        print("gio:",gio)
        print("phut:",phut)
    }

    @IBAction func btnNhanViec(_ sender: UIButton) {
        let googleMap = self.storyboard?.instantiateViewController(withIdentifier: "googlemap")
        self.present(googleMap!, animated: true, completion: nil)
    }
    @IBAction func btnTuChoi(_ sender: UIButton) {
        let googleMap = self.storyboard?.instantiateViewController(withIdentifier: "googlemap")
        self.present(googleMap!, animated: true, completion: nil)
    }
}
