//
//  MKPointAnnotationWithID.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 30.03.23.
//


import Foundation
import MapKit

class MKPointAnnotationWithID: MKPointAnnotation {
    override var coordinate: CLLocationCoordinate2D {
        didSet {
            self.id = "\(coordinate.latitude),\(coordinate.longitude)"
        }
    }
    var id: String = ""
}
