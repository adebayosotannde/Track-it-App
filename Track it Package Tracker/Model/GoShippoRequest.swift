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
        
        print("Retrving Data")
        let httpAddress = "https://api.goshippo.com/tracks/?carrier=ups&tracking_number=1ZR700380350388215"
        let code = passedPackage.packageCarrierCode!
        let number = passedPackage.trackingNumber!
        
        let urlString = (httpAddress + code + number).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        
        
     
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"

       
   
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            
            if let data = data, let dataString = String(data: data, encoding: .utf8)
            {
                //print(dataString)
                if let resultData = try? JSONDecoder().decode(Package.self, from: dataString.data(using: .utf8)!)
                {
                   print("sucess")
                }
                else
                {
                    print("Invalid Response")
                }
            } else if let error = error
            {
                print("HTTP Request Failed \(error)")
            }
        }
        
        
      
        task.resume()
        
        
        
  
    }
    
}
