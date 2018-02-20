//
//  ViewController.swift
//  ViewWithShadow
//
//  Created by Shridhar Mali on 2/20/18.
//  Copyright © 2018 Shridhar Mali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var shadowView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     shadowView.dropShadow()
    }


}

extension UIView {
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1.0 //0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 10 // 1 // change redius as per requirement
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
