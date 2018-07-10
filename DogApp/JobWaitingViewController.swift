//
//  JobWaitingViewController.swift
//  DogApp
//
//  Created by Admin on 7/8/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class JobWaitingViewController: UIViewController {

    let mainTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        self.view.addSubview(mainTableView)
        
        //Tương ứng với cách top 100px, cách cạnh trái: 20px, cạnh phải: 20px, và cách cạnh dưới 10px
        mainTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        mainTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
