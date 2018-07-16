//
//  SubjectCollectionViewCell.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 23/02/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import UIKit

class SubjectCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var subjectTitle: UILabel!
    
    func viewDidLoad() {
        self.contentView.layer.cornerRadius = 2.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
