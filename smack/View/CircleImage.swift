//
//  CircleImage.swift
//  smack
//
//  Created by Azim Jiwani on 2020-04-07.
//  Copyright © 2020 Azim Jiwani. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView () {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
}
