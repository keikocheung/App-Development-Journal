//
//  GameService.swift
//  TicTacToeV1
//
//  Created by Keiko Cheung on 2/17/25.
//


//need to create a board for the game, 3x3 empty matrix, each tile will have a blank image first, each tile will have a button, assign a image to player 1, assign a image to player 2, if player clicks on a tiles make sure there is no play already in that tile, make sure there is someway to "lock" the tile
//total amount of moves availible, the more moves you make, the less are availible
import SwiftUI

//piggy backing on the main thread of the app to update UI
@MainActor

//observable object, an instance of the entire game is created once the gane starts, we want to track this instance and get the info about this game
class GameService: ObservableObject{
    @Published var player1 = Player(gamePiece: .X, name: "Player 1")
    @Published var player2 = Player(gamePiece: .O, name: "Player 2")
    
    @Published var possibleMoves = Moves.all
    
    //we need to build a game board
    @Published var gameBoard = GameSquare.reset
    @Published var  gameOver = false
    var gameType = GameType.single
    
    var currentPlayer:Player{
        if player1.isCurrent{
            return player1
        }
        else {
            return player2
        }
    }
    
    var gameStarted:Bool {
        player1.isCurrent || player2.isCurrent
    }
    
    var boardDisabled: Bool {
        gameOver || !gameStarted
    }
    
    func setupGame(gameType: GameType, player1Name:String, player2Name:String){
        switch gameType {
        case .single:
            self.gameType = .single
            player2.name = player2Name
        case .bot:
            self.gameType = .bot
        case .peer:
            self.gameType = .peer
        case.undetermined:
            break
        }
        player1.name = player1Name
        
    }
    
    func reset(){
        player1.isCurrent = false
        player2.isCurrent = false
        
        //we need to get rid of all their moves, remove all with remove everything!
        player1.moves.removeAll()
        player2.moves.removeAll()
        
        //game hasnt started so now we reset to false
        gameOver = false
        
        //possible moves works by removing moves each time a player takes a turn so we need to reset to beginning
        possibleMoves = Moves.all
        
        //reset the game board
        gameBoard = GameSquare.reset
    }
    
    //when we make a move as a player, it will update the moves as a player
    func updateMoves(index: Int) {
        //first need to check who is the current player
        if player1.isCurrent { //player 1 is current
            player1.moves.append(index + 1)
            gameBoard[index].player = player1 //updates gameboard
        }
        else { //player 2 is current
            player2.moves.append(index + 1)
            gameBoard[index].player = player2
        }
    }
    
    func checkIfWinner(){
        if player1.isWinner || player1.isWinner {
            gameOver = true
        }
    }
    
    //this swithes between player1 and player2
    func toggleCurrent(){
        player1.isCurrent.toggle()
        player2.isCurrent.toggle()
    }
    
    func makeMove(at index:Int){
        //if empty squre is clicked, we will replace it with wtv play symbol clicked on it
        if gameBoard[index].player == nil {
            withAnimation{
                updateMoves(index: index)
            }
            checkIfWinner()
            
            if !gameOver { //if game isnt over yet, we remove the move player just inputted from the list of possible moves
                if let matchingIndex = possibleMoves.firstIndex(where: {$0 == (index + 1)}){
                    possibleMoves.remove(at: matchingIndex)
                }
                
                toggleCurrent() //next players turn 
            }
            if possibleMoves.isEmpty {
                gameOver = true
            }
        }
    }
}

