//
//  LocationMapView.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 23.03.23.
//

import SwiftUI
import MapKit

struct LocationMapView: UIViewRepresentable {
    
    @EnvironmentObject var viewModel:ISSLocationViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = false // Disable showing user location
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {

        if let issLocation = viewModel.issLocation {
            let span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
            let region = MKCoordinateRegion(center: issLocation, span: span)
            mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = issLocation
            annotation.title = "ISS Location"
            mapView.addAnnotation(annotation)
            
            if let issLongitude = viewModel.issLongitude, let issLatitude = viewModel.issLatitude {
                print("ISS location: \(issLatitude), \(issLongitude)")
            }
        } else if let errorMessage = viewModel.errorMessage {
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        }
    }
}

