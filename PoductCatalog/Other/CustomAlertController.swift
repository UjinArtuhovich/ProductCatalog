//
//  CustomAlertController.swift
//  PoductCatalog
//
//  Created by Ujin Artuhovich on 5/3/21.
//

import Foundation
import UIKit
extension ProductCatalogViewController {
    func presentCustomAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
    }
}
