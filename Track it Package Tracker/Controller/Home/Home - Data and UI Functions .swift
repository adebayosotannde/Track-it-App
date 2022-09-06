//
//  HomeMenuViewControllerCoreData.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/23/22.
//

import Foundation
import CoreData
import UIKit

extension HomeMenuViewController
{
    public func updateUI()
    {
        packages = CoreDataManager.sharedManager.loadTrackingNumber() //Retrive Package Objects Array
        self.packagesTableView.reloadData()
        hideTableViewIfThereAreNoPackages()
        
    }
    
    //Hides the Table View If there are no Packages in the Container.
    func hideTableViewIfThereAreNoPackages()
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
    func registerTableViewCells()
    {
        let menuNib = UINib(nibName: SideMenuTableViewCell.classIdentifier,bundle: nil)
        self.menuTableView.register(menuNib,forCellReuseIdentifier: SideMenuTableViewCell.cellIdentifier)
        
        
        //RegisterTableViewCells
        let textFieldCell = UINib(nibName: PackageTableViewCell.classIdentifier,bundle: nil)
        self.packagesTableView.register(textFieldCell,forCellReuseIdentifier: PackageTableViewCell.cellIdentifier)
        
        
    }
    
    func addPackageObject(newObject: PackageObject)
    {
        CoreDataManager.sharedManager.insertPackageObject(newObject: newObject) //Add Object to Core Data
    }
    
    func deletePackageObject(deleteObject: PackageObject)
    {
       
        CoreDataManager.sharedManager.delete(person: deleteObject) //Delete Package Object from Core Data
    }
    

    func refreshDataForAllPackages()
    {
        CoreDataManager.sharedManager.fetchDataForAllPackages()
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
