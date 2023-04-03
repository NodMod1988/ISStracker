//
//  ISSApi.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 27.02.23.
//

import Foundation

protocol ISSApi{
    
    func fetchData(completion: @escaping(Position) -> Void)
}
