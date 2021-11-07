import Foundation

//The view model for the emoji memory game



class EmojiViewModel // observer for changes in the view(presentation of data) and model(storage of data)
{
    //PROPERTIES
    static let emojis = ["🚗", "🚕", "🚌", "🚎","🏎","🚓","🚑","🛻","🚠","🛵","🚝","✈️","🚀", "🚇", "🛳", "🚁"] //you don't need to init to use this constant
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    //String because this is the emoji version of memory game and only the code in this viewmodel can modify the model
    //You say there must be 4 pairs or 8 cards be made
    var cards: Array<MemoryGame<String>.Card>
    {
        return model.cards
    }
    

    //FUNCTIONS
    
    static func createMemoryGame() -> MemoryGame<String>
    {
        MemoryGame<String>(numberOfPairsOfCards: 4, createContent: { pairIndex in
                  emojis[pairIndex]
            })
    }
    

}
