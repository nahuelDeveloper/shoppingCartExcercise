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
    
    static let instance = ShoppingCart()
    
    var products: [Product] = [Product]()
    
    var items: Set<ShoppingCartItem> = Set<ShoppingCartItem>()
    
    var shoppingCartItems: [ShoppingCartItem] {
        get {
            return Array(items)
        }
    }
    
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
        
    func getProductById(id : Int) -> Product? {
        
        for product in products {
            if product.id == id {
                return product
            }
        }
        
        return nil
    }
    
    func getProductsForShoppingCart() -> [ShoppingCartItem] {
        
        var _items: [ShoppingCartItem] = [ShoppingCartItem]()
        
        for item in items {
            _items.append(item)
        }
        
        return _items
    }
    
    func addProductToCart(product: Product) {
        
        let isNotEmpty = product.decreaseStockAndCheckIfNotEmpty()
        if isNotEmpty == false {
            // Shouldn't appear on Product screen
            return
        }
        
        productsCount += 1
        totalAmount += product.price
        
//        shoppingCartProducts.insert(product.id)
        
        let result = items.insert(ShoppingCartItem(with: product))
        
        if result.0 == true {
            print("New product inserted")
        } else {
            print("Product already inserted")
            let shoppingCartItem = result.1 as ShoppingCartItem
            shoppingCartItem.count += 1
        }
    }
    
    func removeShoppingItemFromCart(item: ShoppingCartItem) -> Bool {
        
        increaseStockForProduct(product: item)
        
        let isNotEmpty = item.decreaseCountAndCheckIfNotEmpty()
        if isNotEmpty == false {
            // Shouldn't appear on Shopping Cart screen
            return false
        }
        
        productsCount -= 1
        totalAmount -= item.price
        
        return true
    }
    
    func increaseStockForProduct(product: Product) {
        
        for _product in ShoppingCart.instance.products {
            if _product.id == product.id {
                _product.increaseStock()
            }
        }
    }
}
