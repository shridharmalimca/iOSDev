//
//  ViewController.swift
//  FileHandling
//
//  Created by Shridhar Mali on 6/1/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let fileManager = FileManager.default
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask , true)
    var docDir = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        docDir = path[0]
        print("Document Dir Path: \(docDir)")
        createFile()
    }
    
    func createFile() {
        let sampleFile = docDir.appendingFormat("/Sample.txt")
        let contentToWrite = "This is sample content"
        writeContentIntoFile(file: sampleFile, content: contentToWrite)
    }
    
    func writeContentIntoFile(file: String, content: String) {
        do {
            try content.write(toFile: file, atomically: true, encoding: .utf8)
        } catch {
            print("Error while write content in file")
        }
    }
    
    func readFile() {
        
    }
    
    func deleteFile() {
        
    }
    
    func createDirectory() {
        
    }
    
    func readDirectoryContent() {
        
    }
    
    func deleteDirectoryContent() {
        
    }
    
    func getFileAttributes() {
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

