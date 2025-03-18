import Foundation

enum Player {
    case x, o
}

struct TicTacToe {
    let board: [[Player?]] // 3x3 grid of Player? (nil if empty, .x or .o based on player)
    let currentPlayer: Player
    let turnCount: Int

    // Initializes the game state
    init(board: [[Player?]] = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]], currentPlayer: Player = .x, turnCount: Int = 0) {
        self.board = board
        self.currentPlayer = currentPlayer
        self.turnCount = turnCount
    }

    // Function to simulate a click on a cell, this is just the basic functionality
    func clickCell(row: Int, col: Int) -> TicTacToe {
        if board[row][col] == nil { // making sure the block clicked is nil/empty
            var newBoard = board
            newBoard[row][col] = currentPlayer // set the clicked block to the current player
            let newTurnCount = turnCount + 1
            // is current player x? if yes then change player to o, if not it is player x turn
            let nextPlayer: Player = currentPlayer == .x ? .o : .x
            return TicTacToe(board: newBoard, currentPlayer: nextPlayer, turnCount: newTurnCount)
        } else {
            return self
        }
    }
    
    // Function to check for a winner
    func checkWinner() -> Player? {
        // ROWS
        for row in 0..<3 {
            if let player = board[row][0], player == board[row][1], player == board[row][2] {
                return player
            }
        }
        
        // COLUMNS
        for col in 0..<3 {
            if let player = board[0][col], player == board[1][col], player == board[2][col] {
                return player
            }
        }
        
        // DIAGONALS
        if let player = board[0][0], player == board[1][1], player == board[2][2] {
            return player
        }
        if let player = board[0][2], player == board[1][1], player == board[2][0] {
            return player
        }

        // No winner
        return nil
    }

    // Function to check if the game is a tie
    func isTie() -> Bool {
        return turnCount == 9 && checkWinner() == nil // All turns used and no winner
    }
    
    // Function to clear the board (reset game state), same conditionals as init
    func clearBoard() -> TicTacToe {
        return TicTacToe(board: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]], currentPlayer: .x, turnCount: 0)
    }
}

func gameResults(game: TicTacToe) -> String {
    if let winner = game.checkWinner() {
        return "Player \(winner) wins!"
    } else if game.isTie() {
        return "It's a tie!"
    } else {
        return "Game is still ongoing."
    }
}

// Execute game
var game = TicTacToe()
//insert moves
let results = gameResults(game: game)
print(results)
game = game.clearBoard()
