//
//  DynamicCell.swift
//  DynamicTableCell
//
//  Created by Shridhar Mali on 3/8/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class DynamicCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setContent(_ text: String){
        
        self.titleLbl.text = text
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
