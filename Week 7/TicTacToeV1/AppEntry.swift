//
//  TicTacToeV1App.swift
//  TicTacToeV1
//
//  Created by Keiko Cheung on 2/10/25.
//

import SwiftUI

@main
struct AppEntry: App {
    @StateObject var game = GameService()//creates a instance of the class
    
    var body: some Scene {
        WindowGroup {
            StartView()
        }
    }
}
