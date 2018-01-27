//
//  CustomTableViewCell.swift
//  CustomTableviewCell
//
//  Created by Shridhar Mali on 1/27/18.
//  Copyright © 2018 Shridhar Mali. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTextField: UITextField!
    @IBOutlet weak var lblErrorMsg: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
