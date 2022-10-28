//
//  CoreDataManager.swift
//  PersistentTodoList
//
//  Created by Alok Upadhyay on 30/03/2018.
//  Copyright © 2017 Alok Upadhyay. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager
{
    
    var packages = [PackageObject]()  //Pacakge Object Array
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //Core Data Contect to Save Data
  

    static let sharedManager = CoreDataManager() //Create Instance of Persistance Contaner
  private init() {} // Prevent clients from creating another instance.
  
  

  lazy var persistentContainer: NSPersistentContainer =
{
    let container = NSPersistentContainer(name: "Track_It")
    container.loadPersistentStores(completionHandler:
    { (storeDescription, error) in
      
        if storeDescription == storeDescription
        {
          
  
            
        }
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  

    func getAllDeliveredPackagesInOrder() -> [PackageObject]
    {
        let request : NSFetchRequest<PackageObject> = PackageObject.fetchRequest()
        do
        {
            let array = try context.fetch(request)
            var duplicateArray = array
          
            duplicateArray.removeAll(where: {false == $0.delivered})


            return duplicateArray.reversed()
        }
        catch
        {
            print("Error Loading Context \(error)")
            return packages
        }
    }
    
    func getActivePackagesInOrder() -> [PackageObject]
    {
        let request : NSFetchRequest<PackageObject> = PackageObject.fetchRequest()
        do
        {
            let array = try context.fetch(request)
            var duplicateArray = array
          
            duplicateArray.removeAll(where: {true == $0.delivered})
            return duplicateArray.reversed()
        }
        catch
        {
            print("Error Loading Context \(error)")
            return packages
        }
    }
    

    func delete(person : PackageObject)
    {
      do
      {
        context.delete(person)
      }
      
      save()
        
    }
    
   
    
    func updateInvalidTrackingNumber(package: PackageObject)
    {
        do
        {
            package.isValidTrackingNumber = false
        }
        save()
    }
    
  
    
    func loadTrackingNumber() -> [PackageObject]
    {
        let request : NSFetchRequest<PackageObject> = PackageObject.fetchRequest()
        
        do
        {
            let array = try context.fetch(request)
            return array
        }
        catch
        {
            print("Error Loading Context \(error)")
            return packages
        }
    }
    
    func loadTrackingNumberRevered() -> [PackageObject]
    {
        loadTrackingNumber().reversed()
    }
    
    func save()
    {
        do
        {
            try context.save()
        } catch
        {
            print("Error Saving Context \(error)")
        }
        DispatchQueue.main.async
        {
            self.postBarcodeNotification(code: StringLiteral.updateHomeViewData) //updates the home view controller
            self.postBarcodeNotification(code: StringLiteral.updatePackageViewController) //updates the Package view controller
        }
        }
       
    func fetchDataForAllPackages()
    {
        print("Fetching Data for All Packages")
        DispatchQueue.main.async //Runs in the background
               {
                   for package in self.packages
                   {
                        if package.delivered == false
                       {
                           DispatchQueue.main.async
                           {
                               NetWorkManager.sharedManager.requestData(packageDetail: package)
                           }
                       }
                  }
               }
    }
    
    func fetchDataForAllPackages2()
    {
        print("Fetching Data for All Packages")
        DispatchQueue.global(qos: .background).sync
        { print("inside queq1")
            for package in self.packages
            {
                 if package.delivered == false
                {
                     
                    
                         print("inside the dispatch qu")
                         NetWorkManager.sharedManager.requestData(packageDetail: package)
                     
                    
                }
           }
        }
        }
        
        
        
        
    

    func updateTrackingNumber(updateThis: PackageObject)
    {
        if updateThis.delivered == false
       {
           DispatchQueue.main.async
           {
               NetWorkManager.sharedManager.requestData(packageDetail: updateThis)
           }
       }
    }
    func postBarcodeNotification(code: String)
    {
        var info = [String: String]()
        info[code.description] = code.description //post the notification with the key.
        NotificationCenter.default.post(name: Notification.Name(rawValue: StringLiteral.notificationKey), object: nil, userInfo: info)
    }
}



