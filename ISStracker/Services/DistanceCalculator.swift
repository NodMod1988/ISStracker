//
//  DistanceCalculator.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 04.04.23.
//

import CoreLocation

struct DistanceCalculator {
    static func calculateDistance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
        let fromLocation = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let toLocation = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return fromLocation.distance(from: toLocation) / 1000
    }
}
