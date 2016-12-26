//
//  SelectedProductDataModel.swift
//  ShoppingCart
//
//  Created by Shridhar Mali on 12/26/16.
//  Copyright © 2016 TIS. All rights reserved.
//

import UIKit

class SelectedProductDataModel: NSObject {
    static let sharedInstance = SelectedProductDataModel()
    var selectedProductImageUrl = String()
    var selectedProductName = String()
    var selectedProductOwner = String()
    var selectedProductPrice = Double()
    
    func clearAllData() {
        selectedProductImageUrl = String()
        selectedProductName = String()
        selectedProductOwner = String()
        selectedProductPrice = Double()
    }
    
}
