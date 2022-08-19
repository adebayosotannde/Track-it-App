//
//  PackageViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/11/22.
//

import UIKit

class PackageViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem)
    {
        navigationController?.popViewController(animated: true)
        print("Hello")
    }
    
}
