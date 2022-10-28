//
//  NetWorkManager.swift
//  Track It
//
//  Created by Adebayo Sotannde on 1/18/22.
//

import Foundation

class NetWorkManager
{
    
    static let sharedManager = NetWorkManager() //Create Instance of Persistance Contaner
    private init() {} // Prevent clients from creating another instance.

    func requestData(packageDetail: PackageObject)
    {
        print("Attempting to request data")
        GoShippoRequest(package: packageDetail) //Quiery the UPS API Against the tracking Number
    }
}





