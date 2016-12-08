//
//  ViewController.swift
//  TextView
//
//  Created by Shridhar Mali on 12/8/16.
//  Copyright © 2016 TIS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addToolBarOnTextView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func addToolBarOnTextView() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        toolBar.backgroundColor = UIColor.blue
        let leftButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClicked))
        let flexibleBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let rightButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClicked))
        let buttons = [leftButton,flexibleBarButton, rightButton]
        toolBar.items = buttons
        self.txtView.inputAccessoryView = toolBar
    }
    func cancelClicked() {
        print("Cancel Clicked")
        txtView.resignFirstResponder()
    }
    func doneClicked() {
        print("Done Clikded")
        guard txtView.text.characters.count > 0 else {
            print("Please enter valid input")
            return
        }
        txtView.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func firstClicked(_ sender: Any) {
        print("First Clicked")
    }
    
    @IBAction func secondClicked(_ sender: Any) {
        print("Second Clicked")
    }
}

extension ViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        print("textViewShouldBeginEditing")
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        print("textViewShouldEndEditing")
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("textViewDidBeginEditing")
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print("textViewDidEndEditing")
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("shouldChangeTextIn")
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        print("textViewDidChange")
    }
    func textViewDidChangeSelection(_ textView: UITextView) {
        print("textViewDidChangeSelection")
    }
}

