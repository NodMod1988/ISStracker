//
//  DataService.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 27.02.23.
//

import Foundation

class DataService: ObservableObject{
    
    var issCall: ISSApi
    
    init(issCall: ISSApi){
        self.issCall = issCall
    }
    
    
}
