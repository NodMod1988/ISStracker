//
//  Coordinator.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 27.03.23.
//

import MapKit

class Coordinator: NSObject, MKMapViewDelegate {
    var parent: LocationMapView
    
    init(_ parent: LocationMapView) {
        self.parent = parent
    }
    
    // Update region when map is moved or zoomed
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        parent.region = mapView.region
        print("New region: \(parent.region)")
    }
    
    func zoomIn() {
        var region = parent.region
        region.span.latitudeDelta *= 0.5
        region.span.longitudeDelta *= 0.5
        parent.region = region
    }
    
    func zoomOut() {
        var region = parent.region
        region.span.latitudeDelta *= 2
        region.span.longitudeDelta *= 2
        parent.region = region
    }
    
    func zoomMap(by factor: Double) {
        var region = parent.region
        region.span.latitudeDelta *= factor
        region.span.longitudeDelta *= factor
        parent.region = region
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        let zoomInButton = UIButton(type: .custom)
        zoomInButton.setImage(UIImage(systemName: "plus"), for: .normal)
        //zoomInButton.addTarget(self, action: zoomIn, for: .touchUpInside)
        
        let zoomOutButton = UIButton(type: .custom)
        zoomOutButton.setImage(UIImage(systemName: "minus"), for: .normal)
        //zoomOutButton.addTarget(self, action: zoomOut, for: .touchUpInside)
        
        mapView.addSubview(zoomInButton)
        mapView.addSubview(zoomOutButton)
        
        zoomInButton.translatesAutoresizingMaskIntoConstraints = false
        zoomInButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -16).isActive = true
        zoomInButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -16).isActive = true
        
        zoomOutButton.translatesAutoresizingMaskIntoConstraints = false
        zoomOutButton.bottomAnchor.constraint(equalTo: zoomInButton.topAnchor, constant: -16).isActive = true
        zoomOutButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -16).isActive = true
        
    }
    
}
