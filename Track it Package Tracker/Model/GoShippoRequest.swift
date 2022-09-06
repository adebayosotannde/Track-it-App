//
//  GoShippoRequest.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/23/22.
//

import Foundation


class GoShippoRequest
{
    //APi Key's
    let token = "ShippoToken shippo_live_5f9402689b38118662de1e49be8828fa33c05fd6" //Go Shipp api key
    var passedPackage: PackageObject
  
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
            print(dataString)
            guard (try? JSONDecoder().decode(Package.self, from: dataString.data(using: .utf8)!)) != nil else
            {

                print("Failed: Invalid Tracking Number")
                return
            }
            
          
           
print("Something Strange Happened")
            
      
        }


        }
                task.resume()
        
    }
    
}
