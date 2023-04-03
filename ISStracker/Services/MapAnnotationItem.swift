//
//  MapAnnotationItem.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 03.04.23.
//

import Foundation
import MapKit

struct MapAnnotationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
}
