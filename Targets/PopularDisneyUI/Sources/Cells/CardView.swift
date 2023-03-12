import NukeUI
import SwiftUI
public struct CardView: View {
    private enum Constants {
        static let frame: CGFloat = Grid.x80
        static let spacing: CGFloat = Grid.x2
        static let padding: CGFloat = Grid.x2
        static let paddingTrailing: CGFloat = Grid.x4
        static let cornerRadius: CGFloat = Grid.x5
    }

    private let name: String
    private let popularity: Int
    private let imageURL: URL

    public init(name: String,
                popularity: Int,
                imageURL: URL)
    {
        self.name = name
        self.popularity = popularity
        self.imageURL = imageURL
    }

    public var body: some View {
        ZStack(alignment: .bottomLeading,
               content: {
                   LazyImage(url: imageURL) { state in
                       if let image = state.image {
                           image.resizable()
                               .aspectRatio(contentMode: .fit)
                               .modifier(CardModifier())
                       } else {
                           Color.gray
                               .frame(width: Constants.frame,
                                      height: Constants.frame)
                               .modifier(CardModifier())
                       }
                   }

                   VStack(alignment: .leading,
                          spacing: Constants.spacing,
                          content: {
                              Text("Name: " + name)
                                  .multilineTextAlignment(.leading)
                              Text("Popularity: \(popularity)")
                                  .multilineTextAlignment(.leading)
                          })
                          .padding(EdgeInsets(top: Constants.padding,
                                              leading: Constants.padding,
                                              bottom: Constants.padding,
                                              trailing: Constants.paddingTrailing))
                          .background(.ultraThinMaterial)
                          .cornerRadius(Constants.cornerRadius)
               })
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(name: "Thomas",
                 popularity: 1,
                 imageURL: URL(string: "https://freesvg.org/img/Placeholder.png")!)
    }
}
