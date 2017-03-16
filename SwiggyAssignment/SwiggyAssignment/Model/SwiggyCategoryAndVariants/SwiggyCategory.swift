//
//  SwiggyCategory.swift
//  SwiggyAssignment
//
//  Created by Subhodip Banerjee on 16/03/17.
//  Copyright © 2017 Subhodip Banerjee. All rights reserved.
//

import UIKit
import SwiftyJSON

class SwiggyCategory: NSObject {
    
    //MARK: - Model Class Variables
    var groupID: String?
    var name: String?
    var variants = [SwiggyVariants]()
    var selectedVarient: SwiggyVariants?
    var selectedVarientExclusion: SwiggyExclusionList?
    
    //MARK: - Init
    init (json: JSON) {
        
        super.init()
        
        groupID = json["group_id"].stringValue
        name = json["name"].stringValue
        
        let variations = json["variations"].array
        
        if let _ = variations {
            
            for variantJSON in variations! {
                
                let varient = SwiggyVariants(json: variantJSON)
                variants.append(varient)
                
            }
            
        }
        
    }
}
