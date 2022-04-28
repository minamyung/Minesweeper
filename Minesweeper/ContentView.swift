//
//  ContentView.swift
//  Minesweeper
//
//  Created by Manon Myung on 31/03/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MinesweeperBoardView()
            .padding()
    }
}

struct MinesweeperBoardView: View {
    @State var viewModel = MinesweeperBoardViewModel(4, 4)
    
    var body: some View {
        VStack {
            ForEach(viewModel.rows, content: rowView)
        }
        .font(.largeTitle)
    }
    
    private func rowView(_ row: RowViewModel) -> some View {
        HStack {
            ForEach(row.cells, content: cellView)
        }
    }
    
    @ViewBuilder
    private func cellView(_ cell: CellViewModel) -> some View {
        switch cell.state {
        case .mine:
            ZStack {
                Color.red
                    .aspectRatio(1, contentMode: .fit)
                Text("💣")
            }
        case .sweep(let count):
            ZStack {
                Color.gray
                    .aspectRatio(1, contentMode: .fit)
                Text(String(count))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
