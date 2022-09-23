//
//  SideMenuViewController.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/6/22.
//

import UIKit
import Lottie

extension HomeMenuViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        menuTableView.backgroundColor = .clear
        registerTableViewCells()
        home = self.containerView.transform
        updateUI()
    registerNotificationCenter()
        let timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
        
        //Setup for Side Menu
        setupSideMenu()
        
        
        
       
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //setup animation view
        animationView.loopMode = .loop
        animationView.play()
        animationView.backgroundColor = .clear
        
        
    }
    
   
    @objc func fireTimer() {
        print("Timer fired!")
    }
    
}

//MARK: - Main Class
class HomeMenuViewController: UIViewController
{
    
    @IBOutlet weak var animationView: AnimationView!
    var packages = [PackageObject]() //Pacakge Object Array
    
    
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    @IBOutlet var menuTableView: UITableView!
    
    @IBOutlet weak var packagesTableView: UITableView!
    //Variable used for the Side Menu
    let screen = UIScreen.main.bounds
    var menu = false
    var home = CGAffineTransform()
    
    //Side Menu Outlets
    @IBOutlet weak var currentVersion: UIButton!

    @IBOutlet weak var hamburgerMenuItem: UIBarButtonItem!
    @IBOutlet weak var accountStatusButton: UIButton!
    @IBOutlet weak var welcomeTExt: UILabel!
    
    
    
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
    
    @IBAction func purchaseApp(_ sender: Any)
    {
    }
    @IBAction func signonandLogoutPressed(_ sender: Any)
    {
        loginOrSignout()
    }
    
}

//MARK: - Table View Controller Functions
extension HomeMenuViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch tableView
        {
        case menuTableView:
            return options.count
        case packagesTableView:
            return packages.count
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
            cell.descriptionLabel.textColor = options[indexPath.row].colors
            return cell
        case packagesTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: PackageTableViewCell.cellIdentifier, for: indexPath) as! PackageTableViewCell
            //A Package object is decleared.
            
            let tempPackage: PackageObject = packages[indexPath.row]
            cell.carrierNameAndTracking.text = tempPackage.carrierName! + ": " + tempPackage.trackingNumber!
            cell.packageDescription.text = tempPackage.descriptionOfPackage
            cell.logoImage.image = UIImage(named: tempPackage.packageCarrierCode!)
            cell.packageCurrentDescription.text = tempPackage.currentDescription! //Good
            
            
            cell.circleIndicator.tintColor =  getColorFromString(nameAsString: tempPackage.circleIndicatorColor!)
            
            
            
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
        
        let aPackage: PackageObject = packages[indexPath.row]
        
        switch tableView
        {
        case menuTableView:
            print("Menu tableview tapped")
        case packagesTableView:
            
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let packageView = storyBoard.instantiateViewController(withIdentifier: "PackageViewController") as! PackageViewController
            
            
            packageView.passedPackage = aPackage
            packageView.modalPresentationStyle = .fullScreen
            packageView.modalTransitionStyle = .crossDissolve
            tableView.deselectRow(at: indexPath, animated: true)
            packageView.modalPresentationStyle = .popover
            navigationController?.pushViewController(packageView, animated: true)
            
        
            
        default:
            fatalError()
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
      
        
        if editingStyle == .delete
        {
            CoreDataManager.sharedManager.delete(person: packages[indexPath.row])
        }
        
       
    }
   
}


//MARK: - Side Menu Functions
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

//MARK: - Notification Canter
extension HomeMenuViewController
{
    func registerNotificationCenter()
    {
    //Obsereves the Notification
    NotificationCenter.default.addObserver(self, selector: #selector(doWhenNotified(_:)), name: Notification.Name(StringLiteral.notificationKey), object: nil)
    }
    
    func postBarcodeNotification(code: String)
    {
        var info = [String: String]()
        info[code.description] = code.description //post the notification with the key.
        NotificationCenter.default.post(name: Notification.Name(rawValue: StringLiteral.notificationKey), object: nil, userInfo: info)
    }
    
    @objc func doWhenNotified(_ notiofication: NSNotification)
    {
        if let dict = notiofication.userInfo as NSDictionary?
        {
            if (dict[StringLiteral.updateHomeViewData] as? String) != nil
            {
                updateUI()
            }
    
        
    
        }
    }
    
}
