//
//  MainViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/2/22.
//

import UIKit

class MainViewController:UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Step 1: Decide which View Controller to display next
//       launchNextViewController()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        launchNextViewController()
    }
    
    func launchNextViewController()
    {
        
        var userIsLoggedIn = true
        
        if userIsLoggedIn
        {
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//            self.navigationController?.pushViewController(newViewController, animated: true)
//
            
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeMenuViewController") as! HomeMenuViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            
            
            
            
            
        }
        else
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
}
    
}


