import Nuke
import NukeUI
import PopularDisneyUI
import SwiftUI

struct Home<ViewModel: HomeViewModelType>: View {
    @StateObject var viewModel: ViewModel
    @State var items = [CharactersResponse.Data]()
    
    var body: some View {
        NavigationView {
            List(items) { item in
                CardView(
                    name: item.name,
                    popularity: viewModel.popularity(item),
                    imageURL: item.imageUrl
                )
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .onReceive(viewModel.itemsPublisher,
                       perform: {
                self.items = $0
            })
            .navigationTitle("Disney Characters")
        }
        .task {
            await viewModel.fetchCharacters()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(viewModel:
                HomeViewModel(
                    dataProvider:
                        HomeDataProvider(api:
                                            ConcreteAPI(urlSession:
                                                            MockUrlSession())
                                        )
                )
        )
    }
}
