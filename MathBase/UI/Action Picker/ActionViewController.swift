//
//  ActionViewController.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 24/02/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let reuseIdentifier = "actionCell"
    var subject: Subject = Subjects.polynomial
    @IBOutlet weak var actionTitle: UILabel!
    @IBOutlet weak var addItem: AddItemUIButton!
    @IBOutlet weak var actionCollectionView: UICollectionView!
    @IBOutlet weak var closeButton: CloseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addItem.setTitle("Add \(subject.title.lowercased())", for: .normal)
        actionTitle.text           = subject.title
        addItem.layer.cornerRadius = 10
        addItem.backgroundColor    = subject.color
        actionCollectionView.delegate = self
        actionCollectionView.dataSource = self
        closeButton.setNeedsDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CollectionViewDataSource
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subject.actions.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ActionCollectionViewCell
        cell.titleLabel.text       = subject.actions[indexPath.item].actionTitle
        cell.descriptionLabel.text = subject.actions[indexPath.item].description
        cell.layer.cornerRadius    = 7
        cell.titleLabel.backgroundColor = subject.color
        cell.frame.size = CGSize(width: cell.frame.width, height: CGFloat(65 + 20 * cell.descriptionLabel.numberOfVisibleLines))
        //cell.frame.size = CGSize(width: cell.frame.width, height: CGFloat(subject.actions[indexPath.item].description.count * 2))
        
        cell.contentView.layer.cornerRadius  = 10
        cell.contentView.layer.borderWidth   = 1.0
        cell.contentView.layer.borderColor   = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor   = UIColor.gray.cgColor
        cell.layer.shadowOffset  = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius  = 3.0
        cell.layer.shadowOpacity = 0.7
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        //cell.bounds = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
        return cell
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

/*
extension ActionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.cellForItem(at: indexPath) as! ActionCollectionViewCell
        print(cell)
        cell.descriptionLabel.text = subject.actions[indexPath.item].description
        let width = collectionView.frame.width / 2 - 25
        return CGSize(width: width, height: CGFloat(65 + 20 * cell.descriptionLabel.numberOfVisibleLines))
        
    }
}
 */

extension UILabel {
    var numberOfVisibleLines: Int {
        let textSize = CGSize(width: CGFloat(self.frame.size.width), height: CGFloat(MAXFLOAT))
        let rHeight: Int = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize: Int = lroundf(Float(self.font.pointSize))
        return rHeight / charSize
    }
}
