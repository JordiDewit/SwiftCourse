import SwiftUI
 
 


// This is the main view or the main box
// a view is a input and output area
struct EmojiMemoryGameView: View //ContentView behaves like a view
{
    @ObservedObject var viewModel: EmojiViewModel //@observedObject rebuild at change
   
    
    var body: some View //body behaves also like another view = "some view"
    {
            AspectVGrid(items: viewModel.cards, aspectRatio: 2/3, content: { card in
               createCardView(for: card)
            })
            .padding(.horizontal)
            .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)//color of border is red
    }
    
    @ViewBuilder
    private func createCardView(for card: EmojiViewModel.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        }else {
            cardView(card)
                .padding(4)
                .onTapGesture{
                    viewModel.choose(card: card)
                }
        }
    }
}
    
// this is a card view
struct cardView: View
{
    private let card: MemoryGame<String>.Card
    
    //initialisation
    init(_ card: EmojiViewModel.Card)
    {
        self.card = card
    }
    
    var body: some View
    {
        GeometryReader(content: { // scaling on screensize
            geometry in
            ZStack // Puts all elements on top of eachother inside the zstack container
            {
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 90-90)) // pie shape
                        .opacity(0.5)
                        .padding(5)
                    Text(card.content)
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false))
                        .font(Font.system(size: DrawingConstants.fontSize))
                        .scaleEffect(scale(thatFits: geometry.size))
                        
            } 
            .cardify(isFaceUp: card.isFaceUp) // self made viewmodifier
        })
    }
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.65
        static let fontSize: CGFloat  = 32
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiViewModel()
        game.choose(card: game.cards.first!)
        return EmojiMemoryGameView(viewModel: game).preferredColorScheme(.dark)
        
    }
}
