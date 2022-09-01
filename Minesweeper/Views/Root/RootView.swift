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

// TODO: animations when losing a game
// TODO: Different levels/difficulties + board size
// TODO: Score??
