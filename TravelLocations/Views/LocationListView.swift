//
//  LocationListView.swift
//  TravelLocations
//
//  Created by Ovidio  on 6/1/22.
//

import SwiftUI

struct LocationListView: View {
    @EnvironmentObject var vm: LocationViewModel
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                Button {
                    vm.showSpecificLocation(location: location)
                } label: {
                    organizeLocationList(location: location)
                }
            }
            .padding(.top)
            .listRowBackground(Color(uiColor: .secondarySystemBackground))
        }
        .listStyle(PlainListStyle())
        .frame(maxHeight: 470).cornerRadius(10)
    }
}

extension LocationListView {
    func organizeLocationList(location: Location) -> some View {
        HStack {
            if let image = location.imageNames.first {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
                    .shadow(radius: 10)

            }
            VStack(alignment: .leading, spacing: 2) {
                Text(location.name)
                    .font(.headline)
                Text(location.city)
                    .font(.subheadline)
                
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
            .environmentObject(LocationViewModel())
    }
}
