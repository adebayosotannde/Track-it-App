
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
    //MARK: - LifeCycle Functions
    override func viewDidLoad()
    {
        super.viewDidLoad()
        registerTableViewCells() //Register table view cells
        registerNotificationCenter() //Register the notification center
        updateUI() //Update the user interface
        
        let timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
 
    }
    
  
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        animateTheAnimationView()
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        //setup animation view
        animateTheAnimationView()
    }
    
    //MARK: - Setup Functions
    @objc func fireTimer()
    {
        print("TODO:- Do something firetimer")
    }
    
    
    fileprivate func animateTheAnimationView()
    {
        //setup animation view
        animationView.loopMode = .loop
        animationView.play()
        animationView.backgroundColor = .clear
    }
    
    private func updateUI()
    {
        //Reveres the context
        packages = CoreDataManager.sharedManager.getActivePackagesInOrder()//Retrive Package Objects Array
        self.packagesTableView.reloadData()
        hideTableViewIfThereAreNoPackages()
    }
    
    //Hides the Table View If there are no Packages in the Container.
    private func hideTableViewIfThereAreNoPackages()
    {
        if(packages.count == 0 )
          {
              packagesTableView.isHidden = true
            
          }
            else
            {

                    self.packagesTableView.isHidden = false
              
            }
    }
    
    //Registers the PackageViewCells
    private func registerTableViewCells()
    {
        //RegisterTableViewCells
        let textFieldCell = UINib(nibName: PackageTableViewCell.classIdentifier,bundle: nil)
        self.packagesTableView.register(textFieldCell,forCellReuseIdentifier: PackageTableViewCell.cellIdentifier)

    }

    
    private func deletePackageObject(deleteObject: PackageObject)
    {
       
        CoreDataManager.sharedManager.delete(person: deleteObject) //Delete Package Object from Core Data
    }
    

    private func refreshDataForAllPackages()
    {
        CoreDataManager.sharedManager.fetchDataForAllPackages()
    }
    
    private func getColorFromString(nameAsString: String)-> UIColor
    {
        switch nameAsString.lowercased()
        {
        case "green":
            return .systemGreen
        case "yellow":
            return .systemYellow
        default:
            return .systemRed
        }
    }
}

//MARK: - Main Class
class HomeMenuViewController: UIViewController
{
    
    var packages:[PackageObject] = [] //Package Object.
    
    
    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var packagesTableView: UITableView!
    
 
    
    @IBAction func cameraButtonPressed(_ sender: Any)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addBarcodeViewController = storyBoard.instantiateViewController(withIdentifier: "AddTrakingNumberViewController") as! AddTrakingNumberViewController
        addBarcodeViewController.modalPresentationStyle = .formSheet
        addBarcodeViewController.launchBarcodeViewController = true
        navigationController?.pushViewController(addBarcodeViewController, animated: true)
    }
    
    @IBAction func menuButtonPressed(_ sender: Any)
    {
        
        
    }
    
}

//MARK: - Table View Datasource Controller Functions
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
    private func registerNotificationCenter()
    {
    //Obsereves the Notification
    NotificationCenter.default.addObserver(self, selector: #selector(doWhenNotified(_:)), name: Notification.Name(StringLiteral.notificationKey), object: nil)
    }
    
    private func postBarcodeNotification(code: String)
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
