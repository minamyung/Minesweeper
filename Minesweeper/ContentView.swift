import SwiftUI

struct ContentView: View {
    var body: some View {
        MinesweeperBoardView()
            .padding()
    }
}

struct MinesweeperBoardView: View {
    @State var viewModel = MinesweeperBoardViewModel(10, 10)
    
    var body: some View {
        VStack {
            ForEach(viewModel.rows, content: rowView)
                .disabled(viewModel.playState != .inProgress)
            Button("Reset") {
                viewModel.reset()
            }
            Text(viewModel.playState.rawValue)
        }
        .minimumScaleFactor(0.00001)
        .font(.largeTitle)
        .overlay {
            if viewModel.playState == .won {
                ConfettiView().allowsHitTesting(false)
            }
        }
    }
    
    private func rowView(_ row: MinesweeperRow) -> some View {
        HStack {
            ForEach(row.cells, content: cellView)
        }
    }
    
    private func cellView(cell: MinesweeperCell) -> CellView {
        CellView(cell: cell) {
            viewModel.cellAction(for: cell)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// TODO: refactor
// TODO: animations when losing a game
// TODO: flags
