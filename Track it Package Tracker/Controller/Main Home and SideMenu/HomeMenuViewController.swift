
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


        registerTableViewCells()
        registerNotificationCenter()
        updateUI()
      
        
        
   
        let timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
        
    
        
    
        
        
        
       
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //setup animation view
        animationView.loopMode = .loop
        animationView.play()
        animationView.backgroundColor = .clear
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //setup animation view
        animationView.loopMode = .loop
        animationView.play()
        animationView.backgroundColor = .clear
        
    }
    
   
    @objc func fireTimer() {
        print("TODO:- Do something firetimer")
    }
    
}

//MARK: - Main Class
class HomeMenuViewController: UIViewController
{
    
    @IBOutlet weak var tabBarViwController: UITabBar!
    @IBOutlet weak var animationView: AnimationView!
    var packages = [PackageObject]()//Pacakge Object Array
   
    
    
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
   
    
    @IBOutlet weak var packagesTableView: UITableView!
    
    
    //Side Menu Outlets
    

   
    
    
    
    @IBAction func showHamburgerMenu(_ sender: UIBarButtonItem)
    {
       
       
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addBarcodeViewController = storyBoard.instantiateViewController(withIdentifier: "AddTrakingNumberViewController") as! AddTrakingNumberViewController
        addBarcodeViewController.modalPresentationStyle = .currentContext
        addBarcodeViewController.launchBarcodeViewController = true
        navigationController?.pushViewController(addBarcodeViewController, animated: true)
    }
    
    
    
    
    @IBAction func purchaseApp(_ sender: Any)
    {
    }

}

//MARK: - Table View Controller Functions
extension HomeMenuViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return packages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
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
        
       

        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 110
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let aPackage: PackageObject = packages[indexPath.row]
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let packageView = storyBoard.instantiateViewController(withIdentifier: "PackageViewController") as! PackageViewController
        
        
        packageView.passedPackage = aPackage
        packageView.modalPresentationStyle = .fullScreen
        packageView.modalTransitionStyle = .crossDissolve
        tableView.deselectRow(at: indexPath, animated: true)
        packageView.modalPresentationStyle = .popover
        navigationController?.pushViewController(packageView, animated: true)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
      
        
        if editingStyle == .delete
        {
            CoreDataManager.sharedManager.delete(person: packages[indexPath.row])
        }
        
       
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
