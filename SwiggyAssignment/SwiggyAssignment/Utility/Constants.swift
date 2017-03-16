//
//  Constants.swift
//  SwiggyAssignment
//
//  Created by Subhodip Banerjee on 16/03/17.
//  Copyright © 2017 Subhodip Banerjee. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Constants
struct UrlConstants {
    
    static var swiggyAPI = "https://api.myjson.com/bins/3b0u2"
    
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
