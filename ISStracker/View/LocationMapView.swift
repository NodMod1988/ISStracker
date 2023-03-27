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
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
    @State private var zoomFactor = 1.0
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = false
        mapView.delegate = Coordinator(self)         
        let zoomInButton = UIButton(type: .custom)
        zoomInButton.setImage(UIImage(systemName: "plus"), for: .normal)
        zoomInButton.addTarget(context.coordinator, action: #selector(Coordinator.zoomIn), for: .touchUpInside)
        
        let zoomOutButton = UIButton(type: .custom)
        zoomOutButton.setImage(UIImage(systemName: "minus"), for: .normal)
        zoomOutButton.addTarget(context.coordinator, action: #selector(Coordinator.zoomOut), for: .touchUpInside)
        
        mapView.addSubview(zoomInButton)
        mapView.addSubview(zoomOutButton)
        
        zoomInButton.translatesAutoresizingMaskIntoConstraints = false
        zoomInButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -16).isActive = true
        zoomInButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -16).isActive = true
        
        zoomOutButton.translatesAutoresizingMaskIntoConstraints = false
        zoomOutButton.bottomAnchor.constraint(equalTo: zoomInButton.topAnchor, constant: -16).isActive = true
        zoomOutButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -16).isActive = true
        
 
        func zoomIn() {
            zoomMap(by: 0.5)
        }
        

        func zoomOut() {
            zoomMap(by: 2.0)
        }
        
     
        func zoomMap(by factor: Double) {
            var region = self.region
            region.span.latitudeDelta *= factor
            region.span.longitudeDelta *= factor
            self.region = region
        }
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        
        
        Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { timer in
            viewModel.fetchISSLocation()
        }
        
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
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}
