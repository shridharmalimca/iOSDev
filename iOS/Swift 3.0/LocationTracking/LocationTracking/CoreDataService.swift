//
//  CoreDataService.swift
//  LocationTracking
//
//  Created by Shridhar Mali on 6/13/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import CoreData
protocol CoreDataServiceProtocol:class {
    var errorHandler: (Error) -> Void {get set}
    var persistentContainer: NSPersistentContainer {get}
    var mainContext: NSManagedObjectContext {get}
    var backgroundContext: NSManagedObjectContext {get}
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void)
    func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void)
}

final class CoreDataService: CoreDataServiceProtocol {
    
    static let shared = CoreDataService()
    var errorHandler: (Error) -> Void = {_ in }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = PersistentContainer(name: "LocationTracking")
        
        if let fileLocation = container.persistentStoreDescriptions[0].url?.absoluteString {
            
            print("Core Database file location : \n\t \(fileLocation).")
            
        }
        
        container.loadPersistentStores(completionHandler: { [weak self](storeDescription, error) in
            if let error = error {
                NSLog("CoreData error \(error), \(String(describing: error._userInfo))")
                self?.errorHandler(error)
            }
        })
        return container
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.mainContext.perform {
            block(self.mainContext)
        }
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.persistentContainer.performBackgroundTask(block)
    }
    
    func saveContext() {
        let backgrounndContext = backgroundContext
        
        if backgrounndContext.hasChanges {
            do {
                try backgrounndContext.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
