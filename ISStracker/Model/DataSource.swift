//
//  DataSource.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 27.02.23.
//

import Foundation

struct DataSource: Codable{
    
    var iss_position: Position
    var timestamp: Int64
    var message: String
}
