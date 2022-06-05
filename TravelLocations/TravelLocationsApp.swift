//
//  TravelLocationsApp.swift
//  TravelLocations
//
//  Created by Ovidio  on 5/25/22.
//

import SwiftUI

@main
struct TravelLocationsApp: App {
    @StateObject private var vm = LocationViewModel()
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(vm)
        }
    }
}
