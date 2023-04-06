import MapKit

import SwiftUI
import MapKit

struct LocationMapView: View {
    @EnvironmentObject var viewModel: ISSLocationViewModel
    @EnvironmentObject var userLocationViewModel: UserLocationViewModel
    @State var distance: CLLocationDistance = 0
    
    var body: some View {
        VStack {
            HStack {
                Button(action: viewModel.zoomIn) {
                    Image(systemName: "plus.circle")
                }
                .padding()
                
                Button(action: viewModel.zoomOut) {
                    Image(systemName: "minus.circle")
                }
                .padding()
                
                Spacer()
                
                Text("Distance: \(Int(distance)) km")
                
                Spacer()
            }
            
            Map(coordinateRegion: $viewModel.region, interactionModes: [.zoom], showsUserLocation: true, userTrackingMode: .none, annotationItems: viewModel.annotations) { annotation in
                MapAnnotation(coordinate: annotation.coordinate) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                }
                
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
                    viewModel.fetchISSLocation()
                    if let userLocation = userLocationViewModel.locationManager.location{
                        print("Aus dem LocationMapView \(userLocation.coordinate.latitude)" )
                        
                        if(viewModel.location != nil){
                            self.distance = viewModel.distanceInKilometers(from: userLocation.coordinate, to: viewModel.location!)
                        }
                    }
                    print("\(viewModel.location?.latitude ?? 0.0) ")
                    
                }
                viewModel.updateRegion()
            }
        }
    }
}

extension MKPointAnnotation: Identifiable {}
