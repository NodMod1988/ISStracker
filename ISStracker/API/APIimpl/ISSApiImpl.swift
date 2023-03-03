//
//  ISSApiImpl.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 27.02.23.
//

import Foundation


class ISSApiImpl: ISSApi{
    
    
    @Published var location: DataSource = DataSource(iss_position: Position(latitude: "", longitude: ""), timestamp: 0, message: "")
    
    init(){
        fetchData(completion: { sourceData in
            self.location = sourceData
        })
    }
    
    let baseUrl = "http://api.open-notify.org/iss-now.json"
    
    func fetchData(completion: @escaping(DataSource) -> Void) {
        
        // url
        let url = URL(string: baseUrl)
        guard url != nil else {return}
        
        // session
        let session = URLSession.shared
        
        // datatask
        
        let dataTask = session.dataTask(with: url!){data, response, error in
            
            if error == nil && data != nil {
                
                let decoder = JSONDecoder()
                
                do{
                    let sourceData = try decoder.decode(DataSource.self, from: data!)
                    DispatchQueue.main.async {
                        completion(sourceData)
                    }
                    
                } catch let error {
                    print("ERROR parsing json")
                    print(error)
                }
            }
        }
    }
}

