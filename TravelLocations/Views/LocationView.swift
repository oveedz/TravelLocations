//
//  ContentView.swift
//  TravelLocations
//
//  Created by Ovidio  on 5/25/22.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @EnvironmentObject private var vm: LocationViewModel
    var body: some View {
        ZStack {
            Map(coordinateRegion: $vm.specificRegion).ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                    .padding()
                Spacer()
            }
            LocationSliderView()
        }
    }
}
extension LocationView {
    var header: some View {
        VStack(spacing: 0) {
            Text(vm.specificLocation.name + ", " + vm.specificLocation.city)
                .font(.headline)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Image(systemName: "arrow.right")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .onTapGesture {
                            vm.isShowingTheList()
                        }
                        .rotationEffect(Angle(degrees: vm.isShowingList ? 90 : 0))
                }
                .background(
                    LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.5), .blue.opacity(0.5)]),
                                   startPoint: .center, endPoint: .top)
                )
                .cornerRadius(10)
  
            if vm.isShowingList {
                LocationListView()
            }
        }
        .cornerRadius(10)
        .shadow(color: .gray, radius: 5, x: 0, y: 20)
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .environmentObject(LocationViewModel())
    }
}
