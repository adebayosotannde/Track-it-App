//
//  HomeMenuViewController Side Menu .swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 9/7/22.
//

import Foundation
import Firebase
import UIKit

extension HomeMenuViewController
{
    func setupSideMenu()
    {
        //UIVIEW
  
       
//        updateAccountButton()
//        if Auth.auth().currentUser != nil
//        {
//            accountStatusButton.setTitle("Sign Out", for: .normal)
//        } else
//        {
//           //User Not logged in
//            accountStatusButton.setTitle("Log in / Sign up", for: .normal)
//
//        }
       
        
        
//
//        updateWelcomeText()
//        if Auth.auth().currentUser != nil
//        {
//            welcomeTExt.text = Auth.auth().currentUser?.email?.description
//
//        } else
//        {
//           //User Not logged in
//            welcomeTExt.text = "Welcome"
//
//        }
        //currentVersion.setTitle("v "  + "\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)", for: .normal) //Gets the current version
        
       
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
