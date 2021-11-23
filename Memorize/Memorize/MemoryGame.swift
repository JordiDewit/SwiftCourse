import Foundation
import SwiftUI
//This is the model
struct MemoryGame<CardContent> where CardContent: Equatable//generic type for the content of MemoryGame.card
{ // Equatable provides you can't compare
    // attribute list of cards
    private(set) var cards: Array<Card> //only the choose function can modify the array
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    {
        get // getter
        {
            return cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly //extension method
  
        }
        set //setter
        {
            cards.indices.forEach({cards[$0].isFaceUp = ($0 == newValue)})
        }
    }
    
    
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
                cards[chosenIndex].isFaceUp = true
            }else
            {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                
            }
        }
    }
    
    
    
    //init
    init(numberOfPairsOfCards: Int, createContent: (Int) -> CardContent)
    {
        cards = []
        // add numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards
        {
            let content: CardContent = createContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }

    }
    
    //Shuffle cards
    mutating func shuffle(){
        cards.shuffle()
    }
    
    
    //card
    struct Card: Identifiable //Card is a part of the memorygame and behaves like a identifiable
    {
        var isFaceUp = false {
                   didSet {
                       if isFaceUp {
                           startUsingBonusTime()
                       } else {
                           stopUsingBonusTime()
                       }
                   }
               }
        var isMatched = false {
                   didSet {
                       stopUsingBonusTime()
                   }
               }
               let content: CardContent
               let id: Int
        
        
        // MARK: - Bonus Time
               
               // this could give matching bonus points
               // if the user matches the card
               // before a certain amount of time passes during which the card is face up
               
               // can be zero which means "no bonus available" for this card
               var bonusTimeLimit: TimeInterval = 6
               
               // how long this card has ever been face up
               private var faceUpTime: TimeInterval {
                   if let lastFaceUpDate = self.lastFaceUpDate {
                       return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
                   } else {
                       return pastFaceUpTime
                   }
               }
               // the last time this card was turned face up (and is still face up)
               var lastFaceUpDate: Date?
               // the accumulated time this card has been face up in the past
               // (i.e. not including the current time it's been face up if it is currently so)
               var pastFaceUpTime: TimeInterval = 0
               
               // how much time left before the bonus opportunity runs out
               var bonusTimeRemaining: TimeInterval {
                   return max(0, bonusTimeLimit - faceUpTime)
               }
               // percentage of the bonus time remaining
               var bonusRemaining: Double {
                   return (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
               }
               // whether the card was matched during the bonus time period
               var hasEarnedBonus: Bool {
                  return isMatched && bonusTimeRemaining > 0
               }
               // whether we are currently face up, unmatched and have not yet used up the bonus window
               var isConsumingBonusTime: Bool {
                  return isFaceUp && !isMatched && bonusTimeRemaining > 0
               }
               
               // called when the card transitions to face up state
               private mutating func startUsingBonusTime() {
                   if isConsumingBonusTime, lastFaceUpDate == nil {
                       lastFaceUpDate = Date()
                   }
               }
               // called when the card goes back face down (or gets matched)
               private mutating func stopUsingBonusTime() {
                   pastFaceUpTime = faceUpTime
                   self.lastFaceUpDate = nil
               }
    }
}


extension Array{
    var oneAndOnly: Element? //optional don't care
    {
        if self.count == 1
        {
            return self.first //[0]
        }
        else
        {
            return nil
        }
    }
}




