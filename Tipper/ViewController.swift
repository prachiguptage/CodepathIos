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
    @IBOutlet weak var outputView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipControl.alpha = 0
        outputView.alpha = 0
        billField.frame = billField.frame.offsetBy(dx: 0.0, dy: 150.0)
        outputView.frame = outputView.frame.offsetBy(dx: 0.0, dy: 300.0)
        tipControl.frame = tipControl.frame.offsetBy(dx: 0.0, dy: 300.0)
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
        if(bill>0){
            if(tipControl.alpha == 0){
                UIView.animate(withDuration: 0.7, animations: {
                    self.tipControl.alpha = 1
                    self.outputView.alpha = 1
                    
                    self.outputView.frame = self.outputView.frame.offsetBy(dx: 0.0, dy: -300.0)
                    self.tipControl.frame = self.tipControl.frame.offsetBy(dx: 0.0, dy: -300.0)
                    self.billField.frame = self.billField.frame.offsetBy(dx: 0.0, dy: -150.0)
                })
                
            }
            
        }else{
            if(tipControl.alpha == 1){
                UIView.animate(withDuration: 0.7, animations: {
                    self.tipControl.alpha = 0
                    self.outputView.alpha = 0
                    self.outputView.frame = self.outputView.frame.offsetBy(dx: 0.0, dy: 300.0)
                    self.tipControl.frame = self.tipControl.frame.offsetBy(dx: 0.0, dy: 300.0)
                    self.billField.frame = self.billField.frame.offsetBy(dx: 0.0, dy: 150.0)
                })
                
                
            }
        }
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "%@", currencyFormatter(num: tip))
        totalLabel.text = String(format: "%@", currencyFormatter(num: total))
        
        let date:Double = NSDate().timeIntervalSince1970
        let defaults = UserDefaults.standard
        defaults.set(bill, forKey: "bill")
        defaults.set(date, forKey: "date")
        defaults.synchronize()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated);
        
         billField.placeholder = localeSpecificCurrencySymbol()
        
        let defaults = UserDefaults.standard
        if NSDate().timeIntervalSince1970 < (defaults.double(forKey: "date") + 10*60){
            if defaults.double(forKey: "bill")>0 {
                billField.text = String(defaults.double(forKey: "bill"))
            }
        }
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

