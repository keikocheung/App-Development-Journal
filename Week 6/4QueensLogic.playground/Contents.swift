import SwiftUI

//this is using tic tac toe game view as reference!! but applied to 4 queens game
@MainActor
class QueensGameService: ObservableObject {
    @Published var board: [[Bool]] = Array(repeating: Array(repeating: false, count: 4), count: 4) // 4x4 board initialized to empty
    @Published var gameOver = false
    @Published var placedQueens: Int = 0 // Track number of queens placed
    @Published var solutionFound = false // Track if a solution is found
    
    var boardDisabled: Bool {
        gameOver || solutionFound
    }
    
    func resetGame() {
        board = Array(repeating: Array(repeating: false, count: 4), count: 4)
        placedQueens = 0
        gameOver = false
        solutionFound = false
    }
    
    // Check if placing a queen at (row, col) is safe
    func isSafe(row: Int, col: Int) -> Bool {
        for i in 0..<row {
            if board[i][col] { return false } // Check column
            if col - (row - i) >= 0 && board[i][col - (row - i)] { return false } // Check left diagonal
            if col + (row - i) < 4 && board[i][col + (row - i)] { return false } // Check right diagonal
        }
        return true
    }
    
    func placeQueen(row: Int, col: Int) {
        if isSafe(row: row, col: col) {
            board[row][col] = true
            placedQueens += 1
            checkSolution()
        }
    }
    
    func removeQueen(row: Int, col: Int) {
        if board[row][col] {
            board[row][col] = false
            placedQueens -= 1
        }
    }
    
    func checkSolution() {
        if placedQueens == 4 {
            solutionFound = true
            gameOver = true
        }
    }
}
