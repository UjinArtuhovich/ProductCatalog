//
//  ViewController.swift
//  PoductCatalog
//
//  Created by Ujin Artuhovich on 5/3/21.
//

import UIKit
class ProductCatalogViewController: UIViewController {
    private var products = [Product]()
    private var productCatalogViewModel: ProductCatalogViewModel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isHidden = true
        getProducts()
    }
    fileprivate func getProducts() {
        productCatalogViewModel = ProductCatalogBuilder.getViewModel()
        productCatalogViewModel.getData()
        productCatalogViewModel.dataViewUpdated = { [weak self] in
            guard let self = self else {return}
            self.products = self.productCatalogViewModel.productCatalogViewData.products
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
        }
    }
}

extension ProductCatalogViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //MARK: DidSelected action
        getProductDescriptionData(index: indexPath.item) { product, error in
            guard let product = product else {
                self.presentCustomAlertController(withTitle: "Error", message: "No description", style: .alert)
                return
            }
            let productDescription = product.description
            let productName = product.name
            self.presentCustomAlertController(withTitle: productName, message: productDescription, style: .alert)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ProductCatalogCell
        //MARK: Check Internet connection
        if !InternetConnectionObserver.shared.isInternetAvailable() {
            let productDataBase = DataBaseManager.shareInstance.fetchImage()
            //MARK: Check CoreData context
            if (productDataBase.image.count != 1) {
                cell.productImage.image = UIImage(data: productDataBase.image[indexPath.item].image!)
                cell.productName.text = productDataBase.name[indexPath.item].name!
                cell.productPrice.text = "$\(productDataBase.price[indexPath.item].price)"
            } else {
                let image = UIImage(named: "error")
                cell.productImage.image = image
            }
        } else {
            cell.data = products[indexPath.item]
        }
        return cell
    }
}

