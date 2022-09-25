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
    
    //IBOutlets and Actions
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var packagesTableView: UITableView!
    
    let delivered = CoreDataManager.sharedManager.getActivePackagesInOrder() //Delivered Packages
   

    override func viewDidLoad()
    {
        super.viewDidLoad()
        registerTableViewCells() //Register the notification center
        updateUI() //Updates the User interface
    
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        startAnimationView() //Start the animation
    }
    
    
    //MARK: - Setup Functions
    fileprivate func startAnimationView()
    {
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
        self.packagesTableView.reloadData()
        hideTableViewIfThereAreNoPackages()
    }
    
    func hideTableViewIfThereAreNoPackages()
    {
        if(delivered.count == 0 )
          {
              packagesTableView.isHidden = true
            
          }
            else
            {
               
                    self.packagesTableView.isHidden = false
              
            }
    }
    
    func getColorFromString(nameAsString: String)-> UIColor
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


//MARK: -  UITable View Controller Delgate Functions.
extension ArchivedPackagesViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        delivered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: PackageTableViewCell.cellIdentifier, for: indexPath) as! PackageTableViewCell
        //A Package object is decleared.
        
        let tempPackage: PackageObject = delivered[indexPath.row]
        cell.carrierNameAndTracking.text = tempPackage.carrierName! + ": " + tempPackage.trackingNumber!
        cell.packageDescription.text = tempPackage.descriptionOfPackage
        cell.logoImage.image = UIImage(named: tempPackage.packageCarrierCode!)
        cell.packageCurrentDescription.text = tempPackage.currentDescription! //Good
        cell.circleIndicator.tintColor =  getColorFromString(nameAsString: tempPackage.circleIndicatorColor!)
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    
}


//MARK: -  UITable View Controller DataSource Functions.
extension ArchivedPackagesViewController:  UITableViewDelegate
{
    //Height Specified for the packages
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 110
    }
}
