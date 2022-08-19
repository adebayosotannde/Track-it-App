//
//  SideMenuViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/6/22.
//

import UIKit

extension HomeMenuViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
     
       
        
      
        menuTableView.backgroundColor = .clear
      
       
        
      
        
        
        let menuNib = UINib(nibName: SideMenuTableViewCell.classIdentifier,bundle: nil)
        self.menuTableView.register(menuNib,forCellReuseIdentifier: SideMenuTableViewCell.cellIdentifier)
        
        
        //RegisterTableViewCells
        let textFieldCell = UINib(nibName: PackageTableViewCell.classIdentifier,bundle: nil)
        self.packagesTableView.register(textFieldCell,forCellReuseIdentifier: PackageTableViewCell.cellIdentifier)
        
        
        
        home = self.containerView.transform
    
    }
    
}


class HomeMenuViewController: UIViewController
{
    @IBOutlet var containerView: UIView!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    @IBOutlet var menuTableView: UITableView!
    
    @IBOutlet weak var packagesTableView: UITableView!
    //Variable used for the Side Menu
    let screen = UIScreen.main.bounds
    var menu = false
    var home = CGAffineTransform()
    
    

    @IBOutlet weak var hamburgerMenuItem: UIBarButtonItem!
    
    @IBAction func showHamburgerMenu(_ sender: UIBarButtonItem)
    {
       
        showMenu()
       
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addBarcodeViewController = storyBoard.instantiateViewController(withIdentifier: "AddTrakingNumberViewController") as! AddTrakingNumberViewController
        addBarcodeViewController.modalPresentationStyle = .currentContext
        addBarcodeViewController.launchBarcodeViewController = true
        navigationController?.pushViewController(addBarcodeViewController, animated: true)
    }
    
    
    @IBAction func showMenu(_ sender: UISwipeGestureRecognizer) {
        
        print("menu interaction")
        
        print(swipeGesture.direction)
        print(menu)
        if menu == false && swipeGesture.direction == .right
        {
        showMenu()
        }
        
    }
    
    
    @IBAction func hideMenu(_ sender: Any)
    {
        
        if menu == true
        {
        hideMenu()
        }
        
        
    }
}

extension HomeMenuViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch tableView
        {
        case menuTableView:
            return options.count
        case packagesTableView:
            return options.count
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        switch tableView
        {
        case menuTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.cellIdentifier, for: indexPath) as! SideMenuTableViewCell
            cell.descriptionLabel.text = options[indexPath.row].title
            cell.descriptionLabel.textColor = .black
            return cell
        case packagesTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: PackageTableViewCell.cellIdentifier, for: indexPath) as! PackageTableViewCell
            cell.selectionStyle = .none
            return cell
        default:
            fatalError()
        }
        
       

        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch tableView
        {
        case menuTableView:
            return 45
        case packagesTableView:
            return 110
        default:
            fatalError()
        }
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        switch tableView
        {
        case menuTableView:
            print("Menu Table View Tapped")
        case packagesTableView:
            print("Package Table View Tapped")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let packageView = storyBoard.instantiateViewController(withIdentifier: "PackageViewController") as! PackageViewController
            navigationController?.pushViewController(packageView, animated: true)
            
        default:
            fatalError()
        }
        
        
    }
   
    
    
    
}



extension HomeMenuViewController
{
    
    func showMenu()
    {
        self.containerView.layer.cornerRadius = 40

        let x = screen.width * 0.5
        let originalTransform = self.containerView.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.8, y: 0.8)
            let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: 0)
            UIView.animate(withDuration: 0.7, animations:
                            {
                self.containerView.transform = scaledAndTranslatedTransform
                
            })
        
        menu = true
        
        
        //DIABLES THE HAMBURGERMENU
        hamburgerMenuItem.isEnabled = false
        
        
    }
    
    func hideMenu()
    {
        
            UIView.animate(withDuration: 0.7, animations:
                            {
                
                self.containerView.transform = self.home
                self.containerView.layer.cornerRadius = 0
              
                
            })
        
        menu = false
        //RE-ENABLES THE HAMBURGERMENU
        hamburgerMenuItem.isEnabled = true
        
    }
    
    
}
