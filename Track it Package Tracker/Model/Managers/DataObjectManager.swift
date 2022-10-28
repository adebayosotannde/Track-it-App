//
//  class DataObjectManager {     var passedPAckage-PackageObject?          init(package- PackageObject)     {         passedPAckage = package                                }                             }.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 9/6/22.
//

import Foundation
import UIKit

class DataObjectManager
{
    var passedPAckage:PackageObject?
    
    init(package: PackageObject)
    {
        passedPAckage = package
    }
    
}

//MARK: - Populates the Table View Data
extension DataObjectManager
{
    //MARK: - Number of Activites and Tracking Object
    /**
     Returns the number of activites for a particular PackageObject
     */
     func getNumberOfActivities() -> Int
    {
        if let trackingData = try? JSONDecoder().decode(Package.self, from: (passedPAckage?.testData)!)
        {
            let numberOfActivities = (trackingData.trackingHistory!.count)
            //- 1
            return numberOfActivities
        }
        return 0
    }
    
    private func getPosition() -> Int
    {
        getNumberOfActivities()-1
    }
    
    /**
     Returns a Tracking object at a specified indexpath
     */
    private func getTrackingObject(value: IndexPath) -> Tracking?
    {
        if let trackingData = try? JSONDecoder().decode(Package.self, from: (passedPAckage?.testData)!)
        {
            let passedIndex = value.row
            let numberOfActivities = getNumberOfActivities()
            let currentRow = numberOfActivities - passedIndex //This is of how the order of the tracking data is recived from the APi.
            //Users needs to see the latest activity. APi returns Tracking Array like this [ Activity 1, Activity 2, Activity 3]
            let trackingObject = trackingData.trackingHistory![currentRow-1]
            return trackingObject
        }
        return nil
    }
    
    
    
    
    
    //MARK: - Used to poulate cell.
    /**
     Returns the Description of the the cell for a particular indexpath row
     */
    func getDescriptionLabelForCell(indexPath: IndexPath) -> String
    {
        if let trackingObject = getTrackingObject(value: indexPath)
        {
            if let statusDetail = trackingObject.statusDetails //This returns the current descriptiion for the current row
            {
                return statusDetail
            }
        }
        
        return "No Description Found"
    }
    
    /**
     Returns the curent location for a specific cell
     */
    func getFullLocationForCel(indexPath: IndexPath) -> String
    {
        if let trackingObject = getTrackingObject(value: indexPath)
        {
            
            let numberOfActivities = getNumberOfActivities()
            
            var location  = ""
            if numberOfActivities > 0
            {

                if let city = getCity(indexPath: indexPath)
                {
                    location +=  city + ", " //Appends Locations
                }
                
                
                if let state = getState(indexPath: indexPath)
                {
                    location +=  state + ", " //Appends State
                }
                
                if let zipcode = getZip(indexPath: indexPath)
                {
                    if zipcode == ""
                    {
                        //if zipcode is empty Do nothing
                    }
                    else
                    {
                        location +=  zipcode + ", " //Appends Zip
                    }
                    
                }
                //Get Country
                if let country = getCountry(indexPath: indexPath)
                {
                    location +=  country //Appends Country
                }
                return location
            }
        }
        return "US"
    }
   
    
    func getDateForCell(indexPath: IndexPath) -> String?
    {
        if let data = getTrackingObject(value: indexPath)
        {
            if let currentDate = data.statusDate
            {
                return getProperDate(date: currentDate)
            }

        }

        
        return nil
    }
    
    func getTimeForCell(indexPath: IndexPath)->String?
    {
        if let data = getTrackingObject(value: indexPath)
        {
            if let time = data.statusDate
            {
                return getStandardTime(dateString: time)
            }
        }
        return nil

    }
    
}

extension DataObjectManager
{
    func getWhenThePackageWasLastUpdated()->String
    {
        
        if passedPAckage?.isValidTrackingNumber == false
        {
            return "Waiting for updates. Check back later."
        }
        else
        {
            
            let date = Date()
            let calendar = Calendar.current
            
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date).description
            // let seconds = calendar.component(.second, from: date).description
            
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date).description
            let year = calendar.component(.year, from: date).description
            
            return "Last updated: " + convertMonthToSting(value: month) +  " " +  day +  ", " + year + " at " + convertMinitaryTimeToStandard(value: hour) + ":" +  getMinutesASDoublDigits(value: minutes) + " " + getAmPMLAstUpdated(value: hour)
            
        }
    }
    
    
    
    func getMostRecentColorIndicatorStatus()->String
    {
        let trackingData = try? JSONDecoder().decode(Package.self, from: (passedPAckage?.testData)!)
        
        
        let numberOfActivities = getNumberOfActivities()
        
        if numberOfActivities > 0
        {
            
            
            
            let hasbeenDeliverd = trackingData?.trackingHistory![numberOfActivities-1].status?.lowercased()
            
            if (hasbeenDeliverd == "delivered")
            {
                return StringLiteral.greenColor
            }
        }
        
        
        
        return StringLiteral.yellowColor
    }
    
    
    //MARK: - Used Initially to Set Pacakge Data Object
    func getMostRecentActivityDescription()->String
    {
        let trackingData = try? JSONDecoder().decode(Package.self, from: (passedPAckage?.testData)!)
        
        let numberOfActivities = getNumberOfActivities()
        
        
        var recentStatus = ""
        
        if numberOfActivities > 0
        {
            recentStatus = (trackingData?.trackingHistory![numberOfActivities-1].status)!
            return recentStatus
        }
        
        return "waiting for tracking updates"
    }
    
    func getMostRecentLocation()->String
    {
        if let location = getBestLocationForMap()
        {
            return location
        }
        
        return "NY,NY"
    
       
        
       
        
    }
    
    func getBestLocationForMap()-> String?
    {
        var locationArray:[String] = []
        
        //For loop to loop through the tracking histor
        let trackingData = try? JSONDecoder().decode(Package.self, from: (passedPAckage?.testData)!)
        
        let numberOfActivities = getNumberOfActivities()
       
        if numberOfActivities > 0
        {
            for variable in 0...numberOfActivities-1
            {
                //Check if location string is valid ie does not return ""
                let currentLocation = getLocationStringFromLocationObject(location: trackingData?.trackingHistory![variable].location)
                if currentLocation == ""
                {
                    //Do nothing error
                }else
                {
                    locationArray.append(currentLocation)
                    print(currentLocation)
                }
                
                
                
            }
           
        }
        
       return determineLocationToReturn(locations: locationArray)
        
    }
    
    func determineLocationToReturn(locations: [String])->String
    {
        //Note Locations can be "" this can include all locations
        if locations.count == 0
        {
            return "NY,NY"
        }
        
        if locations.count > 0
        {
            let latestLocation = (locations[locations.count-1])
            
            
            return latestLocation
           
        }
        
        return "NY, NY"
    }
    
    
    func getLocationStringFromLocationObject(location: Location?)->String
    {
        if let location = location
        {
            var stringValue = ""
            if let city = location.city
            {
                if city != ""
                {
                    stringValue = stringValue + city + ", "
                }
            }
           
            
            //Get State
            if let state = location.state
        {
                if state != ""
                {
                    stringValue = stringValue + state + ", "
                }
            }



            //Get Country
            if let country = location.country
        {
                if country != ""
                {
                    stringValue = stringValue + country
                }
            }
           
            return stringValue
        }else
        {
            return ""
        }
       
    }
    
    func getIfPackageHasbeenDelivered()->Bool
    {
        
        if passedPAckage?.delivered ==  true
        {
            return true
        }
        
        let trackingData = try? JSONDecoder().decode(Package.self, from: (passedPAckage?.testData)!)
        
        let numberOfActivities = getNumberOfActivities()
        
        if numberOfActivities > 0
        {
            let hasbeenDeliverd = trackingData?.trackingHistory![numberOfActivities-1].status?.lowercased()
            
            if (hasbeenDeliverd == "delivered")
            {
                return true
            }
        }
        
        
        
        return false
        
    }
    
    func isThereAnDeliveryDateAvailabe()->String
    {
        if passedPAckage?.isValidTrackingNumber == false
        {
            return "No Data Available"
        }
        
        
        
        
        let trackingData = try? JSONDecoder().decode(Package.self, from: (passedPAckage?.testData)!)
        
        let numberOfActivities = getNumberOfActivities()
        
        if numberOfActivities > 0
        {
            let hasbeenDeliverd = trackingData?.trackingHistory![numberOfActivities-1].status?.lowercased()
            
            if (hasbeenDeliverd == "delivered")
            {
                return "Delivered"
            }
            
            if (hasbeenDeliverd == "transit")
            {
                return "In Transit"
            }
        }
        
        
        return "Pre Transit"
        
        
        
    }
    
    func getDescriptionBackGroundColor()->UIColor
    {
        if passedPAckage?.isValidTrackingNumber == false
        {
            return .systemRed
        }
        
        
        
        
        let trackingData = try? JSONDecoder().decode(Package.self, from: (passedPAckage?.testData)!)
        
        let numberOfActivities = getNumberOfActivities()
        
        if numberOfActivities > 0
        {
            let hasbeenDeliverd = trackingData?.trackingHistory![numberOfActivities-1].status?.lowercased()
            
            if (hasbeenDeliverd == "delivered")
            {
                return .systemGreen
            }
            
            if (hasbeenDeliverd == "transit")
            {
                return .systemYellow
            }
        }
        
        
        return .systemYellow
        
        
        
    }
    
    
    
    func getBestImage()->String
    {
        if passedPAckage?.isValidTrackingNumber == false
        {
            return "hourglass.circle.fill"
        }
        
        
        
        
        let trackingData = try? JSONDecoder().decode(Package.self, from: (passedPAckage?.testData)!)
        
        let numberOfActivities = getNumberOfActivities()
        
        if numberOfActivities > 0
        {
            let hasbeenDeliverd = trackingData?.trackingHistory![numberOfActivities-1].status?.lowercased()
            
            if (hasbeenDeliverd == "delivered")
            {
                return "checkmark.circle.fill"
            }
            
            if (hasbeenDeliverd == "transit")
            {
                return  "hourglass.circle.fill"
            }
        }
        
        
        return "hourglass.circle.fill"
        
        
        
    }
}

//MARK: - System Date Conversion
extension DataObjectManager
{
    func convertMonthToSting(value: Int)->String
    {
        switch value
        {
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
            
            
        default:
            return "error"
        }
    }
    
    
    func convertMinitaryTimeToStandard(value: Int)->String
    {
        switch value
        {
        case 00:
            return "12"
        case 01:
            return "1"
        case 02:
            return "2"
        case 03:
            return "3"
        case 04:
            return "4"
        case 05:
            return "5"
        case 06:
            return "6"
        case 07:
            return "7"
        case 8:
            return "8"
        case 9:
            return "9"
        case 10:
            return "10"
        case 11:
            return "11"
        case 12:
            return "12"
        case 13:
            return "1"
        case 14:
            return "2"
        case 15:
            return "3"
        case 16:
            return "4"
        case 17:
            return "5"
        case 18:
            return "6"
        case 19:
            return "7"
        case 20:
            return "8"
        case 21:
            return "9"
        case 22:
            return "10"
        case 23:
            return "11"
        case 24:
            return "12"
            
            
        default:
            return " "
        }
    }
    
    func getMinutesASDoublDigits(value: String)-> String
    {
        switch value
        {
        case "0":
            return "00"
        case "1":
            return "01"
        case "2":
            return "02"
        case "3":
            return "03"
        case "4":
            return "04"
        case "5":
            return "05"
        case "6":
            return "06"
        case "7":
            return "07"
        case "8":
            return "08"
        case "9":
            return "09"
        default:
            return value
            
        }
        
        
    }
    
    func getAmPMLAstUpdated(value: Int)->String
    {
        switch value
        {
        case 00:
            return "AM"
        case 01:
            return "AM"
        case 02:
            return "AM"
        case 03:
            return "AM"
        case 04:
            return "AM"
        case 05:
            return "AM"
        case 06:
            return "AM"
        case 07:
            return "AM"
        case 8:
            return "AM"
        case 9:
            return "AM"
        case 10:
            return "AM"
        case 11:
            return "AM"
        case 12:
            return "PM"
        case 13:
            return "PM"
        case 14:
            return "PM"
        case 15:
            return "PM"
        case 16:
            return "PM"
        case 17:
            return "PM"
        case 18:
            return "PM"
        case 19:
            return "PM"
        case 20:
            return "PM"
        case 21:
            return "PM"
        case 22:
            return "PM"
        case 23:
            return "PM"
        case 24:
            return "PM"
        default:
            return "Error "
        }
    }
}

//MARK: - Functions to calculate the date and time.
extension DataObjectManager
{
    
    /**
     Returns the Proper date
     */
    private func getProperDate(date: String)-> String
    {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "YYYY-MM-dd'T'HH:mm:ss'Z'"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE, MMM d, yyyy"

        if let newDate = dateFormatterGet.date(from: date)
        {
            return dateFormatterPrint.string(from: newDate)
        }else
        {
            return "Error"
        }
        
        
       
    }
    
    /**
     Returns the standard time
     */
    private func getStandardTime(dateString: String)->String
    {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "YYYY-MM-DD'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a"
        
        if let date2 = dateFormatterGet.date(from: dateString)
        {
            return dateFormatterPrint.string(from: date2)
        } else {
            return "error decoding time "
        }
        
        
    }
    
    //MARK: - Indiviadual Locations From PAckage Objects
    
    /**
     Returns the city
     */
    private func getCity(indexPath: IndexPath) -> String?
    {
        if let trackingObject = getTrackingObject(value: indexPath)
        {
            //Get City
            if let city = (trackingObject.location?.city!)
            {
                return  city //returns the city
            }
            
        }
        return nil
    }
    
    /**
     Returns the state
     */
    private func getState(indexPath: IndexPath) -> String?
    {
        if let trackingObject = getTrackingObject(value: indexPath)
        {
            //Get State
            if let state = (trackingObject.location?.state!)
            {
                return  state //returns the state
            }
            
        }
        return nil
    }
    
    /**
     Returns the zipcode
     */
    private func getZip(indexPath: IndexPath) -> String?
    {
        if let trackingObject = getTrackingObject(value: indexPath)
        {
            //Get Zip
            if let zip = (trackingObject.location?.zip!)
            {
                return  zip //returns the zipcode
            }
            
        }
        return nil
    }
    
    /**
     Returns the Country
     */
    private func getCountry(indexPath: IndexPath) -> String?
    {
        if let trackingObject = getTrackingObject(value: indexPath)
        {
            //Get Country
            if let zip = (trackingObject.location?.country!)
            {
                return  zip //returns the Country
            }
            
        }
        return nil
    }
    
    
}
