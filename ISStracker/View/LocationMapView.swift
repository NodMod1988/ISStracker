import SwiftUI
import MapKit

struct LocationMapView: View {
    
    @EnvironmentObject var viewModel: ISSLocationViewModel
    @State  var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
    @State  var zoomFactor = 1.0
    @State  var annotations: [MKPointAnnotationWithID] = []
    
    var body: some View {
        VStack {
            HStack {
                Button(action: zoomIn) {
                    Image(systemName: "plus.circle")
                }
                .padding()

                Button(action: zoomOut) {
                    Image(systemName: "minus.circle")
                }
                .padding()

                Spacer()
            }

            makeBody()
        }
    }
    
    private func zoomIn() {
        zoomFactor /= 2
        updateRegion()
    }

    private func zoomOut() {
        zoomFactor *= 2
        updateRegion()
    }

    private func updateRegion() {
        let span = MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta * zoomFactor, longitudeDelta: region.span.longitudeDelta * zoomFactor)
        region = MKCoordinateRegion(center: region.center, span: span)
    }
        
    private func makeBody() -> some View {
        Map(coordinateRegion: $region, annotationItems: annotations) { annotation in
            MapAnnotation(coordinate: annotation.coordinate) {
                Image(systemName: "mappin.circle.fill")
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { timer in
                viewModel.fetchISSLocation()
            }
        }
        .onReceive(viewModel.$issLocation) { issLocation in
            if let issLocation = issLocation {
                let annotation = MKPointAnnotation()
                annotation.coordinate = issLocation
                annotation.title = "ISS Location"
                annotations = [MKPointAnnotationWithID(__coordinate: annotation.coordinate)]
                region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
            }
        }

    }
}
