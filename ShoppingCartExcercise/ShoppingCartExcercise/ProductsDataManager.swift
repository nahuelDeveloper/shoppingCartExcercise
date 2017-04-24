//
//  ProductsDataManager.swift
//  ShoppingCartExcercise
//
//  Created by Gonza on 24/4/17.
//  Copyright © 2017 Nahuel. All rights reserved.
//

import Foundation

/// Dummy data provider
final class ProductsDataManager {
    
    static func getDummyProducts() -> [Product] {
        var products: [Product] = [Product]()
        
        for index in 0...19 {
            let product = Product(
                id: index,
                name: "Product \(index + 1)",
                price: Double(index) * 5.0,
                stock: 1 + index*2)
            
            products.append(product)
        }
        
        return products
    }
}
