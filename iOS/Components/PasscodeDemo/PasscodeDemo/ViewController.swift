//
//  ViewController.swift
//  PasscodeDemo
//
//  Created by Aniruddha Das on 2/6/17.
//  Copyright © 2017 Aniruddha Das. All rights reserved.
//

import UIKit
import LTHPasscodeViewController
import LocalAuthentication

class ViewController: UIViewController, LTHPasscodeViewControllerDelegate {
    
    @IBOutlet weak var changePasscode: UIButton!
    
    @IBOutlet weak var enablePasscode: UIButton!
    
    @IBOutlet weak var testPasscode: UIButton!
    
    @IBOutlet weak var turnOffPasscode: UIButton!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var touchIDLabel: UILabel!
    
    @IBOutlet weak var typeSwitch: UISwitch!
    
    @IBOutlet weak var touchIDSwitch: UISwitch!
    
    func refreshUI() {
        if LTHPasscodeViewController.doesPasscodeExist() {
            self.enablePasscode.isEnabled = false
            self.changePasscode.isEnabled = true
            self.turnOffPasscode.isEnabled = true
            self.testPasscode.isEnabled = true
            //self.showLockViewForTestingPasscode()
        } else {
            self.enablePasscode.isEnabled = true
            self.changePasscode.isEnabled = false
            self.turnOffPasscode.isEnabled = false
            self.testPasscode.isEnabled = false
        }
        
        
        self.typeSwitch.isOn = LTHPasscodeViewController.sharedUser().isSimple()
        
        self.touchIDSwitch.isOn = LTHPasscodeViewController.sharedUser().allowUnlockWithTouchID
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Passcode Demo"
        
        LTHPasscodeViewController.sharedUser().delegate = self
        
        if self.isTouchIDAvailable() {
            typeLabel.isHidden = false
            typeSwitch.isHidden = false
            touchIDLabel.isHidden = false
            touchIDSwitch.isHidden = false
            touchIDSwitch.addTarget(self, action: #selector(touchIDPasscodeType), for: .valueChanged)
            
        } else {
            typeLabel.isHidden = false
            typeSwitch.isHidden = false
            touchIDLabel.isHidden = true
            touchIDSwitch.isHidden = true
        }
        
        
        self.turnOffPasscode.setTitle("Turn Off", for: .normal)
        
        self.changePasscode.setTitle("Change", for: .normal)
        
        self.testPasscode.setTitle("Test", for: .normal)
        
        self.enablePasscode.setTitle("Enable", for: .normal)
        
        self.typeLabel.text = "Simple"
        
        self.refreshUI()
        
        self.changePasscode.addTarget(self, action: #selector(changesPasscode), for: .touchUpInside)
        
        self.enablePasscode.addTarget(self, action: #selector(enablesPasscode), for: .touchUpInside)
        
        self.testPasscode.addTarget(self, action: #selector(testsPasscode), for: .touchUpInside)
        
        self.turnOffPasscode.addTarget(self, action: #selector(turnsOffPasscode), for: .touchUpInside)
        
        self.typeSwitch.addTarget(self, action: #selector(switchPasscodeType), for: .valueChanged)
        
    }
    
    
    func turnsOffPasscode() {
        self.showLockViewForTurningPasscodeOff()
    }
    
    
    func changesPasscode() {
        self.showLockViewForChangingPasscode()
    }
    
    func enablesPasscode() {
        self.showLockViewForEnablingPasscode()
    }
    
    func testsPasscode() {
        self.showLockViewForTestingPasscode()
    }
    
    func switchPasscodeType(sender: UISwitch) {
        LTHPasscodeViewController.sharedUser().setIsSimple(sender.isOn, in: self, asModal: true)
    }
    
    func touchIDPasscodeType(sender: UISwitch) {
        LTHPasscodeViewController.sharedUser().allowUnlockWithTouchID = sender.isOn
    }
    
    func showLockViewForEnablingPasscode() {
        LTHPasscodeViewController.sharedUser().showForEnablingPasscode(in: self, asModal: true)
    }
    
    func showLockViewForTestingPasscode() {
        LTHPasscodeViewController.sharedUser().showLockScreen(withAnimation: true, withLogout: false, andLogoutTitle: nil)
    }

    func showLockViewForChangingPasscode() {
        LTHPasscodeViewController.sharedUser().hidesCancelButton = false
        
        LTHPasscodeViewController.sharedUser().hidesBackButton = false
        
        LTHPasscodeViewController.sharedUser().showForChangingPasscode(in: self, asModal: false)
    }
    
    func showLockViewForTurningPasscodeOff() {
        LTHPasscodeViewController.sharedUser().showForDisablingPasscode(in: self, asModal: false)
    }
    
    func isTouchIDAvailable() -> Bool {
        
        //if UIDevice.currentDevice.systemVersion.compare("8.0", options: NSString.CompareOptions.NumericSearch) != ComparisonResult.OrderedAscending {
        if #available(iOS 8, *) {
            //iOS 8+ code here.
            return LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        }
        
        return false
    }
    
    func passcodeViewControllerWillClose() {
        print("Passcode View Controller Will Be Closed")
        self.refreshUI()
    }
    
    func maxNumberOfFailedAttemptsReached() {
        LTHPasscodeViewController.deletePasscodeAndClose()
        print("Max Number of Failed Attemps Reached")
    }
    
    func passcodeWasEnteredSuccessfully() {
        print("Passcode Was Entered Successfully")
    }
    
    func logoutButtonWasPressed() {
        print("Logout Button Was Pressed")
    }
    
    func passcodeWasEnabled() {
        print("Passcode Was Enabled")
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
