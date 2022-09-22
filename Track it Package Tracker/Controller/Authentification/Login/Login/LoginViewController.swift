//
//  LoginViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/2/22.
//

import UIKit
import Firebase




//MARK: - LifeCycle Functions

class LoginViewController:UIViewController
{
    var attmeptsToLogin = 0
    var currentNonce:String? //Used for Apple Sign in
    @IBOutlet weak var appleSignon: UIStackView!
    
    //UITextFields
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    @IBAction func signInButtonPressed(_ sender: UIButton)
    {
        LoginUser()
    }
    
    @IBAction func signInGoogle(_ sender: UIButton)
    {
        initiateGoogleSignOn()
    }
}







