//
//  NotificationService.swift
//  FCMNotificationService
//
//  Created by Shridhar Mali on 1/12/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        print("UserInfo \(request.content.userInfo)")
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
            print("bestAttemptContent")
            contentHandler(bestAttemptContent)
        }
        
        /*
 
         let fileURL = URL(string: imageUrl)!
         print(fileURL)
         
         let session = URLSession.shared
         let task = session.dataTask(with: fileURL) { (data: Data?, response: URLResponse?, error: Error?) in
         let fileManager = FileManager.default
         let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
         let documentPath = path.first
         let filePath = documentPath?.appending("/image.png")
         let baseURL = URL(fileURLWithPath: filePath!)
         if let imageData = data {
         // let image = UIImage(data: imageData)
         fileManager.createFile(atPath: filePath!, contents: imageData, attributes: nil)
         }
         // let url = URL(string: baseURL)
         print(baseURL)
         if let attachement = try? UNNotificationAttachment(identifier: "image", url: baseURL, options:nil) {
         content.attachments = [attachement]
         let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
         
         let requestIdentifier = "myNotificationCategory"
         let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
         UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
         // handle error
         })
         
         } else {
         print("Attchement found nil")
         }
         }
         task.resume()
        */
        
        // Get the custom data from the notification payload
        //if let notificationData = request.content.userInfo["data"] as? [String: String] {
            // Grab the attachment
            if let fileUrl = URL(string: request.content.userInfo["image"] as! String) {
                // Download the attachment
                URLSession.shared.downloadTask(with: fileUrl) { (location, response, error) in
                    if let location = location {
                        // Move temporary file to remove .tmp extension
                        let tmpDirectory = NSTemporaryDirectory()
                        let tmpFile = "file://".appending(tmpDirectory).appending(fileUrl.lastPathComponent)
                        let tmpUrl = URL(string: tmpFile)!
                        try! FileManager.default.moveItem(at: location, to: tmpUrl)
                        
                        // Add the attachment to the notification content
                        if let attachment = try? UNNotificationAttachment(identifier: "", url: tmpUrl) {
                            self.bestAttemptContent?.attachments = [attachment]
                        }
                    }
                    // Serve the notification content
                    self.contentHandler!(self.bestAttemptContent!)
                    }.resume()
            }
        //}
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
