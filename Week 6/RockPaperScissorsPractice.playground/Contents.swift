import SwiftUI

struct RockPaperScissorsView: View {
    let choices = ["Rock", "Paper", "Scissors"] // options for the game
    
    @State private var userChoice = "❔" // stores what the player picks
    @State private var computerChoice = "❔" // stores what the computer picks
    @State private var resultMessage = "Pick Rock, Paper, or Scissors!" // tells the player what's happening
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Rock Paper Scissors") // title at the top
                .font(.title)
                .bold()
            
            Text("Opponent: \(computerChoice)") // shows what the computer picked
            Text("You: \(userChoice)") // shows what the player picked
            
            Text(resultMessage) // shows who won
                .bold()
                .padding()
            
            HStack {
                ForEach(choices, id: \.self) { choice in
                    Button(choice) {
                        play(choice) // when a button is tapped, play the game
                    }
                    .padding()
                    .background(Color.blue.opacity(0.2)) // light blue background so buttons stand out
                    .cornerRadius(10)
                }
            }
        }
        .padding()
    }
    
    func play(_ userMove: String) {
        userChoice = userMove // store what the player picked
        computerChoice = choices.randomElement()! // computer picks randomly
        
        if userChoice == computerChoice {
            resultMessage = "It's a tie!" // if both pick the same, it's a tie
        } else if (userChoice == "Rock" && computerChoice == "Scissors") ||
                  (userChoice == "Scissors" && computerChoice == "Paper") ||
                  (userChoice == "Paper" && computerChoice == "Rock") {
            resultMessage = "You win!" // winning conditions
        } else {
            resultMessage = "You lose!" // if none of the winning conditions match, the player loses
        }
    }
}

#Preview {
    RockPaperScissorsView()
}
