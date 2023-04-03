import SwiftUI
import MapKit


struct LocationMapView: View {
    @EnvironmentObject var viewModel: ISSLocationViewModel
    
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
            }

            Map(coordinateRegion: $viewModel.region, interactionModes: [.zoom], showsUserLocation: true, userTrackingMode: .none, annotationItems: viewModel.annotations) { annotation in
                MapAnnotation(coordinate: annotation.coordinate) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                }
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 15.0, repeats: true) { timer in
                    viewModel.fetchISSLocation()
                }
                viewModel.updateRegion() // Aktualisieren der Kartenregion beim ersten Anzeigen der Karte
            }
        }
    }
}

extension MKPointAnnotation: Identifiable {}
