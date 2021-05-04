//
//  ProductCatalogAPIData.swift
//  PoductCatalog
//
//  Created by Ujin Artuhovich on 5/3/21.
//

import Foundation

// MARK: - Products
struct Products: Decodable {
    let products: [Product]
}
// MARK: - Product
struct Product: Decodable {
    let productID, name: String
    let price: Int
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
        case name, price, image
    }
}
