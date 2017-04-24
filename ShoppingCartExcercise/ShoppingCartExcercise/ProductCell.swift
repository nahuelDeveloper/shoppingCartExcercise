//
//  ProductCell.swift
//  ShoppingCartExcercise
//
//  Created by Gonza on 24/4/17.
//  Copyright © 2017 Nahuel. All rights reserved.
//

import UIKit

enum ProductCellType {
    case buy
    case delete
}

protocol ProductCellDelegate: class {
    func actionButtonPressed(cell: ProductCell)
}

final class ProductCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    
    weak var delegate: ProductCellDelegate?
    
    func configure(with product: Product, type: ProductCellType) {
        configureForBuy()
        
        nameLabel.text = "Name: \(product.name)"
        priceLabel.text = "Price: \(product.price)"
        stockLabel.text = "Stock: \(product.stock)"
    }
    
    func configure(with shoppingCartItem: ShoppingCartItem) {
        configureForDelete()
        
        nameLabel.text = "Name: \(shoppingCartItem.name)"
        stockLabel.text = "Count: \(shoppingCartItem.count)"
    }
    
    /// The products can be added to the shopping cart using a [Buy] button for each row
    func configureForBuy() {
        actionButton.setTitle("BUY", for: .normal)
        actionButton.backgroundColor = UIColor.green
    }
    
    /// ...each product should have a [Delete] button.
    func configureForDelete() {
        actionButton.setTitle("DELETE", for: .normal)
        actionButton.backgroundColor = UIColor.red
        priceLabel.isHidden = true
    }
    
    @IBAction func action(_ sender: Any) {
        delegate?.actionButtonPressed(cell: self)
    }
    
    
}
