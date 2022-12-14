//
//  SideMenuVC.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 9/18/22.
//

import UIKit
import FirebaseAuth
import Firebase

class SideMenuViewController: UIViewController
{
    @IBOutlet weak var currentVersion: UIButton!
    
    
    @IBAction func currentVersionPressed(_ sender: Any)
    {
        WhatsNewPopupViewController.showPopup(parentVC: self)
    }
    @IBAction func deleteAccountButton(_ sender: Any)
    {
        
        let alert = UIAlertController(title: "Confirm", message: "You will need to create a new account. All data will be lost forever!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler:
        { UIAlertAction in
            
                    if Auth.auth().currentUser != nil
                    {
                    Auth.auth().currentUser?.delete()
            
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let addBarcodeViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
                       self.navigationController?.modalPresentationStyle = .popover
                       self.navigationController?.pushViewController(addBarcodeViewController, animated: true)
                    } else
                    {
                       print("failed")
            
            
                    }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:
        { UIAlertAction in
            
        }))
        
        
    
        
        self.present(alert, animated: true, completion: nil)//Displays the Alert Box
        
        
        
        
        
        
//        if Auth.auth().currentUser != nil
//        {
//        Auth.auth().currentUser?.delete()
//
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let addBarcodeViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//
//           self.navigationController?.modalPresentationStyle = .popover
//           self.navigationController?.pushViewController(addBarcodeViewController, animated: true)
//        } else
//        {
//           print("failed")
//
//
//        }
    }
    @IBOutlet weak var welcomeTExt: UILabel!
    @IBOutlet weak var accountStatusButton: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("Displaying the VC")
        currentVersion.setTitle("Version "  + "\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)", for: .normal) //Gets the current version
        updateWelcomeText()
        updateAccountButton()
    }
    
    @IBAction func signoutButton(_ sender: Any)
    {
        
      loginOrSignout()
    }
    
    
   


private func updateAccountButton()
        {
            if Auth.auth().currentUser != nil
            {
                accountStatusButton.setTitle("Sign Out", for: .normal)
                accountStatusButton.setTitleColor(.red, for: .normal)
            } else
            {
               //User Not logged in
                accountStatusButton.setTitle("Log in / Sign up", for: .normal)

            }
        }
        
       
    
    
    private func updateWelcomeText()
    {
        if Auth.auth().currentUser != nil
        {
            welcomeTExt.text = Auth.auth().currentUser?.email?.description
            print("Current User email is \(Auth.auth().currentUser?.email?.description)")
            
            //This is returned by apple. They hide users emails
            if Auth.auth().currentUser?.email?.description == nil
            {
//            welcomeTExt.text = "Apple User"
                welcomeTExt.text = Auth.auth().currentUser?.displayName
                
            }
    
    
    
    
        } else
        {
           //User Not logged in
            welcomeTExt.text = "Welcome"

        }
       
        
    }
    
  
    
    
    
    func loginOrSignout()
    {
        //Sign User Out if User is Currently Logged in
                if Auth.auth().currentUser != nil
                {
                    do
                       {
                           try Auth.auth().signOut()
                         //  hideSideMenu()
                               // your code here
                               let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                 let ViewController = storyBoard.instantiateViewController(withIdentifier: "HomeMenuViewController") as! HomeMenuViewController
        
                            
                               self.navigationController?.modalPresentationStyle = .popover
                               self.navigationController?.pushViewController(ViewController, animated: false)
                           
                       }
                       catch let error as NSError
                       {
                           print(error.localizedDescription)
                       }
                    
                    
                }
        
    
      

         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let addBarcodeViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController

            self.navigationController?.modalPresentationStyle = .popover
            self.navigationController?.pushViewController(addBarcodeViewController, animated: true)
        
        
        
        
}
    
    
    
    
}
