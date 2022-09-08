//
//  SideMenuOptions.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/6/22.
//

import Foundation
import UIKit


var options: [option] = [option(title: "Login", segue: "HomeSegue", colors: .black),
                         option(title: "Sign up",segue: "SettingsSegue",colors: .black),
                         option(title: "Donations",segue: "SettingsSegue",colors: .black),
                         option(title: "Feedback and Support",segue: "SettingsSegue",colors: .black),
                         option(title: "Logout",segue: "SettingsSegue",colors: .blue),
                        
                         
]

struct option
{
    var title = String()
    var segue = String()
    var colors = UIColor()
}
