//
//  LocationSliderView.swift
//  TravelLocations
//
//  Created by Ovidio  on 5/25/22.
//

import SwiftUI

struct LocationSliderView: View {
    @EnvironmentObject var vm: LocationViewModel
    @State var startingOffset: CGFloat = UIScreen.main.bounds.height * 0.75
    @State var currentOffset: CGFloat = 0.00
    @State var endingOffset: CGFloat = 0.00
    @State var imageOffset: CGFloat = 0.00

    var body: some View {
        content
            .offset(y: startingOffset + endingOffset + currentOffset)
            .gesture(
                DragGesture()
//                From the start of the gesture to the end
                    .onChanged { value in
                        currentOffset = value.translation.height
                    }
//                Performs an action after the gesture is complete
                    .onEnded { value in
                        withAnimation(.spring()) {
                            if currentOffset < -75 {
                                endingOffset = -startingOffset * 0.82
                            } else if currentOffset > 75 {
                                endingOffset = 0.00
                            }
                            currentOffset = 0.00
                        }
                    }
            )
    }
}

extension LocationSliderView {
    private var content: some View {
        VStack {
            header
            
            if let image = vm.specificLocation.imageNames {
                showImageSlider(image: image)
            }
            
            Text(vm.specificLocation.description)
                .font(.system(size: 17, weight: .medium, design: .serif))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 300)
            
            learnMoreButton
            
            dismissButton
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 650)
        .background(
            LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.8), .blue.opacity(0.5)]),
                           startPoint: .center, endPoint: .top)
        )
        .cornerRadius(25)
        .overlay(alignment: .topTrailing) {
            leftArrow
        }
        .overlay(alignment: .topLeading) {
            rightArrow
        }
    }
    
    
    
//  ** Refactored variables and functions **
    
    func rotationAngle(geometry: GeometryProxy) -> Double {
        let screenWidth = UIScreen.main.bounds.width * 0.4
        let current = geometry.frame(in: .global).midX * 0.8
        return 1.0 - (current / screenWidth)
    }
    
    func arrowOverlay(symbol: String) -> some View {
        Image(systemName: symbol)
            .font(.system(size: 30, weight: .medium, design: .rounded))
            .foregroundColor(.white)
            .padding(25)
            .padding(.top, 14)
    }
    
    private var header: some View {
        VStack {
            Image(systemName: endingOffset < 0 ? "chevron.down" : "chevron.up")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top)
            
            
            Text(vm.specificLocation.name + ", " + vm.specificLocation.city)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .padding()
        }
    }
    
    func showImageSlider(image: [String]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(image, id: \.self) { index in
                    GeometryReader { geometry in
                        Image(index)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .rotation3DEffect(Angle(degrees: rotationAngle(geometry: geometry) * 15),
                                              axis: (x: 0.0, y: 1.0, z: 0.0))
                            .padding()
                    }
                    .frame(width: 200, height: 200)
                    .offset(x: 100, y: 0)
                }
            }
        }
    }
    
    private var learnMoreButton: some View {
        Button  {
            //Some function that triggers Safari
        } label: {
            Text("Learn More")
                .font(.headline)
                .foregroundColor(.blue)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(.thickMaterial)
                .cornerRadius(10)
                .padding(.top, 10)
                .padding(.horizontal, 50)
        }
    }
    
    private var dismissButton: some View {
        Button {
            withAnimation(.spring()) {
                endingOffset = 0
            }
        } label: {
            Image(systemName: "x.circle")
                .font(.system(size:25, weight: .light, design: .rounded))
                .foregroundColor(.white)
                .padding()
        }
    }
    
    private var rightArrow: some View {
        Button {
            vm.showPreviousLocation()
        } label: {
            arrowOverlay(symbol: "arrow.backward.square.fill")
        }
    }
    
    private var leftArrow: some View {
        Button {
            vm.showNextLocation()
        } label: {
            arrowOverlay(symbol: "arrow.forward.square.fill")
        }
    }
}


struct LocationSliderView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSliderView()
            .environmentObject(LocationViewModel())
                .previewInterfaceOrientation(.portrait)
    }
}
