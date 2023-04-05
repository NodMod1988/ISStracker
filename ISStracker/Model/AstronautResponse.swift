//
//  AstronautResponse.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 03.04.23.
//

import Foundation

struct AstronautResponse: Codable {
    let message: String
    let number: Int
    let people: [Astronaut]
}
