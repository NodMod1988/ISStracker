import SwiftUI

struct AstronautsListView: View {
    @EnvironmentObject var viewModel: ISSLocationViewModel
    
    var body: some View {
        List(viewModel.astronautsResponse?.people ?? [], id: \.id) { astronaut in
            Text(astronaut.name)
        }
        .onAppear {
            viewModel.getAstronauts() { result in
                switch result {
                case .success(let response):
                    viewModel.astronautsResponse = response
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}



