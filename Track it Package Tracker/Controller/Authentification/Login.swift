//
//  LoginViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/2/22.
//

//https://github.com/raulriera/TextFieldEffects

import UIKit
import Firebase
import TextFieldEffects

extension LoginViewController
{
   
}
//MARK: - Main Class
class LoginViewController:UIViewController
{
    var attmeptsToLogin = 0
    @IBOutlet weak var titleLabel: UILabel!
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
    
    
    @IBAction func signupButtonPressed(_ sender: Any)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
    }
}

//MARK: - LifeCycle Functions
extension LoginViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupVC() //Setup the View Controller
        self.dismissKeyboard()
        
        animateTitle()
        
    }
    
    func animateTitle()
    {
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = StringLiteral.appName
        for letter in titleText
        {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)  //Hides the back button before the view appears.
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true) //Unhides the naviagtion contoller
    }
    
    func setupVC()
    {
        setupTextFieldDelgate()
        setupSignInWithAppleButton()
    }
}





//MARK: - UITextField
extension LoginViewController: UITextFieldDelegate
{
    func setupTextFieldDelgate()
    {
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        switch textField
        {
           case self.emailTextField:
               self.passwordTextField.becomeFirstResponder()
           default:
            self.view.endEditing(true)
            LoginUser()
            
           }
            return false
        }
}




