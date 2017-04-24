//
//  ShoppingCart.swift
//  ShoppingCartExcercise
//
//  Created by Gonza on 24/4/17.
//  Copyright © 2017 Nahuel. All rights reserved.
//

import Foundation

final class ShoppingCart {
    
    static let instance = ShoppingCart()
    
    private init() {
    
    }
    
    var products: [Product] = [Product]()
}
