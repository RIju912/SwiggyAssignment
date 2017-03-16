//
//  Constants.swift
//  SwiggyAssignment
//
//  Created by Subhodip Banerjee on 16/03/17.
//  Copyright © 2017 Subhodip Banerjee. All rights reserved.
//

import Foundation
import UIKit

//MARK: - URL Constants
struct UrlConstants {
    
    static var swiggyAPI = "https://api.myjson.com/bins/3b0u2"
    
}

//MARK: - App Constants
struct AppConstants {
    
    static var pleaseWait = "Please wait..."
    static var noInternet = "Sorry, no internet connections available."
    static var processData = "Processing data..."
    static var noItem = "Sorry, Item is in the exclusion list."
    static var categoryCellIdentifier = "SwiggyCategoryCell"
    static var varientCellIdentifier = "SwiggyVarientCell"
    
}

struct APIConstants {
    static var variants = "variants"
    static var variantGroups = "variant_groups"
    static var excludeList = "exclude_list"
}

//MARK: - Extension
extension UIViewController {
    
    //MARK: - default alert/info message with an OK button.
    func showAlertMessage(_ message: String, okButtonTitle: String = "Ok") -> Void {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okButtonTitle, style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

//*******************Extension to handle Optional value************************//
extension Optional {
    func or(_ defaultValue: Wrapped) -> Wrapped {
        if self == nil{
            return defaultValue
        }
        else if self is NSNull{
            return defaultValue
        }else{
            return self!
        }
    }
}
//*******************Extension to handle Optional value************************//


//MARK: - TableView Tags
struct TableViewTag {
    
    static var categoryTableView = 1
    static var varientTableView = 2
    
}
