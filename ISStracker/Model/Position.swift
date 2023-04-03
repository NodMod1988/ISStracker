//
//  DataSource.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 27.02.23.
//

import Foundation

struct Position: Codable{
    
        let timestamp: Int
        let message: String
        let iss_position: ISSPosition
}

