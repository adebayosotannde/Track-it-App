//
//  GoShippoRequest.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/23/22.
//

import Foundation
import UserNotifications



class GoShippoRequest
{
    
    //APi Key's
    let token = "ShippoToken shippo_live_5f9402689b38118662de1e49be8828fa33c05fd6" //Go Shipp api key
    var passedPackage: PackageObject
    let userNotificationCenter = UNUserNotificationCenter.current()
   
  
    init(package: PackageObject)
    {
      passedPackage = package//Set the package object
        retriveData()
       
       
        
    }
    
    
    
    func retriveData()
    {

        let url = URL(string: "https://api.goshippo.com/tracks/?carrier=" + passedPackage.packageCarrierCode! +  "&tracking_number=" + passedPackage.trackingNumber!)

        guard let requestUrl = url else
        {
            print("GoShippo: Error Parsing Data")
            return
        }

        var request = URLRequest(url: requestUrl) // Create URL Request
        request.httpMethod = "POST"  // Specify HTTP Method to use
        request.setValue(token, forHTTPHeaderField: "Authorization") // Set HTTP Request Header

        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request)
        { [self] (data, response, error) in

        // Check if Error took place
        if let error = error
        {
                        print("Error took place \(error)")
                        return
        }

        //Read HTTP Response Status code
            if let response = response as? HTTPURLResponse
            {
            }
     

        // Convert HTTP Response Data to a simple String
        if let data = data, let dataString = String(data: data, encoding: .utf8)
        {
   
            guard (try? JSONDecoder().decode(Package.self, from: dataString.data(using: .utf8)!)) != nil else
            {
                CoreDataManager.sharedManager.updateInvalidTrackingNumber(package: self.passedPackage)
                print("Failed: Invalid Tracking Number")
                return
            }
            
          
           
            print("Sucess")
            let data = DataObjectManager(package: self.passedPackage)
         
            
           
            
           
            
            
            
            
            self.passedPackage.testData = dataString.data(using: .utf8)
            self.passedPackage.isValidTrackingNumber = true // set tracking number as a valid tracking number
            self.passedPackage.currentDescription = data.getMostRecentActivityDescription()
            self.passedPackage.circleIndicatorColor = data.getMostRecentColorIndicatorStatus()
            self.passedPackage.lastUpdated = data.getWhenThePackageWasLastUpdated()
            self.passedPackage.lastLocation = data.getMostRecentLocation()
            self.passedPackage.delivered = data.getIfPackageHasbeenDelivered()
            
            
            postBarcodeNotification(code: StringLiteral.displayUserNotification)
            if passedPackage.numberOfActivities < data.getNumberOfActivities()
            {
               
                
                let descriptionOfPackage = passedPackage.descriptionOfPackage
                let body = passedPackage.currentDescription
                
                
            }else
            {
                print("User will not be notified")
            }
            
            
            passedPackage.numberOfActivities = 0
            //Int64(data.getNumberOfActivities())
            
            
            
            
            CoreDataManager.sharedManager.save() //Saves Data and Refreshes View
            
            
      
        }


        }
                task.resume()
        
    }
    
}

//MARK: - User notifications
extension GoShippoRequest
{
   

    
  
    
    private func postBarcodeNotification(code: String)
    {
        var info = [String: String]()
        info[StringLiteral.displayUserNotification] = code.description
        NotificationCenter.default.post(name: Notification.Name(rawValue: StringLiteral.notificationKey), object: nil, userInfo: info)
    }
    
   
}
