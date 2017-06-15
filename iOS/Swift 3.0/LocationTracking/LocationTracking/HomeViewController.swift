
import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var btnLocationUpdate: UISwitch!
    @IBOutlet weak var speedTxt: UITextField!
    let locationManagerHelper = LocationManagerHelper.sharedInstance
    // MARK:- ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnLocationUpdate.isOn = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK:- Private Methods
    
    // MARK:- Actions
    
    @IBAction func enableLocationUpdates(_ sender: UISwitch) {
        // print(sender.isOn == true ? "YES" : "NO")
        if sender.isOn {
            locationManagerHelper.updateUserLocation()
        } else {
            locationManagerHelper.stopLocationUpdate()
        }
    }

}

extension HomeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        // locationManagerHelper.speedInKmPerHour = Double(textField.text!)!
        // locationManagerHelper.locationUpdatesAsPerCalculatedSpeedOfVehicle()
        return true
    }
    
}

