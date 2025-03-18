//
//  SquareView.swift
//  TicTacToeV1
//
//  Created by Keiko Cheung on 2/24/25.
//

import SwiftUI

struct SquareView: View {
    @EnvironmentObject var game:GameService
    let index:Int
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        //button(action label), press enter
        Button {
            game.makeMove(at: index)
        } label: {//look and feel of the button
            game.gameBoard[index].image
                .resizable()
                . frame(width: 100, height: 100)
        }
        .disabled(game.gameBoard[index].player != nil) //you cannot change your mive after you have clicked on it
        .buttonStyle(.bordered)
        .foregroundStyle(.primary)
    }
}

#Preview {
    SquareView(index:1)
        .environmentObject(GameService())
}
