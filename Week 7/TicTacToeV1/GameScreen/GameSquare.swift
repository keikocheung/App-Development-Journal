//
//  GameSquare.swift
//  TicTacToeV1
//
//  Created by Keiko Cheung on 2/24/25.
//

import SwiftUI

//for each square, the ID of the player is important, who this square belongs to in the game
struct GameSquare {
    var ID: Int //takes values from 1 to 9
    var player:Player? //nil means it has been unassigned, ? makes sure the var can take a nil value
    
    var image:Image {
        //should check if player exists, which player it is, depending on the player --> the respective image
        if let player = player {
            return player.gamePiece.image
        }
        else {
            return Image("none")
        }
    }
    
    //we need to clear everything after game is done, static allows us to access this without having to create a new instance, and we cannot change whatever in inside
    static var reset:[GameSquare] {
        //squares will hold all the game squares
        var squares = [GameSquare]() //creates a array to store the squares, variable GameSquares
        
        for index in 1...9 {
            squares.append(GameSquare(ID: index)) //for each square (1-9) it will create a new GameSquare object with its own unique ID
        }
        
        return squares
    }
    
} //end struct GameSquare
