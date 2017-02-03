//
//  ViewController.swift
//  CoreDataTutorial
//
//  Created by Shridhar Mali on 2/1/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    @IBOutlet weak var tblPatient: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var patientData = [NSManagedObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Patients"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.addAppointment))
        readDatabase()
    }
    
    func addAppointment() {
        patientData.removeAll()
        appDelegate.isAddPatient = true
        self.performSegue(withIdentifier: "addAppointment", sender: self)
    }
    
    func readDatabase() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        do {
            patientData.removeAll()
            let data = try getContext().fetch(fetchRequest)
            print(data.count)
            for patient in data as! [NSManagedObject] {
                patientData.append(patient)
            }
            tblPatient.reloadData()
        } catch {
            
        }
    }

    func getContext () -> NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if patientData.count != 0 {
            cell.textLabel?.text = patientData[indexPath.row].value(forKey: "name") as! String?
        }
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let object = patientData[indexPath.row] 
            let context = getContext()
            context.delete(object)
            patientData.remove(at: indexPath.row)
            do {
                try context.save()
                print("Object deleted from DB")
                tblPatient.reloadData()
            } catch let error as NSError {
                print(error)
            } catch {
                
            }
        }
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appDelegate.isAddPatient = false
        appDelegate.selectedPatient = patientData[indexPath.row]
        self.performSegue(withIdentifier: "addAppointment", sender: self)
    }
}


