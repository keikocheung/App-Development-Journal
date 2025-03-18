import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var game: GameService
    @Environment(\.dismiss) private var dismiss // Fix dismiss issue
    
    var body: some View {
        NavigationStack {
            VStack {
                if !game.player1.isCurrent && !game.player2.isCurrent {
                    Text("Select a player to start the game.")
                }
                HStack {
                    // Player 1 Button
                    Button(action: { game.player1.isCurrent = true }) {
                        Text(game.player1.name)
                    }
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(game.player1.isCurrent ? Color.green : Color.gray))
                    
                    // Player 2 Button
                    Button(action: { game.player2.isCurrent = true }) {
                        Text(game.player2.name)
                    }
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(game.player2.isCurrent ? Color.green : Color.gray))
                }
                .foregroundColor(.white)
                
                // Board Layout
                VStack {
                    ForEach(0..<3, id: \.self) { row in
                        HStack {
                            ForEach(0..<3, id: \.self) { col in
                                SquareView(index: row * 3 + col)
                            }
                        }
                    }
                }
            }
            .disabled(game.boardDisabled)
            
            // Game Over Message
            VStack {
                if game.gameOver {
                    Text("Game Over!")
                    
                    if game.possibleMoves.isEmpty {
                        Text("It's a draw")
                    } else {
                        Text("\(game.currentPlayer.name) wins")
                    }
                    
                    Button("New Game") {
                        game.reset()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .font(.largeTitle)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("End Game") {
                    dismiss()
                }
                .buttonStyle(.bordered)
            }
        }
        .navigationTitle("Tic-Tac-Toe")
        .onAppear {
            game.reset()
        }
    }
}

#Preview {
    GameView()
        .environmentObject(GameService())
}
