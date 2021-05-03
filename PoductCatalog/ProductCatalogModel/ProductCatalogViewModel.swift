//
//  ProductCatalogViewModel.swift
//  PoductCatalog
//
//  Created by Ujin Artuhovich on 5/3/21.
//

import Foundation
class ProductCatalogViewModel {
    var productCatalogViewData: Products!
    var dataViewUpdated: (() -> ())?
    var dataManager: DataManager
    required init(dataManager: DataManager) {
        self.dataManager = dataManager
        productCatalogViewData = nil
    }
    //MARK: Transfer APIData to Entity
    func getData() {
        dataManager.getProductCatalogAPIData { data, error in
            guard let data = data else { return }
            self.productCatalogViewData = data
            self.dataViewUpdated?()
        }
    }
}
