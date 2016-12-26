//
//  ProductCell.swift
//  ShoppingCart
//
//  Created by Shridhar Mali on 12/26/16.
//  Copyright © 2016 TIS. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productOwnerLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
