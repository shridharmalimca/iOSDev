//
//  FileDownloadInfo.swift
//  BackgroundTask
//
//  Created by Shridhar Mali on 3/10/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class FileDownloadInfo: NSObject {
    var fileTitle = String()
    var downloadSource = String()
    var downloadTask = URLSessionDownloadTask()
    var taskResumeData = Data()
    var downloadProgress = Double()
    var isDownloading = Bool()
    var downloadComplete = Bool()
    var taskIdentifier = Double()
    
    func initWithFileTitle(title: String, downloadSource source: String) {
        self.fileTitle = title
        self.downloadSource = source
        self.downloadProgress = 0.0
        self.isDownloading = false
        self.downloadComplete = false
        self.taskIdentifier = -1
    }
    
}
