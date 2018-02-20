//
//  ViewController.swift
//  CustomControls
//
//  Created by Shridhar Mali on 2/20/18.
//  Copyright © 2018 Shridhar Mali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

@IBDesignable
class DesignableButton: UIButton {
    @IBInspectable
    public var cornerRedius: CGFloat = 2.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRedius
        }
    }
    
    @IBInspectable
    public var color: UIColor = UIColor.lightGray {
        didSet {
            self.backgroundColor = self.color
        }
    }
    
    @IBInspectable
    public var width: CGFloat = 200 {
        didSet {
            self.frame.size.width = self.width
        }
    }
    
    @IBInspectable
    public var height: CGFloat = 40 {
        didSet {
            self.frame.size.height = self.height
        }
    }
    
}

