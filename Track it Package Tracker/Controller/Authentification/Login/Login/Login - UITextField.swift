//
//  Login - UITextField.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 9/7/22.
//

import Foundation
import UIKit

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
