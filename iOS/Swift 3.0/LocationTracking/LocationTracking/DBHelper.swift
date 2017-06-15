import UIKit
import CoreData
class DBHelper: NSObject {
    static let instance = DBHelper()
    let context = CoreDataService.shared.mainContext
    let backgroundContext = CoreDataService.shared.backgroundContext
    var locations = [NSManagedObject]()
    // Save Updated user location In local DB
    func saveLocationUpdatedDataInLocalDB(time: Date, latitude: Double, longitude: Double, currentTimeInterval: Int, nextTimeInterval: Int, speed: Double) {
        let entity = NSEntityDescription.entity(forEntityName: "Locations", in: self.backgroundContext)
        let managedObjectRecord = NSManagedObject(entity: entity!, insertInto: self.backgroundContext)
        
        managedObjectRecord.setValue(time, forKey: "time")
        managedObjectRecord.setValue(latitude, forKey: "latitude")
        managedObjectRecord.setValue(longitude, forKey: "longitude")
        managedObjectRecord.setValue(currentTimeInterval, forKey: "currentTimeInterval")
        managedObjectRecord.setValue(nextTimeInterval, forKey: "nextTimeInterval")
        managedObjectRecord.setValue(speed, forKey: "speed")
        
        do {
            try self.backgroundContext.save()
            print("Successfully inserted location data")
        } catch let error {
            print("Error while insert location data \(error)")
        }
    }
    
    // Get Saved user locations from local DB
    func getLocationDataFromLocalDB() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Locations")
        do {
            let data = try self.context.fetch(request) as! [NSManagedObject]
            locations = [NSManagedObject]()
            for item in data as [NSManagedObject] {
                locations.append(item)
            }
        } catch let err {
            print("Error while fetching locations \(err)")
        }
    }
}
