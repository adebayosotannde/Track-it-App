////
////  PackageStatus.swift
////  Track it Package Tracker
////
////  Created by Adebayo Sotannde on 8/19/22.
////
//
//import Foundation
//
//struct PackageStatus: Decodable
//{
//    let name: String
//    let category: Category
//
//    enum Category: Decodable
//    {
//      case all
//      case delivered
//      case intransit
//      case other
//    }
//}
//
//extension PackageStatus.Category: CaseIterable { }
//
//extension PackageStatus.Category: RawRepresentable
//{
//  typealias RawValue = String
//
//  init?(rawValue: RawValue)
//  {
//    switch rawValue
//    {
//    case "All": self = .all
//    case "green": self = .delivered
//    case "red": self = .intransit
//    case "yellow": self = .other
//    default: return nil
//    }
//  }
//
//  var rawValue: RawValue
//    {
//    switch self
//        {
//    case .all: return "All"
//    case .delivered: return "Delivered"
//    case .intransit: return "In Transit"
//    case .other: return "Other"
//    }
//  }
//}
