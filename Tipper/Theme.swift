//
//  Theme.swift
//  Tipper
//
//  Created by Siddharth Gupta on 12/26/17.
//  Copyright © 2017 Prachi Gupta. All rights reserved.
//

import UIKit

enum Theme: Int {

    case light
    case dark
    
    
    private enum Keys {
        static let selectedTheme = "SelectedTheme"
    }
    

    static var current: Theme {
        let storedTheme = UserDefaults.standard.integer(forKey: Keys.selectedTheme)
        return Theme(rawValue: storedTheme) ?? .light
        
    }
    
    var mainColor: UIColor {
        switch self {
        case .light:
            return UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        case .dark:
            return UIColor(red: 255.0/255.0, green: 115.0/255.0, blue: 50.0/255.0, alpha: 1.0)
        }
    }
    
    func apply() {
        
        UserDefaults.standard.set(rawValue, forKey: Keys.selectedTheme)
        UserDefaults.standard.synchronize()
        
        UIApplication.shared.delegate?.window??.tintColor = mainColor
        UINavigationBar.appearance().barStyle = barStyle
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")
    }
    
    var barStyle: UIBarStyle {
       
        switch self {
        case .light:
            return .default
        case .dark:
            return .black
        }
        
    }
    
    
        
    
    
    
    

}
