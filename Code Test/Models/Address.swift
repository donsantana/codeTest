//
//  Address.swift
//  Code Test
//
//  Created by Donelkys Santana on 12/20/18.
//  Copyright © 2018 Donelkys Santana. All rights reserved.
//

import Foundation

struct Address {
    var address1Text: String!
    var address2Text: String!
    var cityText: String!
    var stateText: String!
    var zipText: String!
    var countryText: String!
    
    init(address1Text: String, address2Text: String, cityText: String, stateText: String, zipText: String, countryText: String) {
        self.address1Text = address1Text != "" ? address1Text : ""
        self.address2Text = address2Text != "" ? address2Text : ""
        self.cityText = cityText != "" ? cityText : ""
        self.stateText = stateText != "" ? stateText : ""
        self.zipText = zipText != "" ? zipText : ""
        self.countryText = countryText != "" ? countryText : ""
    }
}
