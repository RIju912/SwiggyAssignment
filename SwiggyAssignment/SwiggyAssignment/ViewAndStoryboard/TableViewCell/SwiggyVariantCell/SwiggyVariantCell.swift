//
//  SwiggyVariantCell.swift
//  SwiggyAssignment
//
//  Created by Subhodip Banerjee on 16/03/17.
//  Copyright © 2017 Subhodip Banerjee. All rights reserved.
//

import UIKit

class SwiggyVariantCell: UITableViewCell {

    @IBOutlet weak var iboVarientNameLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    
    func setupCellForVarient(varient: SwiggyVariants)  {
        
        iboVarientNameLabel.text = varient.name
        
    }

}
