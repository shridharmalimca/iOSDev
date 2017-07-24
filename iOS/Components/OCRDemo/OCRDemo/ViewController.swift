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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scanCard()
    }
    
    
    func scanCard() {
        /* var tesseract:G8Tesseract = G8Tesseract(language:"eng+ita");
         //tesseract.language = "eng+ita";
         tesseract.delegate = self;
         tesseract.charWhitelist = "01234567890";
         tesseract.image = UIImage(named: "image_sample.jpg");
         tesseract.recognize();*/
        
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
            // self.recoginzedText = rczTxt
        } else {
            // self.recoginzedText = ""
            print("problem while read")
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

