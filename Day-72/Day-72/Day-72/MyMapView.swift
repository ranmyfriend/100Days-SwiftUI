//
//  MyMapView.swift
//  Day-72
//
//  Created by Ranjit on 27/10/20.
//

import SwiftUI
import MapKit

struct MyMapView: View {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    @Binding var showingEditScreen: Bool

    var body: some View {
        MapView(centerCoordinate: $centerCoordinate,
                selectedPlace: $selectedPlace,
                showingPlaceDetails: $showingPlaceDetails,
                annotations: locations)
            .edgesIgnoringSafeArea(.all)
        Circle()
            .fill(Color.blue)
            .opacity(0.3)
            .frame(width: 40, height: 40)
        
        VStack {
            Spacer()
            HStack {
                Button(action: {
                    let newLocation = CodableMKPointAnnotation()
                    newLocation.title = "Example Location"
                    newLocation.coordinate = self.centerCoordinate
                    self.locations.append(newLocation)
                    self.selectedPlace = newLocation
                    self.showingEditScreen = true
                }, label: {
                    Image(systemName: "plus")
                })
                .frame(width: 40, height: 40)
                .background(Color.blue.opacity(0.75))
                .foregroundColor(Color.white)
                .font(.title)
                .clipShape(Circle())
                .padding()
            }
        }
    }
}

//struct MyMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyMapView(centerCoordinate: <#Binding<CLLocationCoordinate2D>#>, locations: <#Binding<[CodableMKPointAnnotation]>#>, selectedPlace: <#Binding<MKPointAnnotation?>#>, showingPlaceDetails: <#Binding<Bool>#>, showingEditScreen: <#Binding<Bool>#>)
//    }
//}
