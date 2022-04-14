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
    @State var viewModel = MinesweeperBoardViewModel(2, 2)
    var body: some View {
        VStack {
            ForEach(viewModel.board.field, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { cell in
                        switch cell {
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
            }
        }
        .font(.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
