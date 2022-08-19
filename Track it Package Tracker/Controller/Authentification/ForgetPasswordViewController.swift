//
//  SignupViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/3/22.
//

import UIKit

//MARK: - LifeCycle Functions
extension ForgetPasswordViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func exitButtonPressed(_ sender: Any)
    {
        navigationController?.popViewController(animated: true)
    }
}
class ForgetPasswordViewController: UIViewController
{
    @IBOutlet weak var emailTextField: UITextField!
}
