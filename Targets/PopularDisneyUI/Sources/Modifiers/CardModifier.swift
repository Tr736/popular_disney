import SwiftUI
public struct CardModifier: ViewModifier {
    private enum Constants {
        static let shadowColor: CGFloat = 0.2
        static let cornerRadius: CGFloat = Grid.x5
    }

    public init() {}

    public func body(content: Content) -> some View {
        content
            .cornerRadius(Constants.cornerRadius)
            .shadow(color: Color.black.opacity(Constants.shadowColor),
                    radius: Constants.cornerRadius,
                    x: 0,
                    y: 0)
    }
}
