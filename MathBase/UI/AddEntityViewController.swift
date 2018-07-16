//
//  AddEntityViewController.swift
//  MathBase
//
//  Created by Maxwell Szymanski on 07/04/2018.
//  Copyright © 2018 Maxwell Szymanski. All rights reserved.
//

import UIKit
import iosMath

class AddEntityViewController: UIViewController {

    @IBOutlet weak var scroller: UIScrollView!
    var values: [UITextField] = []
    var powers: [UITextField] = []
    var entity: Polynomial    = Polynomial([0])
    var output = MTMathUILabel(frame: CGRect(x: 30, y: 250, width: 400, height: 100))
    @IBOutlet weak var AddView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scroller.isScrollEnabled = true
        /*
        let fname = MTMathUILabel(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        for i in 0 ..< 3 {
            let textview = UITextField(frame: CGRect(x: 110 + 80 * i, y: 47, width: 40, height: 50))
            textview.placeholder = "0"
            textview.borderStyle = .roundedRect
            textview.keyboardType = UIKeyboardType.decimalPad
            textview.font = .systemFont(ofSize: 30)
            AddView.addSubview(textview)
            values.append(textview)
            
            let xlabel: UITextView = UITextView(frame: CGRect(x: 150 + 80 * i, y: 47, width: 60, height: 50))
            if i == 2 {xlabel.text = "x"}
            else {xlabel.text = "x +"}
            xlabel.font = UIFont.systemFont(ofSize: 30.0)
            xlabel.isEditable = false
            xlabel.isUserInteractionEnabled = false
            AddView.addSubview(xlabel)
            
            let power: UITextField = UITextField(frame: CGRect(x: 170 + 80 * i, y: 40, width: 30, height: 30))
            power.placeholder = "0"
            if i == 2 {power.addTarget(self, action: #selector(AddEntityViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)}
            power.keyboardType = UIKeyboardType.decimalPad
            power.font = .systemFont(ofSize: 20)
            AddView.addSubview(power)
            powers.append(power)
        }
        fname.latex = "f(x) = "
        AddView.addSubview(fname)
        self.view.addSubview(output)
 */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Action
    
    @IBAction func addEntity(_ sender: Any) {
        var polynomial = Array<Int>(repeating: 0, count: values.count)
        print("values: \(values.count)")
        print("powers: \(values.count)")
        for i in 0 ..< values.count {
            if powers[i].text == "" {
                print("true: \(i)")
                if values[i].text == "" {continue}
                polynomial[0] += Int(values[i].text!)!
                continue
            }
            print("index:\(i)")
            let index: Int = Int(powers[i].text!)!
            polynomial[index] += Int(values[i].text!)!
        }
        entity = Polynomial(polynomial)
        output.latex = entity.description
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        values[values.count-1].removeTarget(self, action: #selector(AddEntityViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        let textview = UITextField(frame: CGRect(x: values[values.count-1].frame.origin.x + 50, y: 47, width: 40, height: 50))
        textview.placeholder = "0"
        textview.borderStyle = .roundedRect
        textview.keyboardType = UIKeyboardType.decimalPad
        textview.font = .systemFont(ofSize: 30)
        AddView.addSubview(textview)
        values.append(textview)
        
        let xlabel: UITextView = UITextView(frame: CGRect(x: powers[powers.count-1].frame.origin.x + 50, y: 47, width: 60, height: 50))
        xlabel.text = "x"
        xlabel.font = UIFont.systemFont(ofSize: 30.0)
        xlabel.isEditable = false
        xlabel.isUserInteractionEnabled = false
        AddView.addSubview(xlabel)
        
        let power: UITextField = UITextField(frame: CGRect(x: powers[powers.count-1].frame.origin.x + 50, y: 40, width: 30, height: 30))
        power.placeholder = "0"
        power.addTarget(self, action: #selector(AddEntityViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        power.keyboardType = UIKeyboardType.decimalPad
        power.font = .systemFont(ofSize: 20)
        AddView.addSubview(power)
        powers.append(power)
        AddView.frame.size.width += 100
        AddView.layoutIfNeeded()
    }
    
}
