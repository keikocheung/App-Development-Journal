import Foundation

// Check if the queen can be safely placed at row, col
//2d array, true means there is a queen in that spot (NOT SAFE), false means no queen (SAFE)
//row and column is where we place the queen
func isSafe(board: [[Bool]], row: Int, col: Int) -> Bool {
    var i = 0;
    
    while i < row {
        if board[i][col] { return false } // Check column
        if col - (row - i) >= 0 && board[i][col - (row - i)] { return false } // Check left diagonal
        if col + (row - i) < 4 && board[i][col + (row - i)] { return false } // Check right diagonal
        i += 1
    }
    
    return true
}

// Solve the problem using backtracking
func solveNQueens(board: inout [[Bool]], row: Int) -> Bool {
    // inout passes paramter by refrence, instead of working with a copy it works by modifying the original
    if row == 4 { return true } // If all queens are placed successfully
    
    //does the same thing as above, but for each column
    for col in 0..<4 {
        if isSafe(board: board, row: row, col: col) {
            board[row][col] = true
            if solveNQueens(board: &board, row: row + 1) {
                return true
            }
            board[row][col] = false // Backtrack if the placement doesn't lead to a solution
        }
    }
    return false // No valid position for the current queen
}

func printBoard(board: [[Bool]]) {
    for row in board {
        print(row.map { $0 ? "Q" : "." }.joined(separator: " "))
    }
}

var board = Array(repeating: Array(repeating: false, count: 4), count: 4)
if solveNQueens(board: &board, row: 0) {
    printBoard(board: board)
} else {
    print("No solution found")
}
