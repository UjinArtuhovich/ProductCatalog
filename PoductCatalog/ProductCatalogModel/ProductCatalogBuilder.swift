//
//  ProductCatalogBuilder.swift
//  PoductCatalog
//
//  Created by Ujin Artuhovich on 5/3/21.
//

import Foundation
import Foundation
//MARK: Builder to init the models
enum URLstring {
    static let baseUrl =  "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list"
}
class ProductCatalogBuilder {
    static func getViewModel() -> ProductCatalogViewModel {
        let urlDataModel = URLdataModel(URLString: URLstring.baseUrl)
        let dataManager = DataManager(URLdataModel: urlDataModel)
        let viewModel = ProductCatalogViewModel(dataManager: dataManager)
        return viewModel
    }
}
