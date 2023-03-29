//
//  MKPointAnnotationWithID.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 29.03.23.
//

import Foundation
import MapKit

class MKPointAnnotationWithID: MKPointAnnotation, Identifiable {
    override var coordinate: CLLocationCoordinate2D {
        didSet {
            self.id = "\(coordinate.latitude),\(coordinate.longitude)"
        }
    }
    var id: String = ""
}
