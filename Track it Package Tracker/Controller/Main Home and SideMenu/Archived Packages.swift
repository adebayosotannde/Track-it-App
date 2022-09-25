//
//  Archived Packages.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 9/24/22.
//

import UIKit
import Lottie
import CoreData


class ArchivedPackagesViewController: UIViewController
{
    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var packagesTableView: UITableView!
    
    var packages = [PackageObject]() //Pacakge Object Array
    let delivered = CoreDataManager.sharedManager.loadTrackingNumberRevered()
    var deliverePackages:[PackageObject] = []
    
    
    override func viewDidLoad()
    {
       
        
        super.viewDidLoad()
        print("in the view did load")
        //getDeliveredPackages()
        registerTableViewCells()
        updateUI()
        getDeliveredPackages()
        
       
        
        //Playing
        print("Origanl PackageObject \(packages.count)")
        print("Delivered PackageObject \(CoreDataManager.sharedManager.getAllDeliveredPackages().count)")
    
        
    }
    
     
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startAnimationView() //Start the animation
    }
    
    
    //MARK: - Setup Functions 
    
    fileprivate func startAnimationView() {
        //Start the animations view
        animationView.loopMode = .loop
        animationView.backgroundColor = .clear
        animationView.play()
    }
    
    
    //Registers the PackageViewCells
    func registerTableViewCells()
    {
        
        //RegisterTableViewCells
        let textFieldCell = UINib(nibName: PackageTableViewCell.classIdentifier,bundle: nil)
        self.packagesTableView.register(textFieldCell,forCellReuseIdentifier: PackageTableViewCell.cellIdentifier)
        
        
    }
    
     func updateUI()
    {
        packages = CoreDataManager.sharedManager.loadTrackingNumberRevered() //Retrive Package Objects Array
        self.packagesTableView.reloadData()
        hideTableViewIfThereAreNoPackages()
        
    }
    
    func hideTableViewIfThereAreNoPackages()
    {
        if(deliverePackages.count == 0 )
          {
              packagesTableView.isHidden = true
            
          }
            else
            {
               
                    self.packagesTableView.isHidden = false
              
            }
    }
    
    func getDeliveredPackages()
    {
      
        for package in packages
        {
            if package.delivered == true
            {
                deliverePackages.append(package)
               
            }else
            {
               
            }
        }
        updateUI()
        
       
    }
}


//MARK: -  UITable View Controller Delgate Functions.
extension ArchivedPackagesViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        deliverePackages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: PackageTableViewCell.cellIdentifier, for: indexPath) as! PackageTableViewCell
        //A Package object is decleared.
        
        let tempPackage: PackageObject = deliverePackages[indexPath.row]
        cell.carrierNameAndTracking.text = tempPackage.carrierName! + ": " + tempPackage.trackingNumber!
        cell.packageDescription.text = tempPackage.descriptionOfPackage
        cell.logoImage.image = UIImage(named: tempPackage.packageCarrierCode!)
        cell.packageCurrentDescription.text = tempPackage.currentDescription! //Good
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    
}


extension ArchivedPackagesViewController:  UITableViewDelegate
{
    //Height Specified for the packages
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 110
    }
}
