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
        GeometryReader(content: {
            geometry in
            ZStack // Puts all elements on top of eachother inside the zstack container
            {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius) //you use let when you are defining a constant
                
                if card.isFaceUp{
                    shape
                        .fill() // creating a white background
                        .foregroundColor(.white)
                    shape
                        .stroke(lineWidth: DrawingConstants.linewidth) //border with a width of 3px
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 90-90)) // pie shape
                        .opacity(0.5)
                        .padding(DrawingConstants.circlePadding)
                    Text(card.content)
                        .font(font(in: geometry.size))
                 }else if card.isMatched {
                     shape.opacity(0) //you can't see the matched cards anymore
                 }else{
                    shape.fill()
                 }
            }
        })
    }
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat  = 15
        static let linewidth: CGFloat     = 3
        static let fontScale: CGFloat     = 0.65
        static let circlePadding: CGFloat = 2
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiViewModel()
        game.choose(card: game.cards.first!)
        return EmojiMemoryGameView(viewModel: game).preferredColorScheme(.dark)
        
    }
}
