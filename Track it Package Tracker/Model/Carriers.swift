//
//  Carriers.swift
//  Track It
//
//  Created by Adebayo Sotannde on 1/17/22.
//

import Foundation

struct Carrier: Decodable
{
    let name: String

    //let category: Category

//    enum Category: Decodable
//    {
//      case all
//      case delivered
//      case intransit
//      case other
//    }
}


extension Carrier
{
  static func supportedSarriers() -> [Carrier]
  {
    guard
      let url = Bundle.main.url(forResource: "carriers", withExtension: "json"),
      let data = try? Data(contentsOf: url)
      else {
        return []
    }

    do {
      let decoder = JSONDecoder()
      return try decoder.decode([Carrier].self, from: data)
    } catch {
      return []
    }
  }
}

