//
//  HomeVC.swift
//  SwiggyAssignment
//
//  Created by Subhodip Banerjee on 16/03/17.
//  Copyright © 2017 Subhodip Banerjee. All rights reserved.
//

import UIKit
import SystemConfiguration
import NVActivityIndicatorView

var reachability = Reachability()

class HomeVC: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var iboCategoryListingTableView: UITableView!
    @IBOutlet weak var iboVarientListingTableView: UITableView!
    
    @IBOutlet weak var iboNameLabel: UILabel!
    @IBOutlet weak var iboStockLabel: UILabel!
    @IBOutlet weak var iboPriceLabel: UILabel!
    
    var categoryCollection: SwiggyBaseModel?
    var selectedCategory: SwiggyCategory?
    let size = CGSize(width: 30, height: 30)
    
    let categoryCellIdentifier = "SwiggyCategoryCell"
    let varientCellIdentifier = "SwiggyVarientCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
    }
    
    //MARK: - View Setup
    func viewSetup(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityStatusChanged(_:)), name: .reachabilityChanged, object: nil)
        startAnimating(size, message: "Please wait...", type: NVActivityIndicatorType(rawValue: 30)!)
        updateInterfaceWithCurrent(networkStatus: reachability.currentReachabilityStatus())
    }
    
    func reachabilityStatusChanged(_ sender: NSNotification) {
        guard let networkStatus = (sender.object as? Reachability)?.currentReachabilityStatus() else { return }
        updateInterfaceWithCurrent(networkStatus: networkStatus)
    }
    
    //MARK: - Reachbility via API Call & Data loading
    func updateInterfaceWithCurrent(networkStatus: NetworkStatus) {
        switch networkStatus {
        case NotReachable:
            self.showAlertMessage("Sorry, no internet connections available.")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
                self.stopAnimating()
            }
            return
        case ReachableViaWiFi:
            self.loadAllData()
        case ReachableViaWWAN:
            self.loadAllData()
        default:
            return
        }
        
    }
    
    func loadAllData(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage("Processing data...")
        }
        
        RestFulServices.shared().fetchCategories { (categoryCollection, error) in
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
                self.stopAnimating()
            }
            
            if nil != categoryCollection {
                
                self.categoryCollection = categoryCollection
                
            }
            
            self.iboCategoryListingTableView.reloadData()
            
        }
    }
    
    func isContainedInExclusionList(exclusion: SwiggyExclusionList) -> Bool {
        
        for exclusions in (categoryCollection?.exclusions)! {
            
            if exclusions.contains(where: { $0 == exclusion }) {
                
                for category in (categoryCollection?.categories)! {
                    
                    
                    if nil != category.selectedVarient && exclusions.contains(where: { $0 == category.selectedVarientExclusion}) {
                        
                        return true
                        
                    }
                    
                    
                }
                
                
            }
            
        }
        
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == TableViewTag.categoryTableView {
            
            return categoryCollection?.categories.count ?? 0
            
        }
        else {
            
            return self.selectedCategory?.variants.count ?? 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == TableViewTag.categoryTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellIdentifier, for: indexPath) as! SwiggyCategoryCell
            cell.setupCellForCategory(category: (categoryCollection?.categories[indexPath.row])!)
            return cell
            
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: varientCellIdentifier, for: indexPath) as! SwiggyVariantCell
            cell.setupCellForVarient(varient: (selectedCategory?.variants[indexPath.row])!)
            
            if nil !=  selectedCategory?.selectedVarient && (selectedCategory?.selectedVarient?.isEqual(selectedCategory?.variants[indexPath.row]))! {
                
                cell.backgroundColor = UIColor.cyan
                
            }
            else {
                
                cell.backgroundColor = UIColor.clear
                
            }
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if tableView.tag == TableViewTag.categoryTableView {
            
            selectedCategory = categoryCollection?.categories[indexPath.row]
            iboVarientListingTableView.reloadData()
            
        }
        else {
            
            let varient = selectedCategory?.variants[indexPath.row]
            let exclsn = SwiggyExclusionList.init(groupID: selectedCategory?.groupID, variationID: (varient?.id).or(""))
            let isExcluded = isContainedInExclusionList(exclusion: exclsn)
            
            if isExcluded {
                
                self.showAlertMessage("Sorry, Item is in the exclusion list.")
                
            }
            else {
                
                selectedCategory?.selectedVarient = varient
                selectedCategory?.selectedVarientExclusion = SwiggyExclusionList(groupID: selectedCategory?.groupID, variationID: (varient?.id)!)
                iboNameLabel.text = varient?.name
                iboPriceLabel.text = "\(varient!.price.or(0))"
                iboStockLabel.text = "\(varient!.inStock.or(0))"
                iboVarientListingTableView.reloadData()
                
            }
            
            
        }
        
    }
    
}
