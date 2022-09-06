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
    
    var packages = [PackageObject]() //Pacakge Object Array
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //Core Data Contect to Save Data
  

    static let sharedManager = CoreDataManager() //Create Instance of Persistance Contaner
  private init() {} // Prevent clients from creating another instance.
  
  

  lazy var persistentContainer: NSPersistentContainer =
{
    let container = NSPersistentContainer(name: "Track_It")
    container.loadPersistentStores(completionHandler:
    { (storeDescription, error) in
      
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  

    
    func insertPackageObject(newObject: PackageObject)
    {
        packages.append(newObject)
        save()
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
            return try context.fetch(request)
        }
        catch
        {
            print("Error Loading Context \(error)")
            return packages
        }
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
       
    
    func saveNoUpdates()
    {
        do
        {
            try context.save()
        } catch
        {
            print("Error Saving Context \(error)")
        }
        postBarcodeNotification(code: StringLiteral.updateHomeViewData) //updates the home view controller
    }
    func randomString(length: Int) -> String
    {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func fetchDataForAllPackages()
    {
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

    func updateTrackingNumber(updateThis: PackageObject)
    {
        
    }
    func postBarcodeNotification(code: String)
    {
        var info = [String: String]()
        info[code.description] = code.description //post the notification with the key.
        NotificationCenter.default.post(name: Notification.Name(rawValue: StringLiteral.notificationKey), object: nil, userInfo: info)
    }
}



