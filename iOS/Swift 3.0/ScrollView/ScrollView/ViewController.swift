//
//  ViewController.swift
//  ScrollView
//
//  Created by Shridhar Mali on 12/27/16.
//  Copyright © 2016 TIS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // scrollView.contentSize = CGSize(width: 400, height: 650)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        scrollView.contentSize = CGSize(width: self.view.bounds.size.width, height: 1000)
        var rc = self.usernameTxt.bounds
        rc = textField.convert(rc, to: scrollView)
        rc.origin.x = 0
        rc.origin.y -= 40
        rc.size.height = 400
        scrollView.scrollRectToVisible(rc, animated: true)
        
        
        /*CGRect rc = [self.passwordTextField bounds];
        rc = [self.passwordTextField convertRect:rc toView:scrollView];
        rc.origin.x = 0 ;
        rc.origin.y -= 40 ;
        rc.size.height = 400;
        [scrollView scrollRectToVisible:rc animated:YES]; */
        return true
    }
    
}
