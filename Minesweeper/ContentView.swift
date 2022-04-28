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
            Button("Reset") {
                viewModel.reset()
            }
        }
        .minimumScaleFactor(0.00001)
        .font(.largeTitle)
    }
    
    private func rowView(_ row: RowViewModel) -> some View {
        HStack {
            ForEach(row.cells, content: CellView.init)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
