//
//  DataBaseManager.swift
//  PoductCatalog
//
//  Created by Ujin Artuhovich on 5/3/21.
//

import Foundation
import UIKit
import CoreData
class DataBaseManager {
    static let shareInstance = DataBaseManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func saveImage(data: Data, name: String, price: Int32) {
        let imageInstance = ProductImage(context: context)
        let nameInstance = ProductName(context: context)
        let priceInstance = ProductPrice(context: context)
        imageInstance.image = data
        nameInstance.name = name
        priceInstance.price = price
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    func fetchImage() -> (image: [ProductImage], name: [ProductName], price: [ProductPrice]) {
        var fetchingTuple = (image: [ProductImage](), name: [ProductName](), price: [ProductPrice]())
        let fetchImageRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductImage")
        let fetchNameRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductName")
        let fetchPriceRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductPrice")
        do {
            fetchingTuple.image = try context.fetch(fetchImageRequest) as! [ProductImage]
            fetchingTuple.name = try context.fetch(fetchNameRequest) as! [ProductName]
            fetchingTuple.price = try context.fetch(fetchPriceRequest) as! [ProductPrice]
        } catch let error as NSError {
            print(error)
        }
        return fetchingTuple
    }
}
