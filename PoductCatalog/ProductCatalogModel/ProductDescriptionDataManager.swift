//
//  ProductDescriptionDataManager.swift
//  PoductCatalog
//
//  Created by Ujin Artuhovich on 5/3/21.
//

import Foundation
extension ProductCatalogViewController {
    //MARK: Get description
    func getProductDescriptionData(index: Int, completion: @escaping(ProductDescription?, Error?)->()) {
        guard let url = URL(string: "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/\(index+1)/detail") else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                }
                else if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let productD = try decoder.decode(ProductDescription.self, from: data)
                        completion(productD, nil)
                    }
                    catch let error as NSError {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
}
