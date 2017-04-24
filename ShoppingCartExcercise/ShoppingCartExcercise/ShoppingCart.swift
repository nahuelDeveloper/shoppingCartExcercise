//
//  ShoppingCart.swift
//  ShoppingCartExcercise
//
//  Created by Gonza on 24/4/17.
//  Copyright © 2017 Nahuel. All rights reserved.
//

import Foundation

enum CartNotifications: String {
    case productCountChanged = "productCountChanged"
    case totalAmountChanged = "totalAmountChanged"
}

final class ShoppingCart {
    
    var products: [Product] = [Product]()
    var productsCount: Int = 0 {
        didSet {
            let dict:[String: String] = ["count": "\(productsCount)"]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: CartNotifications.productCountChanged.rawValue), object: dict)
        }
    }
    var totalAmount: Double = 0.0 {
        didSet {
            let dict:[String: String] = ["amount": "\(totalAmount)"]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: CartNotifications.totalAmountChanged.rawValue), object: dict)
        }
    }
    
    init(products: [Product]) {
        self.products = products
    }
    
    func getProductById(id : Int) -> Product? {
        
        for product in products {
            if product.id == id {
                return product
            }
        }
        
        return nil
    }
    
    func addProductToCart(product: Product) {
        let isNotEmpty = product.decreaseStockAndCheckIfNotEmpty()
        if isNotEmpty == false {
            return
        }
        productsCount += 1
        totalAmount += product.price
    }
}
