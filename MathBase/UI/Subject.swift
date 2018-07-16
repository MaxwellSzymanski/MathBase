//
//  Subject.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 23/02/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import UIKit

class Subject {
    let title:   String
    let color:   UIColor
    let actions: [Action]
    
    init(title: String, color: UIColor, actions: [Action]) {
        self.title   = title
        self.color   = color
        self.actions = actions
    }
}


