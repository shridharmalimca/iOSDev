## Core Data

- Core data is not a database, It is a framework that lets developers store or retrive data in database in object oriented way.

- Sqlite is the default persistant store of core data.

- Core data support following persistant stores.
  1. NSSqliteStoreType
  2. NSXMLStoreType
  3. NSBinaryStoreType
  4. NSInMemoryStoreType
- Core data is not a relational databse.

## Core Data Stack

![](CoreDataStack.png)

### Managed Object Context 

- Its job is to manage objects created & returned using core data.
- Whenever you need to fetch, save, edit & delete object in persistant store **Context** is the first component you talk to. 
- It is a scratch pad containing objects that interacts with data in persistant store.

### Persistant Store Coordinator

- SQLite is different persistant store in core data.
- Core data allows developers to set ups multiple store containing different entities.
- Persistant store coordinator is partly responsible to manage persistant object store & save the objects to store.


### Managed Object Model

- It describes the schema that you uses in the app.
- Schema is represented by collection of objects (Also known as entities)
- Managed Object Model is defined in a file with the extension **.xcdatamodeld**
- You can use visual editor to define the entities & their attributes as well as relationships.


## Steps to create core data example

1) Open Xcode -> File -> New -> Project -> Select Single View Application Template -> Name it **CoreDataTutorial** select **Use Core Data** checkbox

![](Step1.png)


2) Open Main.storyboard file, selecte view controller xib file and Embed in Navigation controller.

![](Step2.png)

After Embed view controller it will be look like following screen

![](Step2-1.png)

3) We have to design application for Insert, Select, Update and Delete operations.

Add ***rightBarButtonItem*** on the navigationBar using following code in viewWillAppear of ViewController 

```
self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.addRecord))

```

```
func addRecord() {
        
}
    
```

4) Add ViewController for Insert record in the database.

Drag ViewController from Library and drop into Main.storyboard, Make connection from ViewController to dragged ViewController using Control Key -> Select Present Modally.

![](Step4.png)

Add identifier **addAppointment** for segue 

![](Step4-1.png)

5) Design Screen for Insert Record with fields
Name, Age and Address and a buttons for save.

![](Step5.png)

6) Add new file of **AppointmentViewController** of type UIViewController and assign to this ViewController also create IBOutlets of all controls 

```
	 @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var nameOfPatient: UITextField!
    @IBOutlet weak var ageOfPatient: UITextField!
    @IBOutlet weak var addressOfPatient: UITextField!
    
```

Create IBAction of Confirm Button

```

 @IBAction func confirmAppointment(_ sender: Any){
    }
    
```


7) In AppDelegate.swift file we get some ready made code for core data stack.


```

// MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CoreDataTutorial")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
```


**Please don't delete anything from this pre-populated code**

We need `persistentContainer.viewContext` as context in controllers when we deal with the database.

`NSPersistentContainer` is Container which having. 

- `viewCOntext` as Type of `NSManagedObjectContext`.
- `managedObjectModel` as Type of `NSManagedObjectModel`.
- `persistentStoreCoordinator` as Type of `NSPersistentStoreCoordinator`.
- `persistentStoreDescriptions` as Type of `[NSPersistentStoreDescription]`.


8) Open **AppointmentViewController** 

- Import CoreData framework
- create constant variable 
`let appDelegate = UIApplication.shared.delegate as! AppDelegate`
- Add function 

```
func getContext() -> NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
```

```
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

```

```

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
    
    
```
 
Set delegate of all UITextFields and add following code.

```

extension AppointmentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

```








  