//
//  ViewController.swift
//  BackgroundTask
//
//  Created by Shridhar Mali on 3/9/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var session = URLSession()
    var arrDownloadData = Array<Any>()
    // var docDirectoryUrl: URL = URL(string: "")!
    let objFileDownloadInfo = FileDownloadInfo()
    
    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // self.docDirectoryUrl = urls[0]
        getDataFromServer()
    }
    
    func getDataFromServer() {
        arrDownloadData.append("https://www.w3schools.com/images/w3schools_green.jpg")
        arrDownloadData.append("")
        arrDownloadData.append("")
        arrDownloadData.append("")
        
        let sessionConfiguration = URLSessionConfiguration.background(withIdentifier: "com.downloadFiles")
        sessionConfiguration.httpMaximumConnectionsPerHost = 5;
        
        self.session = URLSession.init(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
        
        if !objFileDownloadInfo.isDownloading {
            objFileDownloadInfo.downloadTask = self.session.downloadTask(with: URL(string: arrDownloadData[0] as! String)!)
            objFileDownloadInfo.downloadTask.resume()
        } else {
            print("File downloading in progress")
        }
        
    }
    
    func getDocumentDirPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getImage(){
        let fileManager = FileManager.default
        let imagePAth = (self.getDocumentDirPath() as NSString).appendingPathComponent("apple.png")
        if fileManager.fileExists(atPath: imagePAth){
            self.imgView.image = UIImage(contentsOfFile: imagePAth)
        }else{
            print("No Image")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("didFinishDownloadingTo")
        
        let fileManager = FileManager.default
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("apple.png")
        do {
            try FileManager.default.copyItem(at: location, to: url[0])
        } catch let error {
        print("Error while save image \(error)")
        }
        let image = UIImage(named: "apple.png")
        print(paths)
        if let image = image {
            let imageData = UIImageJPEGRepresentation(image, 0.5)
            fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
        }
        getImage()
        
        /*let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        print("Document dir \(dir)")
        let path = dir?.appendingPathComponent("image.png")
        let pathString = path?.absoluteString
        print("path dir \(path)")
        // Save file at location
        do {
            print("saved")
            let isFileFound = FileManager.default.fileExists(atPath: pathString!)
            if isFileFound {
                try FileManager.default.removeItem(atPath: pathString!)
            } else {
                try FileManager.default.copyItem(at: location, to: path!)
            }
            print("Path is:\(dir?.absoluteString)")
        } catch let error {
            print("Error while save image \(error)")
        }*/
        
        
    }
}

