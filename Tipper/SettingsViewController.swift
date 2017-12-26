//
//  SettingsViewController.swift
//  Tipper
//
//  Created by Siddharth Gupta on 12/25/17.
//  Copyright © 2017 Prachi Gupta. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipSegment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tipChange(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.set(tipSegment.selectedSegmentIndex, forKey: "segment")
        defaults.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        let defaults = UserDefaults.standard
        let segment = defaults.integer(forKey: "segment")
        tipSegment.selectedSegmentIndex = segment
        tipSegment.sendActions(for: UIControlEvents.valueChanged)
    }
    
    
    

}
