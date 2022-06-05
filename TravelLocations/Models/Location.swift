//
//  Location.swift
//  TravelLocations
//
//  Created by Ovidio  on 5/25/22.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
//    Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
//        If two locations have the same id then they r=are the same location
        lhs.id == rhs.id
    }
    
//    Identifiable
    var id: String {
        name + city
    }
    
    var name: String
    var city: String
    var description: String
    var imageNames: [String]
    var link: String
    var coordinates: CLLocationCoordinate2D
}
