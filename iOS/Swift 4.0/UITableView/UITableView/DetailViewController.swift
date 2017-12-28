//
//  DetailViewController.swift
//  UITableView
//
//  Created by Shridhar Mali on 12/28/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lbl: UILabel!
    var name: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(name)
        lbl.text = name
    }
}
