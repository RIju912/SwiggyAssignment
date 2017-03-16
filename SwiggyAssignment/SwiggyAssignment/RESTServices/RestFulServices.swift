//
//  RestFulServices.swift
//  SwiggyAssignment
//
//  Created by Subhodip Banerjee on 16/03/17.
//  Copyright © 2017 Subhodip Banerjee. All rights reserved.
//

import UIKit
import TRON
import Alamofire
import SwiftyJSON

class RestFulServices: NSObject {
    
    
    private static var sharedNetworkManager: RestFulServices = {
        
        let networkManager = RestFulServices()
        return networkManager
        
    }()
    
    class func shared() -> RestFulServices {
        
        return sharedNetworkManager
        
    }
    
    func fetchCategories(_ completion:@escaping ((SwiggyBaseModel?, Error?) -> Void)) {
        
        let getCategoriesAPI = UrlConstants.swiggyAPI
        
        
        Alamofire.request(getCategoriesAPI).validate().responseJSON { response in
            
            switch response.result {
                
            case .success:
                
                if let data = response.data {
                    
                    let jsonError:NSErrorPointer? = nil
                    let json = JSON(data: data, options:JSONSerialization.ReadingOptions.allowFragments, error: nil)
                    
                    if let jsonError = jsonError {
                        
                        completion(nil, jsonError as? Error)
                        
                    }
                    else {
                        
                        let categoryCollection = SwiggyBaseModel()
                        
                        if let categoryList = json["variants"]["variant_groups"].array {
                            
                            for categoryJSON in categoryList {
                                
                                let category = SwiggyCategory(json: categoryJSON)
                                categoryCollection.categories.append(category)
                                
                            }
                            
                        }
                        
                        if let exclusionList = json["variants"]["exclude_list"].array {
                            
                            var finalExlList = [[SwiggyExclusionList]]()
                            
                            for exclusions in exclusionList {
                                
                                var exlList = [SwiggyExclusionList]()
                                
                                if let exclusionJSONs = exclusions.array {
                                    
                                    for exclusionJSON in exclusionJSONs {
                                        
                                        let exclusion = SwiggyExclusionList(json: exclusionJSON)
                                        exlList.append(exclusion)
                                        
                                    }
                                    
                                    finalExlList.append(exlList)
                                    
                                }
                                
                                
                            }
                            
                            categoryCollection.exclusions = finalExlList
                            
                        }
                        
                        completion(categoryCollection, nil)
                        
                    }
                    
                }
                
            case.failure(let error):
                
                completion(nil, error)
                
            }
            
            
        }
        
    }
    
}
