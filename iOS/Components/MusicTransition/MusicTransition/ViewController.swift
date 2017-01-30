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
    var miniPlayerViewInitialWidth: CGFloat = 0.0
    var miniPlayerViewInitialHeight: CGFloat = 0.0
    var miniPlayerViewAfterUpSwipedUpWidth: CGFloat = 0.0
    var miniPlayerViewAfterUpSwipedHeight: CGFloat = 0.0
    var mainViewCenterByWidth:CGFloat = 0.0
    var mainViewCenterByHeight:CGFloat = 0.0
    var miniPlayerViewCenterByWidth:CGFloat = 0.0
    var miniPlayerViewCenterByHeight:CGFloat = 0.0
    
    
    var originalY: CGFloat = 0.0
    var originalH: CGFloat = 70.0
    var songPicImgView:UIImageView = UIImageView()
    var songPicImgViewXFactorUpSwipedAnimation:CGFloat = 0.0
    var songPicImgViewYFactorUpSwipedAnimation:CGFloat = 0.0
    var songPicImgViewWidthFactorUpSwipedAnimation:CGFloat = 0.0
    var songPicImgViewHeightFactorUpSwipedAnimation:CGFloat = 0.0
    
    var songSlider = UISlider()
    var songLabel: UILabel = UILabel()
    var playButton = UIButton()
    var previousButton = UIButton()
    var nextButton = UIButton()
    var cancelMiniPlayerButton = UIButton()
    
    var miniplayerButtonsInitialWidthAndHeight: CGFloat = 40
    var miniplayerButtonsUpSwipedWidthAndHeight: CGFloat = 70
    var playPauseButtonInitialX: CGFloat = 0.0
    var previousButtonInitialY: CGFloat = 0.0
    var previousButtonInitialX: CGFloat = 0.0
    var playPauseButtonInitialY: CGFloat = 0.0
    var nextButtonInitialX: CGFloat = 0.0
    var nextButtonInitialY: CGFloat = 0.0
    
    var isSlideUpMiniPlayer:Bool = false
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
            // self.miniPlayerView.removeFromSuperview()
            // Change the miniplayer coordinate as per tabBarcontroller.tabBar
            self.miniPlayerViewInitialWidth = self.view.frame.size.width
            self.miniPlayerViewAfterUpSwipedUpWidth = self.view.frame.size.width
            self.miniPlayerViewAfterUpSwipedHeight = self.view.frame.size.height
            self.mainViewCenterByWidth = self.view.frame.size.width / 2
            self.mainViewCenterByHeight = self.view.frame.size.height / 2
            
            self.miniPlayerView.backgroundColor = UIColor.lightGray
            self.miniPlayerView.alpha = 1.0 // 0.5
            self.miniPlayerView.bringSubview(toFront: self.view)
            self.miniPlayerView.isUserInteractionEnabled = true
            
            
            // Song Thumnail Image
            songPicImgView.image = UIImage(named: "unnamed")
            self.miniPlayerView.addSubview(songPicImgView)
            
            //Song slider
            self.songSlider.isHidden = true
            self.songSlider.thumbTintColor = UIColor.brown
            self.songSlider.minimumTrackTintColor = UIColor.brown
            self.songSlider.maximumTrackTintColor = UIColor.gray
            self.songSlider.minimumValue = 0
            self.songSlider.maximumValue = 100
            self.songSlider.isUserInteractionEnabled = false
            self.songSlider.addTarget(self, action: #selector(self.slideSong), for: .valueChanged)
            self.miniPlayerView.addSubview(songSlider)
            
            // Song Label
            songLabel.text = "Sadhguru gone viral"
            songLabel.font = UIFont.systemFont(ofSize: 20)
            // songLabel.backgroundColor = UIColor.red
            songLabel.textAlignment = .center
            self.miniPlayerView.addSubview(songLabel)
            
            // Previous Button
            previousButton = UIButton(type: UIButtonType.custom)
            let previous = UIImage(named: "skip_to_start")
            previousButton.setBackgroundImage(previous, for: UIControlState.normal)
            previousButton.addTarget(self, action: #selector(self.previousSong), for: UIControlEvents.touchUpInside)
            self.miniPlayerView.addSubview(previousButton)
            
            
            // Play Button
            playButton = UIButton(type: UIButtonType.custom)
            let play = UIImage(named: "circled_play")
            playButton.setBackgroundImage(play, for: UIControlState.normal)
            playButton.addTarget(self, action: #selector(self.playSong), for: UIControlEvents.touchUpInside)
            self.miniPlayerView.addSubview(playButton)
            
            // Next Button
            nextButton = UIButton(type: UIButtonType.custom)
            let next = UIImage(named: "end")
            nextButton.setBackgroundImage(next, for: UIControlState.normal)
            nextButton.addTarget(self, action: #selector(self.nextSong), for: UIControlEvents.touchUpInside)
            self.miniPlayerView.addSubview(nextButton)
            
            
            // Cancel Button
            cancelMiniPlayerButton = UIButton(type: .custom)
            let cancel = UIImage(named: "popup_close_icon")
            cancelMiniPlayerButton.setBackgroundImage(cancel, for: UIControlState.normal)
            cancelMiniPlayerButton.addTarget(self, action: #selector(self.cancelMiniplayer), for: UIControlEvents.touchUpInside)
            self.miniPlayerView.addSubview(cancelMiniPlayerButton)
            
            // Apply blur effect later
            /*
             let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
             let blurEffectView = UIVisualEffectView(effect: blurEffect)
             blurEffectView.frame = miniPlayerView.bounds
             blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
             miniPlayerView.addSubview(blurEffectView)
             */
            
            window?.addSubview(self.miniPlayerView)
            updateFramesOfControlsOnInitialAndSwipeDownAnimation()
        } else {
            print("Not Showed")
        }
        
        let tapGeusture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        miniPlayerView.addGestureRecognizer(tapGeusture)
        
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
            UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseIn, animations: {
                self.updateFramesOfControlsOnSwipeUpAnimation()
            }, completion: { (Void) in
                print("completion")
            })
        case UISwipeGestureRecognizerDirection.down:
            print("Down")
            UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: {
                self.updateFramesOfControlsOnInitialAndSwipeDownAnimation()
            }, completion: { (Void) in
                print("completion")
            })
        default:
            print("default")
        }
    }
    
    func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        print("tapped on miniplayer")
        if isSlideUpMiniPlayer {
            // Minimize
        } else {
            // Maximize
            UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseIn, animations: {
                self.updateFramesOfControlsOnSwipeUpAnimation()
            }, completion: { (Void) in
                print("completion")
            })
        }
        
    }
    func updateFramesOfControlsOnSwipeUpAnimation() {
        self.isSlideUpMiniPlayer = true
        self.miniPlayerView.frame = CGRect(x: 0, y: 0 , width: self.miniPlayerViewAfterUpSwipedUpWidth, height: self.miniPlayerViewAfterUpSwipedHeight)
        let distanceBtnPlayerButtons:CGFloat = 100
        var widthOfCancelButton: CGFloat = 30
        var heightOfCancelButton: CGFloat = 30
        songPicImgViewXFactorUpSwipedAnimation = 50
        songPicImgViewYFactorUpSwipedAnimation = miniPlayerViewCenterByWidth + 70
        songPicImgViewWidthFactorUpSwipedAnimation = 100
        songPicImgViewHeightFactorUpSwipedAnimation = 200
        
        if UIScreen.main.bounds.height == 480 {
            widthOfCancelButton = 30
            heightOfCancelButton = 30
        } else if UIScreen.main.bounds.height == 568 {
            // 5s
            widthOfCancelButton = 30
            heightOfCancelButton = 30
        } else if UIScreen.main.bounds.height == 667 {
            // 7
            widthOfCancelButton = 40
            heightOfCancelButton = 40
        } else if  UIScreen.main.bounds.height == 736 {
            // 7 plus
            widthOfCancelButton = 40
            heightOfCancelButton = 40
        }
        
        self.songPicImgView.frame = CGRect(x: self.miniPlayerView.frame.origin.x + songPicImgViewXFactorUpSwipedAnimation, y: self.mainViewCenterByHeight - songPicImgViewYFactorUpSwipedAnimation, width: self.view.frame.size.width - self.songPicImgViewWidthFactorUpSwipedAnimation, height: songPicImgViewHeightFactorUpSwipedAnimation)
        
        self.songSlider.isHidden = false
        self.songSlider.frame = CGRect(x: self.songPicImgView.frame.origin.x - 20, y: self.songPicImgView.frame.origin.y + (self.songPicImgView.frame.size.height + 20), width: self.songPicImgView.frame.size.width + 40, height: 20)
        
        self.playButton.frame = CGRect(x: self.miniPlayerViewCenterByWidth - (miniplayerButtonsUpSwipedWidthAndHeight / 2) , y: self.songPicImgView.frame.origin.y + self.songPicImgView.frame.size.height + 50  , width: miniplayerButtonsUpSwipedWidthAndHeight, height: miniplayerButtonsUpSwipedWidthAndHeight)
        
        self.previousButton.frame = CGRect(x: self.playButton.frame.origin.x - distanceBtnPlayerButtons, y:self.playButton.frame.origin.y, width: miniplayerButtonsUpSwipedWidthAndHeight, height: miniplayerButtonsUpSwipedWidthAndHeight)
        
        self.nextButton.frame = CGRect(x: self.playButton.frame.origin.x + distanceBtnPlayerButtons, y:self.playButton.frame.origin.y, width: miniplayerButtonsUpSwipedWidthAndHeight, height: miniplayerButtonsUpSwipedWidthAndHeight)
        
        self.songLabel.frame = CGRect(x: self.songPicImgView.frame.origin.x, y: self.playButton.frame.origin.y + 100, width: self.miniPlayerView.frame.size.width - (self.songPicImgView.frame.origin.x * 2) , height: 30)
        
        cancelMiniPlayerButton.frame = CGRect(x: self.miniPlayerView.frame.size.width / 2 - (40 / 2)  , y: 20 , width: widthOfCancelButton, height: heightOfCancelButton)
        let dismissChevron = UIImage(named: "DismissChevron")
        cancelMiniPlayerButton.setBackgroundImage(dismissChevron, for: .normal)
    }
    
    func updateFramesOfControlsOnInitialAndSwipeDownAnimation() {
        self.isSlideUpMiniPlayer = false
        originalY = self.view.bounds.size.height - ((self.tabBarController?.tabBar.frame.size.height)! + self.originalH)
        self.miniPlayerView.frame = CGRect(x: 0, y: self.originalY , width: self.miniPlayerViewInitialWidth, height: self.originalH)
        
        self.miniPlayerViewCenterByWidth = self.miniPlayerView.frame.size.width / 2
        self.miniPlayerViewCenterByHeight = self.miniPlayerView.frame.size.height / 2
        var distanceBtnPlayerButtons:CGFloat = 40
        var widthOfCancelButton: CGFloat = 30
        var heightOfCancelButton: CGFloat = 30
        print("Screen size is: \(UIScreen.main.bounds.height)")
        
        if UIScreen.main.bounds.height == 480 {
            // 4
            widthOfCancelButton = 30
            heightOfCancelButton = 30
            distanceBtnPlayerButtons = 40
        } else if UIScreen.main.bounds.height == 568 {
            // 5,5s, iPhone SE
            widthOfCancelButton = 30
            heightOfCancelButton = 30
            distanceBtnPlayerButtons = 40
        } else if UIScreen.main.bounds.height == 667 {
            // 6, 6s & 7
            widthOfCancelButton = 40
            heightOfCancelButton = 40
            distanceBtnPlayerButtons = 60
        } else if  UIScreen.main.bounds.height == 736 {
            // 6 & 7 plus
            widthOfCancelButton = 40
            heightOfCancelButton = 40
            distanceBtnPlayerButtons = 60
        }
        
        
        self.songPicImgView.frame = CGRect(x: self.miniPlayerView.frame.origin.x + 10, y: miniPlayerViewCenterByHeight - 30, width: 60, height: 60)
        self.songSlider.isHidden = true
        self.songLabel.frame = CGRect(x: songPicImgView.frame.origin.x + (songPicImgView.frame.size.width + 10)  , y: self.miniPlayerViewCenterByHeight + 5, width:self.miniPlayerView.frame.size.width - ((self.miniPlayerView.frame.origin.x * 2) + (songPicImgView.frame.size.width + 30)) , height: 30)
        
        print("Miniplayer width \(self.miniPlayerView.frame.size.width)")
        print("song pic width \(songPicImgView.frame.size.width)")
        print("song pic x \(songPicImgView.frame.origin.x)")
        
        playPauseButtonInitialX = self.miniPlayerViewCenterByWidth - (miniplayerButtonsInitialWidthAndHeight / 2)
        playPauseButtonInitialY = 3
        playButton.frame = CGRect(x: playPauseButtonInitialX , y: playPauseButtonInitialY, width: miniplayerButtonsInitialWidthAndHeight, height: miniplayerButtonsInitialWidthAndHeight)
        
        previousButtonInitialX = playPauseButtonInitialX - (miniplayerButtonsInitialWidthAndHeight + distanceBtnPlayerButtons)
        previousButtonInitialY = playPauseButtonInitialY
        previousButton.frame = CGRect(x: previousButtonInitialX , y: previousButtonInitialY, width: miniplayerButtonsInitialWidthAndHeight, height: miniplayerButtonsInitialWidthAndHeight)
        
        nextButtonInitialX = playPauseButtonInitialX + (playButton.frame.size.width + distanceBtnPlayerButtons)
        nextButtonInitialY = playPauseButtonInitialY
        nextButton.frame = CGRect(x: nextButtonInitialX  , y: nextButtonInitialY , width: miniplayerButtonsInitialWidthAndHeight, height: miniplayerButtonsInitialWidthAndHeight)
        
        cancelMiniPlayerButton.frame = CGRect(x: self.miniPlayerView.frame.size.width - (widthOfCancelButton + 5)  , y: nextButtonInitialY , width: widthOfCancelButton, height: heightOfCancelButton)
        let cancel = UIImage(named: "popup_close_icon")
        cancelMiniPlayerButton.setBackgroundImage(cancel, for: UIControlState.normal)
        
    }
    
    func playSong() {
        print("Play")
        let play = UIImage(named: "circled_play")
        let pause = UIImage(named: "pause")
        if CustomAudioManager.shared.playerStatus == .Playing {
            playButton.setBackgroundImage(play, for: UIControlState.normal)
            CustomAudioManager.shared.actionPauseAudio()
        } else {
            playButton.setBackgroundImage(pause, for: UIControlState.normal)
            self.songSlider.minimumValue = 0.0
            self.songSlider.maximumValue = Float(280.0)// Float(CustomAudioManager.shared.playerAudioDuration)
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
            CustomAudioManager.shared.actionPlayAudio(60, index: 0, handler: { (hasErrors: Bool) in
                if hasErrors == true {
                    Utility.showErrorMessage(title: "Message", message: "Error playing audio.", viewController: self)
                }
            })
        }
    }
    func updateTime() {
        print("update slider \(self.songSlider.value) \(CustomAudioManager.shared.playerAudioCurrentTime) \(CustomAudioManager.shared.playerAudioDuration)")
        self.songSlider.value = Float(CustomAudioManager.shared.playerAudioCurrentTime)
    }
    func slideSong() {
        // CustomAudioManager.shared.playerAudioCurrentTime = self.songSlider.value
    }
    func previousSong() {
        CustomAudioManager.shared.actionPreviousAudio(60) { (hasErrors) in
            if hasErrors == true {
                Utility.showErrorMessage(title: "Message", message: "Error playing audio.", viewController: self)
            }        }
    }
    
    func nextSong() {
        CustomAudioManager.shared.actionNextAudio(60) { (hasErrors) in
            if hasErrors == true {
                Utility.showErrorMessage(title: "Message", message: "Error playing audio.", viewController: self)
            }
        }
    }
    
    func cancelMiniplayer() {
        if self.isSlideUpMiniPlayer {
            // animate view and minimize towards bottom of screen.
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
                self.updateFramesOfControlsOnInitialAndSwipeDownAnimation()
            }, completion: { (Void) in
                print("completion")
            })
        } else {
            self.miniPlayerView.removeFromSuperview()
        }
        
        // CustomAudioManager.shared.
    }
}


