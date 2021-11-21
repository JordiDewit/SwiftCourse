import SwiftUI
 
 


// This is the main view or the main box
// a view is a input and output area
struct EmojiMemoryGameView: View //ContentView behaves like a view
{
    @ObservedObject var viewModel: EmojiViewModel //@observedObject rebuild at change
   
    
    var body: some View //body behaves also like another view = "some view"
    {
        
        VStack
        {
            Text("Memorize")
                .font(.largeTitle)
            
            ScrollView
            {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65, maximum: 75))]) // stack of elements next to eachother
                {
                    //repeating card views to have multiple cards
                    //use every emoji in the emoji array
                    ForEach(viewModel.cards)
                    {   card in // /.self is used to identify each element
                        cardView(card)
                            .aspectRatio(2/3, contentMode: .fit) // provides a nice card shape
                            .onTapGesture
                            {
                                viewModel.choose(card: card)
                            }
                    }
                }
            }
            .padding()
            .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)//color of border is red
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
        static let cornerRadius: CGFloat = 20
        static let linewidth: CGFloat = 3
        static let fontScale: CGFloat = 0.9
    }
}
























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiViewModel()
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.light) //dark and light mode
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
