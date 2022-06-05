//
//  LocationViewModel.swift
//  TravelLocations
//
//  Created by Ovidio  on 5/25/22.
//

import Foundation
import MapKit
import SwiftUI

class LocationViewModel: ObservableObject {
    @Published private(set) var locations : [Location] = []
    @Published var specificLocation: Location {
        didSet {
            showRegion(location: specificLocation)
        }
    }
    @Published var specificRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    
    @Published var isShowingList: Bool = false
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.specificLocation = locations.first!
        self.showRegion(location: locations.first!)
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
//  Updates the map based on coordinates. The span refers to how zoomed in the map is.
//  We can wrap this in an animation to ease the transition between regions.
    func showRegion(location: Location) {
        withAnimation(.easeInOut(duration: 2.0)) {
            specificRegion = MKCoordinateRegion(center: location.coordinates,
                                                span: mapSpan)
        }
    }
    
    func isShowingTheList() {
        withAnimation(.easeInOut(duration: 0.5)) {
            isShowingList.toggle()
        }
    }
    
    func showSpecificLocation(location: Location) {
        self.specificLocation = location
        isShowingList = false
    }
    
    func showNextLocation() {
//        Get current index
        guard let currentIndex = locations.firstIndex(where: {$0 == specificLocation }) else {
            print("Could not find location")
            return
        }
        
//        Assign variable to the next index
        let nextIndex = currentIndex + 1
        
//      next location
        guard locations.indices.contains(nextIndex) else {
//            Take us back to the first location
            guard let firstLocation = locations.first else {
                print("No location available.")
                return
            }
            showSpecificLocation(location: firstLocation)
            return
        }
        
        let nextLocation = locations[nextIndex]
        showSpecificLocation(location: nextLocation)
    }
    
    func showPreviousLocation() {
        guard let currentIndex = locations.firstIndex(where: { $0 == specificLocation }) else {
            print("Could not find location.")
            return
        }
        
        let previousIndex = currentIndex - 1
        
        guard locations.indices.contains(previousIndex) else {
            
//          Unwrapping locations.last
            guard let lastLocation = locations.last else {
                print("No location available.")
                return
            }
            
            showSpecificLocation(location: lastLocation)
            return
        }
        
        let previousLocation = locations[previousIndex]
        showSpecificLocation(location: previousLocation)
        
    }
}
