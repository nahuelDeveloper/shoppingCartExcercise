//
//  ShoppingCartItem.swift
//  ShoppingCartExcercise
//
//  Created by Gonza on 24/4/17.
//  Copyright © 2017 Nahuel. All rights reserved.
//

import Foundation

/// A ShoppingCartItem is a Product that has been added to the cart
final class ShoppingCartItem: Product, Hashable, Equatable {
    
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func ==(lhs: ShoppingCartItem, rhs: ShoppingCartItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    var count: Int = 0
    
    var hashValue: Int {
        return self.id
    }
    
    init(with product: Product) {
        super.init(id: product.id, name: product.name, price: product.price, stock: product.stock)
        
        count = 1
    }
    
    func decreaseCountAndCheckIfNotEmpty() -> Bool {

        if count == 1 {
            return false
        } else {
            count -= 1
            return true
        }
        
//        if count > 0 {
//            count -= 1
//            
//            if count == 0 {
//                return false
//            }
//            
//            return true
//        }
//        
//        return false
    }
}

