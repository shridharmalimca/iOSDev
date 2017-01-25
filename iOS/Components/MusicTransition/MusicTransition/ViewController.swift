//
//  ViewController.swift
//  MusicTransition
//
//  Created by Shridhar Mali on 1/24/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit
import SRKUtility
class ViewController: UIViewController,UIGestureRecognizerDelegate {
   var miniPlayerView = UIView()
    var originalY: CGFloat = 0.0
    var originalH: CGFloat = 50.0
    var picImgView:UIImageView = UIImageView()
    var playButton = UIButton()
    var nextButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "first View"
        let audios: [String] = [
            "http://sadhguru.podomatic.com/enclosure/2010-10-25T02_27_35-07_00.mp3"
            ]
        CustomAudioManager.shared.audios = audios
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(forName: Notification.MyApp.miniPlayerStartNotification, object: nil, queue: OperationQueue.main) {
            pNotification in
            //play music and show mini player
            self.setMiniPlayerView()
        }
        
        NotificationCenter.default.addObserver(forName: Notification.MyApp.miniPlayerStopNotification, object: nil, queue: OperationQueue.main) {
            pNotification in
            self.miniPlayerView.removeFromSuperview()
            // Stop music and remove miniplayer view
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnClicked(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.MyApp.miniPlayerStartNotification, object: self)
    }
    
    func setMiniPlayerView() {
        let window = UIApplication.shared.keyWindow
        if (self.tabBarController?.tabBar.isHidden)! == false {
            print("Showed")
            // Change the miniplayer coordinate as per tabBarcontroller.tabBar
            originalY = self.view.frame.size.height - ((self.tabBarController?.tabBar.frame.size.height)! + 50)
            miniPlayerView.frame = CGRect(x: 0, y: originalY , width: self.view.frame.size.width, height: originalH)
            miniPlayerView.backgroundColor = UIColor.lightGray
            miniPlayerView.bringSubview(toFront: self.view)
            miniPlayerView.isUserInteractionEnabled = true
            
            picImgView.frame = CGRect(x: 10, y: 5, width: 40, height: 40)
            picImgView.image = UIImage(named: "unnamed")
            miniPlayerView.addSubview(picImgView)
            
            playButton = UIButton(type: UIButtonType.custom)
            playButton.frame = CGRect(x: miniPlayerView.frame.size.width / 2 + 50, y: miniPlayerView.frame.size.height / 2 - 20, width: 100, height: 40)
            playButton.setTitle("Play", for: .normal)
            playButton.addTarget(self, action: #selector(self.playSong), for: UIControlEvents.touchUpInside)
            miniPlayerView.addSubview(playButton)
            
            
            nextButton = UIButton(type: UIButtonType.custom)
            nextButton.frame = CGRect(x: miniPlayerView.frame.size.width / 2 + 150, y: miniPlayerView.frame.size.height / 2 - 20, width: 50, height: 40)
            nextButton.setTitle("Next", for: .normal)
            nextButton.addTarget(self, action: #selector(self.nextSong), for: UIControlEvents.touchUpInside)
            miniPlayerView.addSubview(nextButton)
            
            // Apply blur effect later
            /*
             let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
             let blurEffectView = UIVisualEffectView(effect: blurEffect)
             blurEffectView.frame = miniPlayerView.bounds
             blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
             miniPlayerView.addSubview(blurEffectView)
             */
            
            window?.addSubview(miniPlayerView)
        } else {
            print("Not Showed")
        }
        
        let upSwipeGuesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handlePan))
        upSwipeGuesture.direction = UISwipeGestureRecognizerDirection.up
        miniPlayerView.addGestureRecognizer(upSwipeGuesture)
        
        let downSwipeGuesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handlePan))
        downSwipeGuesture.direction = UISwipeGestureRecognizerDirection.down
        miniPlayerView.addGestureRecognizer(downSwipeGuesture)
        
    }
 
    func handlePan(gestureRecognizer: UISwipeGestureRecognizer) {
        switch gestureRecognizer.direction {
        case UISwipeGestureRecognizerDirection.left:
            print("left")
        case UISwipeGestureRecognizerDirection.right:
            print("right")
        case UISwipeGestureRecognizerDirection.up:
            print("Up")
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
                self.miniPlayerView.layer.cornerRadius = 10.0
                self.miniPlayerView.frame = CGRect(x: 0, y: 0 , width: self.view.frame.size.width, height: self.view.frame.size.height)
                self.picImgView.frame = CGRect(x: 50, y: self.view.frame.size.height / 2 - 200, width: self.view.frame.size.width - 100, height: 200)
                self.playButton.frame = CGRect(x: self.view.frame.size.width / 2 - 20, y: self.view.frame.size.height / 2 , width: 40, height: 40)
                self.nextButton.frame = CGRect(x: self.miniPlayerView.frame.size.width / 2 + 80, y: self.miniPlayerView.frame.size.height / 2, width: 40, height: 40)
            }, completion: { (Void) in
                 print("completion")
            })
        case UISwipeGestureRecognizerDirection.down:
            print("Down")
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
            self.miniPlayerView.layer.cornerRadius = 0.0
            self.miniPlayerView.frame = CGRect(x: 0, y: self.view.frame.size.height - ((self.tabBarController?.tabBar.frame.size.height)! + 50) , width: self.view.frame.size.width, height: self.originalH)
                self.picImgView.frame = CGRect(x: 10, y: 5, width: 40, height: 40)
                self.playButton.frame = CGRect(x: self.miniPlayerView.frame.size.width / 2 + 50, y: self.miniPlayerView.frame.size.height / 2 - 20, width: 100, height: 40)
                self.nextButton.frame = CGRect(x: self.miniPlayerView.frame.size.width / 2 + 150, y: self.miniPlayerView.frame.size.height / 2 - 20, width: 50, height: 40)
            }, completion: { (Void) in
                print("completion")
            })
        default:
            print("default")
        }
    }
    
    func playSong() {
        print("Play")
        CustomAudioManager.shared.actionPlayAudio(60, index: 0, handler: { (hasErrors: Bool) in
            if hasErrors == true {
                Utility.showErrorMessage(title: "Message", message: "Error playing audio.", viewController: self)
            }
        })
    }
    
    func nextSong() {
        CustomAudioManager.shared.actionNextAudio(60) { (hasErrors) in
            if hasErrors == true {
                Utility.showErrorMessage(title: "Message", message: "Error playing audio.", viewController: self)
            }
        }
    }
}

