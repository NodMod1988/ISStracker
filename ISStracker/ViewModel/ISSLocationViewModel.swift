import Foundation
import MapKit

class ISSLocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var location: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 90, longitudeDelta: 90)
    )
    @Published var annotations: [MKPointAnnotation] = []
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {
            return
        }
        location = lastLocation.coordinate
    }
    
    func fetchISSLocation() {
        getISSLocation { result in
            switch result {
            case .success(let coordinate):
                DispatchQueue.main.async {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    self.annotations = [annotation]
                    self.region.center = coordinate
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
            guard let issLocation = try? JSONDecoder().decode(Position.self, from: data) else {
                completion(.failure(NSError(domain: "ISSLocationViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to decode JSON data"])))
                return
            }
            let location = CLLocationCoordinate2D(latitude: Position.latitude.doubleValue, longitude: Position.longitude.doubleValue)
            completion(.success(location))
        }
        task.resume()
    }
    
    func zoomIn() {
        let span = MKCoordinateSpan(
            latitudeDelta: region.span.latitudeDelta / 2,
            longitudeDelta: region.span.longitudeDelta / 2
        )
        region.span = span
    }
    
    func zoomOut() {
        let span = MKCoordinateSpan(
            latitudeDelta: region.span.latitudeDelta * 2,
            longitudeDelta: region.span.longitudeDelta * 2
        )
        region.span = span
    }
    
    func updateRegion() {
        if let coordinate = location {
            region.center = coordinate
        }
    }
}
