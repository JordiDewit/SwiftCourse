import Foundation
import SwiftUI
//This is the model
struct MemoryGame<CardContent> //generic type for the content of MemoryGame.card
{
    // attribute list of cards
    private(set) var cards: Array<Card> //only the choose function can modify the array
    
    //functions
    func choose(card: Card)
    {
        
    }
    //init
    init(numberOfPairsOfCards: Int, createContent: (Int) -> CardContent)
    {
        cards = Array<Card>()
        // add numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards
        {
            let content: CardContent = createContent(pairIndex)
            cards.append(Card(isFaceUp: false, isMatched: false, content: content))
            cards.append(Card(isFaceUp: false, isMatched: false, content: content))
        }
    }
    struct Card //Card is a part of the memorygame
    {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent //generic or don't care type
    }
}


