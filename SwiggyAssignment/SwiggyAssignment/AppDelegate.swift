//
//  AppDelegate.swift
//  SwiggyAssignment
//
//  Created by Subhodip Banerjee on 16/03/17.
//  Copyright © 2017 Subhodip Banerjee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        reachability = Reachability.forInternetConnection()
        reachability.startNotifier()
        /*************************Disable autolayout constraint error messages*******************************/
        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        /*************************Disable autolayout constraint error messages*******************************/
        return true
    }



}

