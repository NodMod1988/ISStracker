//
//  ISSLocationViewModel.swift
//  ISStracker
//
//  Created by Ruben Niewerth on 23.03.23.
//

import Foundation
import MapKit


class ISSLocationViewModel: ObservableObject {
    
    
    @Published var issLocation: CLLocationCoordinate2D?
    @Published var issLongitude: Double?
    @Published var issLatitude: Double?
    @Published var errorMessage: String?
    
    init() {
        fetchISSLocation()
    }
    
    func fetchISSLocation() {
        let url = URL(string: "http://api.open-notify.org/iss-now.json")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "Invalid data received"
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    let issPositionDict = json["iss_position"] as! [String:String]
                    let issLatitude = Double(issPositionDict["latitude"]!)!
                    let issLongitude = Double(issPositionDict["longitude"]!)!
                    print(issLatitude)
                    print(issLongitude)
                    self.issLocation = CLLocationCoordinate2D(latitude: issLatitude, longitude: issLongitude)
                    self.issLongitude = issLongitude
                    self.issLatitude = issLatitude
                } catch {
                    self.errorMessage = error.localizedDescription
                }
            }
        }.resume()
    }
}
