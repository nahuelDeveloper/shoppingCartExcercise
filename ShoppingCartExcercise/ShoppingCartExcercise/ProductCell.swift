//
//  ProductCell.swift
//  ShoppingCartExcercise
//
//  Created by Gonza on 24/4/17.
//  Copyright © 2017 Nahuel. All rights reserved.
//

import UIKit

final class ProductCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    
    
    func configureForBuy() {
        
    }
    
    func configureForDelete() {
        
    }
    
    @IBAction func action(_ sender: Any) {
    
    }
    
    
}
