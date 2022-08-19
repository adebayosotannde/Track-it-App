//
//  SideMenuOptions.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/6/22.
//

import Foundation


var options: [option] = [option(title: "Account and Settings", segue: "HomeSegue"),
                         option(title: "Delivered Packages",segue: "SettingsSegue"),
                         option(title: "Donations",segue: "SettingsSegue"),
                         option(title: "Feedback and Support",segue: "SettingsSegue"),
                         option(title: "Logout",segue: "SettingsSegue"),
                         
]

struct option
{
    var title = String()
    var segue = String()
}
