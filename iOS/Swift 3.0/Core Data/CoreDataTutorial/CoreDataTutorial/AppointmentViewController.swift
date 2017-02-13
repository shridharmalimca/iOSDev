//
//  AppointmentViewController.swift
//  CoreDataTutorial
//
//  Created by Shridhar Mali on 2/2/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit
import CoreData
class AppointmentViewController: UIViewController {
    
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var nameOfPatient: UITextField!
    @IBOutlet weak var ageOfPatient: UITextField!
    @IBOutlet weak var addressOfPatient: UITextField!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !appDelegate.isAddPatient {
            self.confirmBtn.setTitle("Update", for: .normal)
            nameOfPatient.text = appDelegate.selectedPatient.value(forKey: "name") as! String?
            if let age = appDelegate.selectedPatient.value(forKey: "age") as! Int? {
                ageOfPatient.text = String(describing:age)
            }
            addressOfPatient.text = appDelegate.selectedPatient.value(forKey: "address") as! String?
        } else {
            self.confirmBtn.setTitle("Confirm", for: .normal)
        }
    }

    func getContext () -> NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func confirmAppointment(_ sender: Any) {
        
        if nameOfPatient.text?.characters.count == 0 {
            
        } else if ageOfPatient.text?.characters.count == 0 {
            
        } else if addressOfPatient.text?.characters.count == 0 {
            
        } else {
            let name: String! = nameOfPatient.text
            let age: Int! = Int(ageOfPatient.text!)
            let address: String! = addressOfPatient.text
            print(name)
            print(age)
            print(address)
            
            saveDataInDatabase(name: name, age: age, address: address)
        }
        
    }
    
    func saveDataInDatabase(name: String, age: Int, address: String) {
        let context = getContext()
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "Student", in: context)
        let manageObjectStudent = NSManagedObject(entity: entity!, insertInto: context)
        if !appDelegate.isAddPatient {
            // Update
            print("Update here")
            appDelegate.selectedPatient.setValue(name, forKey: "name")
            appDelegate.selectedPatient.setValue(age, forKey: "age")
            appDelegate.selectedPatient.setValue(address, forKey: "address")
            
        } else {
            // Add
            manageObjectStudent.setValue(name, forKey: "name")
            manageObjectStudent.setValue(age, forKey: "age")
            manageObjectStudent.setValue(address, forKey: "address")
            
        }
        
        //save the object
        do {
            try context.save()
            print("saved!")
            self.dismiss(animated: true, completion: nil)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
}


extension AppointmentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
