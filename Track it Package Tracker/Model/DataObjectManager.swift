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
    func getDescriptionLabelForCell(indexPath: IndexPath) -> String
    {
        let trackingData = try? JSONDecoder().decode(Package.self, from: (passedPAckage?.testData)!)
        
        let passedIndex = indexPath.row
        
        let numberOfActivities = (trackingData?.trackingHistory!.count)! - 1
        
        let currentRow = numberOfActivities - passedIndex
        
        return (trackingData?.trackingHistory![currentRow].statusDetails)!
      
          
        
        
    }
    
    func getLocationLabelForCel(indexPath: IndexPath) -> String
    {
        
        let trackingData = try? JSONDecoder().decode(Package.self, from: (passedPAckage?.testData)!)
        
        let passedIndex = indexPath.row
        
        let numberOfActivities = (trackingData?.trackingHistory!.count)! - 1
        
        let currentRow = numberOfActivities - passedIndex
        
        
        var location  = ""
        if numberOfActivities > 0
        {
            //Get City
            let city = (trackingData?.trackingHistory![currentRow].location?.city!)
            if city != ""
            {
                location = location + city! + ", "
            }
            
            //Get State
            let state = (trackingData?.trackingHistory![currentRow].location?.state!)
            if state != ""
            {
                location = location + state! + ", "
            }
            
            
            //Get Country
            let country = (trackingData?.trackingHistory![currentRow].location?.country)
            if country != ""
            {
                location = location + country!
            }
            
            return location
            
        }
    
            
           
            return "US"
    }
    
    func getDateForCell(indexPath: IndexPath) -> String
    {
        let trackingData = try? JSONDecoder().decode(Package.self, from: (passedPAckage?.testData)!)
        
        let passedIndex = indexPath.row
        
        let numberOfActivities = (trackingData?.trackingHistory!.count)! - 1
        
        let currentRow = numberOfActivities - passedIndex
        
        let currentDate =  (trackingData?.trackingHistory![currentRow].statusDate)!
       
        
        return getProperDate(date: currentDate)
        
    }
    
    func getTimeForCell(indexPath: IndexPath)->String
    {
        let trackingData = try? JSONDecoder().decode(Package.self, from: (passedPAckage?.testData)!)
        
        let passedIndex = indexPath.row
        
        let numberOfActivities = (trackingData?.trackingHistory!.count)! - 1
        
        let currentRow = numberOfActivities - passedIndex
        
        let currentTime =  (trackingData?.trackingHistory![currentRow].statusDate)!
       
        
        return getStandardTime(dateString: currentTime)
    }
    
}

extension DataObjectManager
{
    func getWhenThePackageWasLastUpdated()->String
    {
        
                if passedPAckage?.isValidTrackingNumber == false
                {
                    return "No Data. Check Back later or Contact Carrier"
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
        
        
        let numberOfActivities = (trackingData?.trackingHistory!.count)! - 1
        
        if numberOfActivities > 0
        {
            print(numberOfActivities)
            
            
            let hasbeenDeliverd = trackingData?.trackingHistory![numberOfActivities].status?.lowercased()
            
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
        
        let numberOfActivities = (trackingData?.trackingHistory!.count)! - 1
        
        var recentStatus = ""
        
        if numberOfActivities > 0
        {
            recentStatus = (trackingData?.trackingHistory![numberOfActivities].status)!
            return recentStatus
        }

        return "no data"
    }
    
    func getMostRecentLocation()->String
    {
        
        let trackingData = try? JSONDecoder().decode(Package.self, from: (passedPAckage?.testData)!)
        
        let numberOfActivities = (trackingData?.trackingHistory!.count)! - 1
        
        var location  = ""
        if numberOfActivities > 0
        {
            //Get City
            let city = (trackingData?.trackingHistory![numberOfActivities].location?.city!)
            if city != ""
            {
                location = location + city! + ", "
            }
            
            //Get State
            let state = (trackingData?.trackingHistory![numberOfActivities].location?.state!)
            if state != ""
            {
                location = location + state! + ", "
            }
            
            
            //Get Country
            let country = (trackingData?.trackingHistory![numberOfActivities].location?.country)
            if country != ""
            {
                location = location + country!
            }
            
            return location
            
        }
    
            
           
            return "US"
    
    }
    
    func getIfPackageHasbeenDelivered()->Bool
    {
        
        if passedPAckage?.delivered ==  true
        {
            return true
        }
        
        let trackingData = try? JSONDecoder().decode(Package.self, from: (passedPAckage?.testData)!)
        
        let numberOfActivities = (trackingData?.trackingHistory!.count)! - 1
        
        if numberOfActivities > 0
        {
            let hasbeenDeliverd = trackingData?.trackingHistory![numberOfActivities].status?.lowercased()
            
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
        
        let numberOfActivities = (trackingData?.trackingHistory!.count)! - 1
        
        if numberOfActivities > 0
        {
            let hasbeenDeliverd = trackingData?.trackingHistory![numberOfActivities].status?.lowercased()
            
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
        
        let numberOfActivities = (trackingData?.trackingHistory!.count)! - 1
        
        if numberOfActivities > 0
        {
            let hasbeenDeliverd = trackingData?.trackingHistory![numberOfActivities].status?.lowercased()
            
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
        
        let numberOfActivities = (trackingData?.trackingHistory!.count)! - 1
        
        if numberOfActivities > 0
        {
            let hasbeenDeliverd = trackingData?.trackingHistory![numberOfActivities].status?.lowercased()
            
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


extension DataObjectManager
{
    func getYearFromDate(date: String) ->String
    {
        let year = String(date.prefix(4))
        return year
    }

    func getDay(date: String) ->String
    {
        var temp = date
        
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()

        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
      
        return temp
        
        
    }


    func getMonthAsNumberFromDate(date: String)-> Int
    {
        var temp = date
        
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()

        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        temp.removeLast()
        
        
        return Int(temp)!
    }

    func getMonthAsString(date: Int) -> String
    {
        switch date
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
    func getProperDate(date: String)-> String
    {
        return getMonthAsString(date: getMonthAsNumberFromDate(date: date)) + " " + getDay(date: date) + "," + " " +  getYearFromDate(date: date)
    }
    
    func getProperTimeString(time: String)-> String
    {
        var temp = time
        
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()
        temp.removeFirst()
        
        temp.removeLast()
        
        return temp
    }



    func getStandardTime(dateString: String)->String
    {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a"
        
        if let date2 = dateFormatterGet.date(from: getProperTimeString(time: dateString))
        {
            return dateFormatterPrint.string(from: date2)
        } else {
           return "error decoding time "
        }
        
        
    }

}
