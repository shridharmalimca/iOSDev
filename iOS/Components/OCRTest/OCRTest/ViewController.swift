//
//  ViewController.swift
//  OCRTest
//
//  Created by Shridhar Mali on 9/7/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit
import TesseractOCR
class ViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var emirateIdLbl: UILabel!
    @IBOutlet weak var counterLbl: UILabel!
    @IBOutlet weak var birthDateLbl: UILabel!
    @IBOutlet weak var expiryDateLbl: UILabel!
    
    var activityIndicator:UIActivityIndicatorView!
    var timer : Timer!
    var counter: Int = 0
    var startDate = Date()
    var endDate = Date()
    var isBackScan: Bool = false
    
    var dateOfBirth: Date?
    var expirationDate: Date?
    var isValid: Float = 0
    let cameraOverlayLayer = CAShapeLayer()
    var croppedImage = UIImage()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Detail", style: .plain, target: self, action: #selector(detailClicked))
    }
    
    func showActionSheet() {
        let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Photo",
                                                       message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(title: "Take Photo",
                                             style: .default) { (alert) -> Void in
                                                let imagePicker = UIImagePickerController()
                                                imagePicker.delegate = self
                                                imagePicker.sourceType = .camera
                                                imagePicker.allowsEditing = false
                                                imagePicker.isNavigationBarHidden = true
                                                imagePicker.cameraOverlayView = self.addOverlayViewOnCamera(pickerFrame: imagePicker.view.frame)
                                                // imagePicker.view.layer.addSublayer(self.addOverlayViewOnCamera())
                                                self.present(imagePicker,
                                                             animated: true,
                                                             completion: nil)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        let libraryButton = UIAlertAction(title: "Choose Existing",
                                          style: .default) { (alert) -> Void in
                                            let imagePicker = UIImagePickerController()
                                            imagePicker.delegate = self
                                            imagePicker.sourceType = .photoLibrary
                                            self.present(imagePicker,
                                                         animated: true,
                                                         completion: nil)
        }
        // imagePickerActionSheet.addAction(libraryButton)
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel) { (alert) -> Void in
        }
        imagePickerActionSheet.addAction(cancelButton)
        present(imagePickerActionSheet, animated: true,
                completion: nil)
    }
    
   /* func addOverlayViewOnCamera() -> CALayer {
     
        let x: Double = 10.0
        let y: Double = Double(self.view.bounds.size.height / 2 - 130)
        let width: Double = Double(self.view.bounds.size.width - 20) // TODO: - (x*2)
        let height: Double = Double(200)
        cameraOverlayLayer.path = UIBezierPath(roundedRect: CGRect(x: x, y: y, width: width, height: height), cornerRadius: 20).cgPath
        cameraOverlayLayer.strokeColor = UIColor.white.cgColor
        cameraOverlayLayer.fillColor = UIColor.clear.cgColor
        cameraOverlayLayer.backgroundColor = UIColor.clear.cgColor
        appDelegate.cameraViewPortFrame = CGRect(x: x, y: y, width: width, height: height)
        print("Overlay view frame \(appDelegate.cameraViewPortFrame)")
        return cameraOverlayLayer
    }
 
    */
    
    func addOverlayViewOnCamera(pickerFrame: CGRect) -> UIView {
        let x: Double = 10.0
        let y: Double = Double(self.view.bounds.size.height / 2 - 130)
        let width: Double = Double(self.view.bounds.size.width - 20) // TODO: - (x*2)
        let height: Double = Double(200)
        // let overlay = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        let overlay = UIView(frame: CGRect(x: pickerFrame.origin.x + 10, y: pickerFrame.size.height / 2 - 130 , width: pickerFrame.size.width - 20, height: CGFloat(height)))
        overlay.layer.borderColor = UIColor.white.cgColor
        overlay.layer.borderWidth = 3
        overlay.layer.cornerRadius = 20
        overlay.backgroundColor = UIColor.clear
        appDelegate.cameraViewPortFrame = CGRect(x: x, y: y, width: width, height: height)
        print("Overlay view frame \(appDelegate.cameraViewPortFrame)")
        return overlay
    }
    
    @IBAction func takePhoto(_ sender: AnyObject) {
        isBackScan = false
        textView.text = ""
        self.emirateIdLbl.text = ""
        self.counterLbl.text = "0"
        
        view.endEditing(true)
        showActionSheet()
    }
    
    @IBAction func backScan(_ sender: Any) {
        isBackScan = true
        textView.text = ""
        self.emirateIdLbl.text = ""
        self.counterLbl.text = "0"
        
        view.endEditing(true)
        showActionSheet()
    }
    func calculatePerformance() {
        print(startDate)
        print(endDate)
        let calendar = Calendar.current
        let differenceInSeconds = calendar.dateComponents([.hour,.second], from: startDate, to: endDate)
        let seconds = differenceInSeconds.second
        guard let sec = seconds else {
            return
        }
        print(sec)
        counterLbl.text = String(describing: sec)
    }
    
    @IBAction func swapText(_ sender: AnyObject) {
    }
    
    @IBAction func sharePoem(_ sender: AnyObject) {
        if textView.text.isEmpty {
            return
        }
        let activityViewController = UIActivityViewController(activityItems:
            [textView.text], applicationActivities: nil)
        let excludeActivities = [
            UIActivityType.assignToContact,
            UIActivityType.saveToCameraRoll,
            UIActivityType.addToReadingList,
            UIActivityType.postToFlickr,
            UIActivityType.postToVimeo]
        activityViewController.excludedActivityTypes = excludeActivities
        present(activityViewController, animated: true,
                completion: nil)
    }
    
   /* func scaleImage(_ image: UIImage, maxDimension: CGFloat) -> UIImage {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        var scaleFactor:CGFloat
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = image.size.width / image.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        image.draw(in: CGRect(x: 0, y: 0, width: scaledSize.width, height: scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
 */
    
    // Activity Indicator methods
    
    func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
        activityIndicator = nil
    }
    
    @IBAction func backgroundTapped(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    func performImageRecognition(_ image: UIImage) {
        startDate =  Date(timeIntervalSinceNow: 0)
        let tesseract = G8Tesseract(language: "eng")
        tesseract?.engineMode = .tesseractOnly //.tesseractCubeCombined
        tesseract?.pageSegmentationMode = .auto
        tesseract?.maximumRecognitionTime = 60.0
        tesseract?.image = image.g8_blackAndWhite()
        tesseract?.recognize()
        textView.text = tesseract?.recognizedText
        textView.isEditable = false
        removeActivityIndicator()
        
        if let ocrtext = tesseract?.recognizedText {
            print("OCR Returned text \(ocrtext)")
            if isBackScan {
                backScanningImageProcessing(text: ocrtext)
            } else {
                frontScanningImageProcessing(text: ocrtext)
            }
        } else {
            
        }
        endDate =  Date(timeIntervalSinceNow: 0)
        calculatePerformance()
    }
    
    func frontScanningImageProcessing(text: String) {
        //784-[0-9]{4}-[0-9]{7}-[0-9]{1}
        // [0-9]
        self.birthDateLbl.text = "0"
        self.expiryDateLbl.text = "0"
        self.emirateIdLbl.text = ""
        let matched = matches(for: "[0-9]", in: text)
        print(matched)
        var id = String()
        for ch in matched.enumerated() {
            id = id+ch.element
            print(ch)
        }
        
        let sIndex = id.range(of: "784")?.lowerBound
        if let startIndex = sIndex {
            let startString = id.substring(from: startIndex)
            print(startString)
            if startString.characters.count > 0 {
                if startString.characters.count < 15 {
                    self.emirateIdLbl.text = "Invalid emirate id found"
                    self.emirateIdLbl.textColor = UIColor.red
                } else {
                    let emiratesId = startString.substring(to:startString.index(startString.startIndex, offsetBy: 15))
                    print(emiratesId)
                    self.emirateIdLbl.text = emiratesId
                    self.emirateIdLbl.textColor = UIColor.blue
                }
            } else {
                self.emirateIdLbl.text = "Please try again"
                self.emirateIdLbl.textColor = UIColor.red
            }
        } else {
            self.emirateIdLbl.text = "Invalid emirate id found"
            self.emirateIdLbl.textColor = UIColor.red
        }
    }
    
    func backScanningImageProcessing(text: String) {
        print("Scanned String : \(text)")
        //self.birthDateLbl.text = "0"
        //self.expiryDateLbl.text = "0"
        self.emirateIdLbl.text = ""
        
        // getNameFromOCRText(text: text)
        
        
        let matched = matches(for: "[0-9]", in: text)
        print(matched)
        var id = String()
        for ch in matched.enumerated() {
            id = id+ch.element
            print(ch)
        }
        
        let sIndex = id.range(of: "784")?.lowerBound
        if let startIndex = sIndex {
            let startString = id.substring(from: startIndex)
            print(startString)
            if startString.characters.count > 0 {
                if startString.characters.count < 15 {
                    self.emirateIdLbl.text = "Invalid emirate id"
                    self.emirateIdLbl.textColor = UIColor.red
                } else {
                    let emiratesId = startString.substring(to:startString.index(startString.startIndex, offsetBy: 15))
                    print("Emirates id \(emiratesId)")
                    print("Emirates id in number \(emiratesId.toNumber())")
                    
                    let replaceEmirateId = startString.replacingOccurrences(of: emiratesId, with: "")
                    let emiratesIdCheckDigit = emiratesId.substring(from:emiratesId.index(emiratesId.endIndex, offsetBy: -1))
                    print("Check digit of EmiratesID \(emiratesIdCheckDigit)")
                    
                    // Validation
                    isValid = 1
                    // let emiratesIdIsValid = self.validate(emiratesId.toNumber(), check: emiratesIdCheckDigit.toNumber())
                    // print(emiratesIdIsValid == true ? "True" : "False")
                    // let newEmiratesId = String(emiratesId.characters.dropLast())
                    let emiratesIdIsValid = self.validateEmiratesIdWithLuhnCheck(emiratesId: emiratesId)
                    print(emiratesIdIsValid == true ? "True" : "False")
                    
                    if emiratesIdIsValid {
                        self.emirateIdLbl.text = emiratesId
                        self.emirateIdLbl.textColor = UIColor.blue
                    } else {
                        self.emirateIdLbl.text = emiratesId
                        self.emirateIdLbl.textColor = UIColor.red
                    }
                   /* var birthDate = replaceEmirateId.substring(to:replaceEmirateId.index(replaceEmirateId.startIndex, offsetBy: 7))
                    let birthDateCheckDigit = birthDate.substring(from:birthDate.index(birthDate.endIndex, offsetBy: -1)).toNumber()
                    print("BirthDate check digit \(birthDateCheckDigit)")
                    let newBirthdate = String(birthDate.characters.dropLast())
                    print(newBirthdate.toNumber())
                    
                    let dateOfBirthIsValid = self.validate(newBirthdate.toNumber(), check: birthDateCheckDigit)
                    if !dateOfBirthIsValid {
                        print("--> DateOfBirth is invalid")
                        self.birthDateLbl.text = "Invalid Birth Date"
                    } else {
                        dateOfBirth = self.dateFromString(newBirthdate.toNumber())
                        // print("birth Date :== \(dateOfBirth)")
                        if let bDate = dateOfBirth {
                            self.birthDateLbl.text = self.convertUTCDateToDeviceStringDate(fromUTCDate: bDate)
                        } else {
                            self.birthDateLbl.text = ""
                        }
                    }
                    isValid = isValid * (dateOfBirthIsValid ? 1 : 0.9)
                    
                    let replacedBirthDate = replaceEmirateId.replacingOccurrences(of: birthDate, with: "")
                    
                    */
                    
                   /* let expiryDate = replacedBirthDate.substring(to:replacedBirthDate.index(replacedBirthDate.startIndex, offsetBy: 7))
                    print(expiryDate)
                    
                    let expirationDateCheckDigit = expiryDate.substring(from:expiryDate.index(expiryDate.endIndex, offsetBy: -1)).toNumber()
                    print("expirationDateCheckDigit check digit \(expirationDateCheckDigit)")
                    
                    let newExpirationDate = String(expiryDate.characters.dropLast())
                    print(newExpirationDate.toNumber())
                    
                    let dateOfExpirationIsValid = self.validate(newBirthdate.toNumber(), check: birthDateCheckDigit)
                    if !dateOfExpirationIsValid {
                        print("--> Expiration date is invalid")
                        self.expiryDateLbl.text = "Invalid Expiration Date"
                    } else {
                        expirationDate = self.dateFromString(newExpirationDate.toNumber())
                        // print("expiration Date :== \(expirationDate)")
                        if let eDate = expirationDate {
                            self.expiryDateLbl.text = self.convertUTCDateToDeviceStringDate(fromUTCDate: eDate)
                        } else {
                            self.expiryDateLbl.text = ""
                        }
                    }
 
                    isValid = isValid * (dateOfExpirationIsValid ? 1 : 0.9)
                    */
                }
            } else {
                // Parse error
                self.emirateIdLbl.text = "Error while parsing"
                //self.birthDateLbl.text = "Error"
                //self.expiryDateLbl.text = "Error"
            }
        } else {
            // Parse error
            self.emirateIdLbl.text = "Error while parsing"
            //elf.birthDateLbl.text = "Error"
            //self.expiryDateLbl.text = "Error"
        }
    }
    
    func getNameFromOCRText(text: String) {
        let nameArray = text.components(separatedBy: "<<")
        print(nameArray)
    }
    
    func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func dateFromString(_ value: String) -> Date? {
        var date: Date?
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "YYMMdd"
        dateStringFormatter.locale = Locale(identifier: "en_US_POSIX")
        let d = dateStringFormatter.date(from: value)
        if d != nil {
            date = Date(timeInterval:0, since:d!)
        }
        return date
    }
    
    func stringFromDate(_ value: Date?) -> String {
        if value == nil {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "YYMMdd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: value!)
    }
    
    
    func validate(_ data: String, check: String) -> Bool {
        // The check digit calculation is as follows: each position is assigned a value; for the digits 0 to 9 this is the value of the digits, for the letters A to Z this is 10 to 35, for the filler < this is 0. The value of each position is then multiplied by its weight; the weight of the first position is 7, of the second it is 3, and of the third it is 1, and after that the weights repeat 7, 3, 1, etcetera. All values are added together and the remainder of the final value divided by 10 is the check digit.
        
        //debugLog("Check '\(data)' for check '\(check)'")
        var i: Int = 1
        var dc: Int = 0
        var w: [Int] = [7,3,1]
        let b0: UInt8 = "0".utf8.first!
        let b9: UInt8 = "9".utf8.first!
        let bA: UInt8 = "A".utf8.first!
        let bZ: UInt8 = "Z".utf8.first!
        let bK: UInt8 = "<".utf8.first!
        for c: UInt8 in Array(data.utf8) {
            var d: Int = 0
            if c >= b0 && c <= b9 {
                d = Int(c - b0)
            } else if c >= bA && c <= bZ {
                d = Int((10 + c) - bA)
            } else if c != bK {
                return false
            }
            dc = dc + d * w[(i-1)%3]
            //print("i = \(i)   c = \(c)   d = \(d)   w = \(w[(i-1)%3])   dc = \(dc)")
            i += 1
        }
        if dc%10 != Int(check) {
            return false
        }
        //NSLog("Item was valid")
        return true
    }
    
    func convertUTCDateToDeviceStringDate(fromUTCDate: Date) -> String {
        let newUTCDate = fromUTCDate.addingTimeInterval(0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.ReferenceType.system
        dateFormatter.dateFormat = "dd/MM/yyyy"//"MM/dd/yyyy"
        dateFormatter.locale = Locale(identifier:"en_US")
        let localTime = dateFormatter.string(from: newUTCDate)
        return localTime
    }
    
    func validateEmiratesIdWithLuhnCheck(emiratesId: String) -> Bool {
        //accept 15 digit of emirates id and take last digit as a check digit
        var digitSum = 0
        let originalCheckDigit = emiratesId.characters.last!
        let characters = emiratesId.characters.dropLast().reversed()
        for (idx, character) in characters.enumerated() {
            let value = Int(String(character)) ?? 0
            if idx % 2 == 0 {
                var product = value * 2
                if product > 9 {
                    product = product - 9
                }
                digitSum = digitSum + product
            }
            else {
                digitSum = digitSum + value
            }
        }
        
        digitSum = digitSum * 9
        let computedCheckDigit = digitSum % 10
        let originalCheckDigitInt = Int(String(originalCheckDigit))
        let valid = originalCheckDigitInt == computedCheckDigit
        
        return valid
    }
    
    func detailClicked() {
        self.performSegue(withIdentifier: "detailVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        detailVC.croppedImage = self.croppedImage
    }
    
}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        print("Width \(selectedPhoto.size.width)")
        print("Height \(selectedPhoto.size.height)")
        //selectedPhoto = selectedPhoto.toGrayScale()
        //selectedPhoto = selectedPhoto.binarise()
        //selectedPhoto = selectedPhoto.scaleImage()
        print("new Width \(selectedPhoto.size.width)")
        print("new Height \(selectedPhoto.size.height)")
        print("Overlay view frame for crop \(appDelegate.cameraViewPortFrame)")
        //let croppedCGImage = selectedPhoto.cgImage?.cropping(to: (picker.cameraOverlayView?.frame)!)
        
         //croppedImage = UIImage(cgImage: croppedCGImage!)//.scaleImage()
        
       // let customRect = CGRect(x: selectedPhoto.size.width / 5, y: selectedPhoto.size.height / 5, width: selectedPhoto.size.width / 2, height: selectedPhoto.size.height / 2)
        croppedImage = crop(image: selectedPhoto, cropRect: CGRect(x: 10, y: selectedPhoto.size.height / 2 - 700, width: selectedPhoto.size.width - 20, height: selectedPhoto.size.height / 2))!.binarise() //.toGrayScale()
        
        // print("picker coordinates \(picker.cameraOverlayView?.frame)")
       
       
       // let my300dpiImage = UIImage(cgImage: selectedPhoto.cgImage!, scale: 300.0 / 72.0, orientation: selectedPhoto.imageOrientation).scaleImage()
       //croppedImage = selectedPhoto
       // let userOriginal = info[UIImagePickerControllerEditedImage] as! UIImage

        addActivityIndicator()
        
        dismiss(animated: true, completion: {
            self.performImageRecognition(self.croppedImage)
        })
    }
    
    func cropImage(image: UIImage, cropRect: CGRect) -> UIImage{
        UIGraphicsBeginImageContext(CGSize(width: 640, height: 1136)) //CGSize(720, 960)
        image.draw(in: CGRect(x: 0, y: 0, width: 640, height: 1136))
        let smallImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         let imageRef = (smallImage?.cgImage)!.cropping(to: cropRect)

        return UIImage(cgImage: imageRef!, scale: 0, orientation: image.imageOrientation)
        
    }
    
    func crop(image:UIImage, cropRect:CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(cropRect.size, false, image.scale)
        let origin = CGPoint(x: cropRect.origin.x * CGFloat(-1), y: cropRect.origin.y * CGFloat(-1))
        image.draw(at: origin)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return result
    }
    
}

extension UIImage {
    
    func toGrayScale() -> UIImage {
        
        let greyImage = UIImageView()
        greyImage.image = self
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectNoir")
        currentFilter!.setValue(CIImage(image: greyImage.image!), forKey: kCIInputImageKey)
        let output = currentFilter!.outputImage
        let cgimg = context.createCGImage(output!,from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        greyImage.image = processedImage
        
        return greyImage.image!
    }
    
    func binarise() -> UIImage {
        
        let glContext = EAGLContext(api: .openGLES2)!
        let ciContext = CIContext(eaglContext: glContext, options: [kCIContextOutputColorSpace : NSNull()])
        let filter = CIFilter(name: "CIPhotoEffectMono")
        filter!.setValue(CIImage(image: self), forKey: "inputImage")
        let outputImage = filter!.outputImage
        let cgimg = ciContext.createCGImage(outputImage!, from: (outputImage?.extent)!)
        
        return UIImage(cgImage: cgimg!)
    }
    
    /*func scaleImage() -> UIImage {
        
        // let maxDimension: CGFloat = 640
        var scaledSize = CGSize(width: 640, height: 1136)
        var scaleFactor: CGFloat
        
        if self.size.width > self.size.height {
            scaleFactor = self.size.height / self.size.width
            scaledSize.width = 640
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = self.size.width / self.size.height
            scaledSize.height = 1136
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        self.draw(in: CGRect(x: 0, y: 0, width: scaledSize.width, height: scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }*/
    
    
    func scaleImage() -> UIImage {
        
        let maxDimension: CGFloat = 640
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        var scaleFactor: CGFloat
        
        if self.size.width > self.size.height {
            scaleFactor = self.size.height / self.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = self.size.width / self.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        self.draw(in: CGRect(x: 0, y: 0, width: scaledSize.width, height: scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    
    func orientate(img: UIImage) -> UIImage {
        
        if (img.imageOrientation == UIImageOrientation.up) {
            return img;
        }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        
        let normalizedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage
        
    }
    
}

extension String {
    /**
     Simple string extension for performing a replace
     
     :param: target     search this text
     :param: withString the text you want to replace it with
     
     :returns: the string with the replacements.
     */
    func replace(target: String, with: String) -> String {
        return self.replacingOccurrences(of: target, with: with, options: .literal, range: nil)
    }
    
    /**
     Clean up incorrect detected characters
     
     :returns: The cleaned up string
     */
    func toNumber() -> String {
        return self
            .replace(target: "O", with: "0")
            .replace(target: "Q", with: "0")
            .replace(target: "U", with: "0")
            .replace(target: "D", with: "0")
            .replace(target: "I", with: "1")
            .replace(target: "Z", with: "2")
    }
    
}

