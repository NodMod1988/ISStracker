import Foundation
import MapKit

class ISSLocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var location: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 90, longitudeDelta: 90)
    )
    
    @Published var annotations: [MKPointAnnotation] = []
    
    func fetchISSLocation() {
        getISSLocation { result in
            switch result {
            case .success(let coordinate):
                DispatchQueue.main.async {
                    let annotation = MKPointAnnotation()
                    
                    annotation.coordinate = coordinate
                    self.annotations = [annotation]
                    self.region.center = coordinate
                    self.location = coordinate
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getISSLocation(completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        let urlString = "http://api.open-notify.org/iss-now.json"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "ISSLocationViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return  
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "ISSLocationViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])))
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  let issPosition = json["iss_position"] as? [String: String],
                  let latitudeStr = issPosition["latitude"],
                  let longitudeStr = issPosition["longitude"],
                  let latitude = Double(latitudeStr),
                  let longitude = Double(longitudeStr) else {
                completion(.failure(NSError(domain: "ISSLocationViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to decode JSON data"])))
                return
            }
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            completion(.success(location))
        }
        task.resume()
    }
    
    
    
    func zoomIn() {
        var span = MKCoordinateSpan(
            latitudeDelta: region.span.latitudeDelta / 2,
            longitudeDelta: region.span.longitudeDelta / 2
        )
        
        if(span.latitudeDelta ==  0){
            
            span.latitudeDelta = 1
        }
        if(span.longitudeDelta == 0){
            span.longitudeDelta = 1
        }
        region.span = span
    }
    
    func zoomOut() {

        
        
        print("longitudeDelta: \(region.span.longitudeDelta)")
        print("latitudeDelta:  \(region.span.latitudeDelta)")
        var span = MKCoordinateSpan(
           // Grenze bearbeiten!
            
            
            latitudeDelta: region.span.latitudeDelta * 2,
            longitudeDelta: region.span.longitudeDelta * 2
        )
        
        if(span.latitudeDelta > 180){
            
            span.latitudeDelta = 179
        }
        if(span.longitudeDelta > 360){
            span.longitudeDelta = 359
        }

        print("Aus der ISSLocationViewModel span: \(span)")
        region.span = span
    }
    
    func updateRegion() {
        if let coordinate = location {
            region.center = coordinate
        }
    }
    
    func getAstronauts(completion: @escaping (Result<AstronautResponse, Error>) -> Void) {
        let urlString = "http://api.open-notify.org/astros.json"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "ISSLocationViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "ISSLocationViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])))
                return
            }
            guard let astronautResponse = try? JSONDecoder().decode(AstronautResponse.self, from: data) else {
                completion(.failure(NSError(domain: "ISSLocationViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to decode JSON data"])))
                return
            }
            completion(.success(astronautResponse))
        }
        task.resume()
    }
    
    func distanceInKilometers(from coordinate1: CLLocationCoordinate2D, to coordinate2: CLLocationCoordinate2D) -> CLLocationDistance {
            let location1 = CLLocation(latitude: coordinate1.latitude, longitude: coordinate1.longitude)
            print("aus dem ISSViewModel \(location1)")
        let location2 = CLLocation(latitude: coordinate2.latitude, longitude: coordinate2.longitude)
            print("aus dem ISSViewModel \(location2)")
        return (location1.distance(from: location2)) / 1000
        }
     
}
