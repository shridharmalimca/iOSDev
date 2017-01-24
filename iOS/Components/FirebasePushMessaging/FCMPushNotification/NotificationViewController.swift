//
//  NotificationViewController.swift
//  FCMPushNotification
//
//  Created by Shridhar Mali on 1/11/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    @IBOutlet weak var pathLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        print("notification.request.content.body")
        self.label?.text = "ISHAFOUNDATION"// notification.request.content.body
        let content = notification.request.content
        
        if let attachment = content.attachments.first {
            if attachment.url.startAccessingSecurityScopedResource() {
                let imageData = try? Data(contentsOf: attachment.url)
                let image = UIImage(data: imageData! as Data)
                imgView.image = image
                attachment.url.stopAccessingSecurityScopedResource()
            }
        }
        
    }
}
