//
//  ContentView.swift
//  TicTacToeV1
//
//  Created by Keiko Cheung on 2/10/25.
//

import SwiftUI
//this has the UI


struct StartView: View {
    //let's create state properties to keep track of gametype, names of the users playing the game
    @EnvironmentObject var game:GameService
    
    @State private var gameType:GameType = .undetermined
    @State private var yourName = ""
    @State private var opponentName = ""
    
    @FocusState private var focus: Bool //is focus on the keyboard, makes sure typing functionality is gone
    
    @State private var startGame = false

    var body: some View {
        VStack { //vertical stack is the orientation of the options in the picker
            Picker("Select the game", selection: $gameType){//$is the value of the gameType, picker is the drop down
                Text("Select Game Type").tag(GameType.undetermined)
                Text("Two sharing a device").tag(GameType.single)
                Text("Challenge a bot").tag(GameType.bot)
                Text("Challenge a friend").tag(GameType.peer)
            } //picker ends
            .padding()
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            VStack{
                switch gameType {
                case .single:
                    TextField("Your Name", text: $yourName)
                    TextField("Your Opponent Name", text: $opponentName)
                case .bot:
                    TextField("Your Name", text: $yourName)
                case .peer:
                    EmptyView()
                case .undetermined:
                    EmptyView()
                }
            }//vstack on switch gametype ends here
            .padding()
            .textFieldStyle(.roundedBorder)
            .focused($focus) //focus on text input fields
            .frame(width:350)
            
            if gameType != .peer {
                Button("Start Game"){
                    //set up the game RM
                    focus = false
                    startGame.toggle()
                }//end of button code
                .buttonStyle(.borderedProminent)
                .disabled(gameType == .undetermined || yourName.isEmpty || (gameType == .single && opponentName.isEmpty))
                Image("welcomeScreen")
            }
            Spacer()
        }//vstack picker ends here
        .padding() // all modifiers have the .smth
        .navigationTitle("Tic-Tac-Toe")
        //fullscreen cover based on dismissing the modal cover
        .fullScreenCover(isPresented: $startGame) {
            GameView()
        }
//            place GameView() here RM
    }
}

#Preview {
StartView()
        .environmentObject(GameService())
    //RM revisits
    //create a array/funcation called winning moves, check who won, given sequence
}
