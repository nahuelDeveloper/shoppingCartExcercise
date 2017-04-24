//
//  Product.swift
//  ShoppingCartExcercise
//
//  Created by Gonza on 24/4/17.
//  Copyright © 2017 Nahuel. All rights reserved.
//

import Foundation

/// Each prodcut must have a name, price, and stock amount
final class Product {
    
    var name: String
    var price: Double
    var stock: Int
    
    init(name: String, price: Double, stock: Int) {
        self.name = name
        self.price = price
        self.stock = stock
    }
    
    func increaseStock() {
        stock += 1
    }
    
    func decreaseStock() {
        if stock > 0 {
            stock -= 1
        }
    }
}
