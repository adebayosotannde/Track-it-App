//
//  MainViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/2/22.
//

import UIKit
import Firebase

class MainViewController:UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Step 1: Decide which View Controller to display next
      viewControllerToLaunch()
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
      
    }
    
 
    
    func viewControllerToLaunch()
    
        {
            //Sign User Out if User is Currently Logged in
                    if Auth.auth().currentUser != nil
                    {
                        
                         
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeMenuViewController") as! HomeMenuViewController
                        newViewController.modalPresentationStyle = .fullScreen
                        navigationController?.pushViewController(newViewController, animated: true)
             
                       
                    
                        
                    }
            else
            {
                
                
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(newViewController, animated: true)
            }
            
        
          

             
            
            
    }
    
    
}


