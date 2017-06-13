//
//  PersistentContainer.swift
//  LocationTracking
//
//  Created by Shridhar Mali on 6/13/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import CoreData

struct CoreDataServiceConsts {
    static let applicationGroupIdentifier = "group.com.identifier.app-name"
}

final class PersistentContainer: NSPersistentContainer {
    internal override class func defaultDirectoryURL() -> URL {
        var url = super.defaultDirectoryURL()
        if let newURL =
            FileManager.default.containerURL(
                forSecurityApplicationGroupIdentifier: CoreDataServiceConsts.applicationGroupIdentifier) {
            url = newURL
        }
        return url
    }
}
