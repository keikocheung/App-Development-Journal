//
//  GameModels.swift
//  TicTacToeV1
// in this file we will write the code for the differnet types of games we can play
//  Created by Keiko Cheung on 2/10/25.
//

/*
 1. two players agaisnt each other (playing with a peer)
 2. playing alone against a computer
 3. playing online in a network (hard to code)(need to understand socket programming)
 */

import Foundation
import SwiftUI

//@main //this is the main thread the application is running on 
enum GameType {
    case single, bot, peer, undetermined
    
    var description: String { //this is a dropdown
        //Self (structure) vs. self (instance)
        switch self {
        case .single:
            return "Share your devie with a friend to play."
        case .bot:
            return "Play with a bot."
        case .peer:
            return "Invite a player from the network to play."
        case .undetermined:
            return ""
        }
    }
}

enum GamePiece: String {
    case X, O
    var image: Image{
        Image(self.rawValue)
        //what information do we need to hold from the player: moves, turns (isCurrent) ,
    }
}


enum Moves {
    static var all = [1,2,3,4,5,6,7,8,9]
    
    //can also use constant = let
    static var winningMoves = [
        [1,2,3],
        [4,5,6],
        [1,4,7],
        [2,5,8],
        [3,6,9],
        [1,5,9],
        [3,5,7]
    ]
}

struct Player {
    var gamePiece: GamePiece
    var name: String
    var moves:[Int] = []
    var isCurrent = false
    
    var isWinner: Bool {
        for moves in Moves.winningMoves {
            if moves.allSatisfy(self.moves.contains) {
                return true
            }
        }
        return false
    }
}
