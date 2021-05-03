//
//  DataManager.swift
//  PoductCatalog
//
//  Created by Ujin Artuhovich on 5/3/21.
//

import Foundation
//MARK: Model to parse API data
class DataManager {
    private var URLdataModel: URLdataModel
    init(URLdataModel: URLdataModel) {
        self.URLdataModel = URLdataModel
    }
    func getProductCatalogAPIData(completion: @escaping(Products?, Error?)->()) {
        URLdataModel.fetchURLdata { data, error in
            let decoder = JSONDecoder()
            if let error = error {
                completion(nil, error)
            }
            do {
                guard let data = data else { return }
                let prodCatAPIData = try decoder.decode(Products.self, from: data)
                completion(prodCatAPIData, nil)
            }
            catch let error as NSError {
                completion(nil, error)
            }
        }
    }
}
