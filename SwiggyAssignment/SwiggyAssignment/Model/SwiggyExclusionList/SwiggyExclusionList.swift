//
//  SwiggyExclusionList.swift
//  SwiggyAssignment
//
//  Created by Subhodip Banerjee on 16/03/17.
//  Copyright © 2017 Subhodip Banerjee. All rights reserved.
//

import UIKit
import SwiftyJSON

class SwiggyExclusionList: NSObject {
    
    //MARK: - Model Class Variables
    var groupID: String?
    var variationID: String?
    
    //MARK: - Init
    init (json: JSON) {
        
        super.init()
        
        groupID = json["group_id"].stringValue
        variationID = json["variation_id"].stringValue
        
    }
    
    init (groupID: String?, variationID: String) {
        
        super.init()
        
        self.groupID = groupID
        self.variationID = variationID
        
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        
        let exclusion = object as? SwiggyExclusionList
        
        if self.groupID == exclusion?.groupID && self.variationID == exclusion?.variationID {
            
            return true
        }
        
        return false
        
    }
}
