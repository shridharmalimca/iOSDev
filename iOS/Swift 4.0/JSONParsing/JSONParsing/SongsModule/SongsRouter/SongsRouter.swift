//
//  SongsRouter.swift
//  JSONParsing
//
//  Created by Shridhar Mali on 12/28/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import Foundation
import UIKit
protocol SongsRouterDelegate: class {
    func natigateToScene(_ segue: UIStoryboardSegue)
}
class SongsRouter: NSObject {
    weak var routerDelegate: SongsRouterDelegate!
}

extension SongsRouter: SongsRouterDelegate {
    func natigateToScene(_ segue: UIStoryboardSegue) {
        if segue.identifier == "details" {
            let detailsVC = segue.destination as! DetailViewController
            detailsVC.name = "Shridhar"
        }
    }
}
