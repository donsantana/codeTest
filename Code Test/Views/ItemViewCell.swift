//
//  PhoneNumberCell.swift
//  Code Test
//
//  Created by Donelkys Santana on 12/18/18.
//  Copyright © 2018 Donelkys Santana. All rights reserved.
//

import Foundation
import UIKit

class ItemViewCell: UITableViewCell {

    @IBOutlet weak var itemText: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
