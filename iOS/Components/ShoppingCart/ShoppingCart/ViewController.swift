//
//  ViewController.swift
//  ShoppingCart
//
//  Created by Shridhar Mali on 12/26/16.
//  Copyright © 2016 TIS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var productImageArray = [String]()
    var productNameArray = [String]()
    var productOwneArray = [String]()
    var productPriceArray = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productImageArray = ["toorDal","moongDal"]
        productNameArray = ["Toor Dal", "Moong Dal"]
        productOwneArray = ["Gallet", "Gemini"]
        productPriceArray = [80, 100]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productNameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductCell
        cell.accessoryType = .disclosureIndicator
        cell.productImgView.image = UIImage(named: productImageArray[indexPath.row])
        cell.productNameLbl.text = productNameArray[indexPath.row]
        cell.productOwnerLbl.text = "by \(productOwneArray[indexPath.row])"
        cell.productPriceLbl.text = "Rs.\(productPriceArray[indexPath.row])"
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Product is: \(productNameArray[indexPath.row])")
        let objSelectedProduct = SelectedProductDataModel.sharedInstance
        objSelectedProduct.selectedProductImageUrl = productImageArray[indexPath.row]
        objSelectedProduct.selectedProductName = productNameArray[indexPath.row]
        objSelectedProduct.selectedProductOwner = productOwneArray[indexPath.row]
        objSelectedProduct.selectedProductPrice = productPriceArray[indexPath.row]
        self.performSegue(withIdentifier: "productDetail", sender: self)
    }
}

