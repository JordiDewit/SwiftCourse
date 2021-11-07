import Foundation
import SwiftUI
//This is the model
struct MemoryGame<CardContent> where CardContent: Equatable//generic type for the content of MemoryGame.card
{ // Equatable provides you can't compare
    // attribute list of cards
    private(set) var cards: Array<Card> //only the choose function can modify the array
    
    
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    
    
    
    //functions
    mutating func choose(card: Card)
    {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),//checks or the chosenindex is not nil
               !cards[chosenIndex].isFaceUp,//checks if chosen card is not already face up
               !cards[chosenIndex].isMatched //checks if it is not already matched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard
            {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content
                {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            }else
            {
                for index in 0..<cards.count
                {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
            //reverse value
        }
    }
    
    
    
    //init
    init(numberOfPairsOfCards: Int, createContent: (Int) -> CardContent)
    {
        cards = Array<Card>()
        // add numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards
        {
            let content: CardContent = createContent(pairIndex)
            cards.append(Card(id: pairIndex*2, isFaceUp: false, isMatched: false, content: content))
            cards.append(Card(id: pairIndex*2+1, isFaceUp: false, isMatched: false, content: content))
        }
        cards.shuffle()
    }
    
    
    
    //card
    struct Card: Identifiable //Card is a part of the memorygame and behaves like a identifiable
    {
        var id: Int // a unique id
        
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent //generic or don't care type
    }
}


