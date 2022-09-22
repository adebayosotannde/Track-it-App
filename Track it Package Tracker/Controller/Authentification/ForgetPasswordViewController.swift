//
//  SignupViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/3/22.
//

import UIKit
import FirebaseAuth

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
    
    @IBOutlet weak var emailValidationTextbox: UILabel!
    @IBAction func resetButtonPressed(_ sender: Any)
    {
        if isValidEmailAddress(emailAddressString: emailTextField.text!)
        {
            if let email =  emailTextField.text
            {
                Auth.auth().sendPasswordReset(withEmail: email)
                emailValidationTextbox.isHidden = true
                
                displayAlert()
                
                
            }
            
        }
        else
        {
            emailValidationTextbox.isHidden = false
        }
       
    }
    
    private func displayAlert()
    {
        let alert = UIAlertController(title: "Reset Link Sent", message: "An email link haas been sent to your email.", preferredStyle: UIAlertController.Style.alert)

        //Alert Action
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler:
        { UIAlertAction in
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }))

        self.present(alert, animated: true, completion: nil)//Displays the Alert Box
    }
    func isValidEmailAddress(emailAddressString: String) -> Bool {
      
      var returnValue = true
      let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
      
      do {
          let regex = try NSRegularExpression(pattern: emailRegEx)
          let nsString = emailAddressString as NSString
          let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
          
          if results.count == 0
          {
              returnValue = false
          }
          
      } catch let error as NSError {
          print("invalid regex: \(error.localizedDescription)")
          returnValue = false
      }
      
      return  returnValue
  }
    
}
