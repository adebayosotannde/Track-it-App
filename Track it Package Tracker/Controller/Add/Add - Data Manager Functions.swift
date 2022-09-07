//
//  Add - Data Manager Functions.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/23/22.
//

import Foundation
import UIKit

extension AddTrakingNumberViewController
{
    func addParcel()
    {
        //Checking if Tracking Number Exist Already
        let pacakgeExist = checkForDuplicaterTrackingNumber(trackingNumber: trackingNumberLabel.text!)

        if pacakgeExist
        {
           //duplicatePackgeError()
        }
        else
        {

            createNewPackageObject()
            dismissViewController()
        }

    }
    
    func checkForDuplicaterTrackingNumber(trackingNumber: String) -> Bool
    {
        pacakges = CoreDataManager.sharedManager.loadTrackingNumber()

        for pacakge in pacakges
        {
            if (pacakge.trackingNumber!.description == trackingNumber)
            {
                
                return true
            }
        }
        return false
    }
    
    func duplicatePackgeError()
    {
        //Do Nothing. Inform the User that the package already exists.

        //Alert View Controller
        let alert = UIAlertController(title: "Duplicate Pacakge", message: "Pacakge exists already in the system. You cannot add it again.", preferredStyle: UIAlertController.Style.alert)

        //Alert Action
        alert.addAction(UIAlertAction(title: "Got it!", style: .destructive, handler:
        { UIAlertAction in
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }))


       self.present(alert, animated: true, completion: nil)//Displays the Alert Box
    }
    
    func createNewPackageObject()
    {
        let newPackage = PackageObject(context: context)

        //Set Package properties
        newPackage.trackingNumber = trackingNumberLabel.text!
        newPackage.descriptionOfPackage = packageDescriptionLabel.text
        newPackage.packageCarrierCode = carrierCode
        newPackage.carrierName = carrierName
        
        newPackage.circleIndicatorColor = StringLiteral.redColor
        newPackage.currentDescription =  StringLiteral.defaultDescription
        
        
        CoreDataManager.sharedManager.save()//Cause the
        NetWorkManager.sharedManager.requestData(packageDetail: newPackage)
    }
    
    func dismissViewController()
    {
        navigationController?.popViewController(animated: true) // Pop Current View Controller from Nav Controller.
    }
}
