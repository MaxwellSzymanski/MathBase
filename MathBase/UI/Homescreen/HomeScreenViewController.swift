//
//  ViewController.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 09/01/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import UIKit
import iosMath

class HomeScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private let reuseIdentifier = "subjectCell"
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate   = self
        collectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Subjects.subjects.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SubjectCollectionViewCell
        cell.subjectTitle.text     = Subjects.subjects[indexPath.row].title
        cell.backgroundColor       = Subjects.subjects[indexPath.row].color
        cell.layer.cornerRadius    = 10
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth  = 1.0
        cell.contentView.layer.borderColor  = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 3.0
        cell.layer.shadowOpacity = 0.7
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "subjectSegue", sender: Subjects.subjects[indexPath.item])
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        let destinationVC: ActionViewController = segue.destination as! ActionViewController
        let selectedSubject = (sender as! Subject)
        destinationVC.subject = selectedSubject
        
     }
    


}

