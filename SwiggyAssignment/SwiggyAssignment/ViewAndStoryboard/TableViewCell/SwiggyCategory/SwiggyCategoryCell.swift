//
//  SwiggyCategoryCell.swift
//  SwiggyAssignment
//
//  Created by Subhodip Banerjee on 16/03/17.
//  Copyright © 2017 Subhodip Banerjee. All rights reserved.
//

import UIKit

class SwiggyCategoryCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var iboCategoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK: - Cell Setup
    func setupCellForCategory(category: SwiggyCategory)  {
        
        iboCategoryNameLabel.text = category.name
        
    }

}
