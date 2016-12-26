//
//  ProductDetailVC.swift
//  ShoppingCart
//
//  Created by Shridhar Mali on 12/26/16.
//  Copyright © 2016 TIS. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {

    @IBOutlet weak var productImgView: UIImageView!
    let objSelectedProduct = SelectedProductDataModel.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("product image name:\(objSelectedProduct.selectedProductImageUrl)")
        productImgView.image = UIImage(named: objSelectedProduct.selectedProductImageUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToCartClicked(_ sender: Any) {
        //Add  product to cart and update cart details
    }

    @IBAction func buyClicked(_ sender: Any) {
        //Navigate to payment/checkout screen
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
