//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Jordi Dewit on 06/11/2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiViewModel() 
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
