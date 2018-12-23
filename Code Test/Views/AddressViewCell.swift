//
//  AddressViewCell.swift
//  Code Test
//
//  Created by Donelkys Santana on 12/20/18.
//  Copyright © 2018 Donelkys Santana. All rights reserved.
//

import Foundation
import UIKit

class AddressViewCell: UITableViewCell {

    @IBOutlet weak var address1Text: UITextField!
    @IBOutlet weak var address2Text: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var stateText: UITextField!
    @IBOutlet weak var zipText: UITextField!
    @IBOutlet weak var countryText: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Adding bottom border to uitextfields
        self.address1Text.setBottomBorder(borderColor: UIColor.lightGray)
        self.address2Text.setBottomBorder(borderColor: UIColor.lightGray)
        self.cityText.setBottomBorder(borderColor: UIColor.lightGray)
        self.stateText.setBottomBorder(borderColor: UIColor.lightGray)
        self.zipText.setBottomBorder(borderColor: UIColor.lightGray)
        self.countryText.setBottomBorder(borderColor: UIColor.lightGray)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension UITextField {
    func setBottomBorder(borderColor: UIColor) {
        self.borderStyle = UITextField.BorderStyle.none
        self.backgroundColor = UIColor.clear
        let width = 1.0
        let borderLine = UIView()
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - width, width: Double(self.frame.width), height: width)
        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }
}
