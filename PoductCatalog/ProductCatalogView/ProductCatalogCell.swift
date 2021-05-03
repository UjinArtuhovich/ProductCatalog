//
//  File.swift
//  PoductCatalog
//
//  Created by Ujin Artuhovich on 5/3/21.
//

import UIKit
import CoreData
class ProductCatalogCell: UICollectionViewCell {
    var imageCache = NSCache<NSString, UIImage>()
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    var data: Product! {
        didSet {
            productName.text = data.name
            productPrice.text = "$\(data.price)"
            guard let url = URL(string: data.image) else {return}
            //MARK: Cache
            if let image = imageCache.object(forKey: data.image as NSString) {
                productImage.image = image
                return
            }
            guard let data = try? Data(contentsOf: url) else {return}
            productImage.image = UIImage(data: data)
            //MARK: Save cache
            imageCache.setObject(productImage.image!, forKey: self.data.image as NSString)
            //MARK: Save in CoreData
            DataBaseManager.shareInstance.saveImage(data: data)
        }
    }
}
