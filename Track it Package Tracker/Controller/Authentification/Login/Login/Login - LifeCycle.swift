//
//  Login - LifeCycle.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 9/7/22.
//

import Foundation

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

