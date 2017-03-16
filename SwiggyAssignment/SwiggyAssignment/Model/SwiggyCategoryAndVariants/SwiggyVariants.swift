//
//  SwiggyVariants.swift
//  SwiggyAssignment
//
//  Created by Subhodip Banerjee on 16/03/17.
//  Copyright © 2017 Subhodip Banerjee. All rights reserved.
//

import UIKit
import SwiftyJSON

class SwiggyVariants: NSObject {
    
    var name: String?
    var price: Int?
    var default_value: Int?
    var id: String?
    var inStock: Int?
    var isVeg: Int?
    
    init (json: JSON) {
        
        super.init()
        
        name = json["name"].stringValue
        price = json["price"].intValue
        default_value = json["default"].intValue
        id = json["id"].stringValue
        inStock = json["inStock"].intValue
        isVeg = json["isVeg"].intValue
        
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        
        let varient = object as? SwiggyVariants
        
        if self.id == varient?.id && self.name == varient?.name {
            
            return true
        }
        
        return false
        
    }
}
