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

