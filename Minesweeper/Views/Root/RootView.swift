import SwiftUI

struct RootView: View {
    var body: some View {
        MinesweeperBoardView()
            .padding()
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .previewInterfaceOrientation(.portrait)
    }
}

// TODO: refactor
// TODO: animations when losing a game
