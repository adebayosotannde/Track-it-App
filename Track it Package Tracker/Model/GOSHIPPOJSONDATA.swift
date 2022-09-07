
import Foundation

// MARK: - Package
struct Package: Codable
{
    let trackingNumber, carrier: String
    let servicelevel: Servicelevel?
    let trackingHistory: [Tracking]?


    enum CodingKeys: String, CodingKey
    {
        case trackingNumber = "tracking_number"
        case carrier = "carrier"
        case servicelevel = "servicelevel"
        case trackingHistory = "tracking_history"
    }
}


// MARK: - Servicelevel
struct Servicelevel: Codable
{
    let name: String?
    
    enum CodingKeys: String, CodingKey
    {
        case name = "name"
    }
}

// MARK: - AddressFrom
struct Location: Codable
{
    var city, state, zip, country: String?
    
    enum CodingKeys: String, CodingKey
    {
        case city = "city"
        case state = "state"
        case zip = "zip"
        case country = "country"
    }
    
}

// MARK: - Tracking
struct Tracking: Codable
{
    let statusDate: String?
    let statusDetails: String?
    let location: Location?
    let status: String?

    enum CodingKeys: String, CodingKey
    {
        case statusDate = "status_date"
        case statusDetails = "status_details"
        case location = "location"
        case status = "status"
    }
}





