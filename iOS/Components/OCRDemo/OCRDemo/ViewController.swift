//
//  ViewController.swift
//  OCRDemo
//
//  Created by Shridhar Mali on 7/24/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit
import TesseractOCR
class ViewController: UIViewController,G8TesseractDelegate {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        imgView.image = UIImage(named: "IMG.png") //(named: "PanCard.png")//
        scanCard()
    }
    
    
    func scanCard() {
        let tesseract = G8Tesseract(language: "eng+fra")// "eng+fra")
        tesseract?.engineMode = .tesseractCubeCombined
        tesseract?.pageSegmentationMode = .auto
        tesseract?.maximumRecognitionTime = 60.0
        tesseract?.image = UIImage(named: "IMG.png")?.g8_blackAndWhite()
        // tesseract?.image = image.g8_blackAndWhite()
        tesseract?.recognize()
        let recongnizedText = tesseract?.recognizedText
        if let rczTxt = recongnizedText {
            print("Text from the image \n \(rczTxt)")
            textView.text = rczTxt
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            // self.recoginzedText = rczTxt
        } else {
            // self.recoginzedText = ""
            print("problem while read")
            textView.text = "Problem while read..."
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func shouldCancelImageRecognitionForTesseract(tesseract: G8Tesseract!) -> Bool {
        return false; // return true if you need to interrupt tesseract before it finishes
    }
}

