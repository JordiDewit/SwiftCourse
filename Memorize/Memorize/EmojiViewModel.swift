import Foundation
import SwiftUI

//The view model for the emoji memory game



class EmojiViewModel: ObservableObject// observer for changes in the view(presentation of data) and model(storage of data)
{
    //type alias for MemoryGame<String>.Card
    typealias Card = MemoryGame<String>.Card
    //PROPERTIES
    private static let emojis = ["🚗", "🚕", "🚌", "🚎","🏎","🚓","🚑","🛻","🚠","🛵","🚝","✈️","🚀", "🚇", "🛳", "🚁"] //you don't need to init to use this constant
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    // @Published provides that every change will rebuild the view
    //String because this is the emoji version of memory game and only the code in this viewmodel can modify the model
    //You say there must be 4 pairs or 8 cards be made
    var cards: Array<Card>
    {
        return model.cards
    }
    

    //FUNCTIONS
    
    static func createMemoryGame() -> MemoryGame<String>
    {
        MemoryGame<String>(numberOfPairsOfCards: 5, createContent: { pairIndex in
                  emojis[pairIndex]
            })
    }
    
    //USER INTENTS
    func choose(card: Card)
    {
        model.choose(card: card)
    }

}
