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
    func saveImage(data: Data) {
        let imageInstance = ProductImage(context: context)
        imageInstance.image = data
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    func fetchImage() -> [ProductImage] {
        var fetchingImage = [ProductImage]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductImage")
        do {
            fetchingImage = try context.fetch(fetchRequest) as! [ProductImage]
        } catch let error as NSError {
            print(error)
        }
        return fetchingImage
    }
}
