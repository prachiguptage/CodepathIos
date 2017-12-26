//
//  ViewController.swift
//  Tipper
//
//  Created by Siddharth Gupta on 12/25/17.
//  Copyright © 2017 Prachi Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func calculateTip(_ sender: Any) {
        
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "%@", currencyFormatter(num: tip))
        totalLabel.text = String(format: "%@", currencyFormatter(num: total))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated);
        
         billField.placeholder = localeSpecificCurrencySymbol()
        
        let defaults = UserDefaults.standard
        let segment = defaults.integer(forKey: "segment")
        tipControl.selectedSegmentIndex = segment
        tipControl.sendActions(for: UIControlEvents.valueChanged)
        
        billField.becomeFirstResponder();
    }
    
    func currencyFormatter(num : Double)-> String{
        
        let number = NSDecimalNumber(decimal: Decimal(num))
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        
        let result = numberFormatter.string(from: number)
        return result!
    }
    
    func localeSpecificCurrencySymbol() -> String{
        let locale = Locale.current
        let currencySymbol = locale.currencySymbol!
        return currencySymbol
    }
    
    
    
}

