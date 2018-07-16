//
//  CloseButton.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 24/02/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import UIKit

class CloseButton: UIButton {

    var segueIdentifier: String = ""
    
    override func awakeFromNib() {
        frame.size         = CGSize(width: 20, height: 20)
        layer.cornerRadius = frame.height / 2
        backgroundColor    = UIColor.lightGray
    }
    

}
