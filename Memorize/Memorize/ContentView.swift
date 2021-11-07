import SwiftUI
 
 


// This is the main view or the main box
// a view is a input and output area
struct ContentView: View //ContentView behaves like a view
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
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75, maximum: 75))]) // stack of elements next to eachother
                {
                    //repeating card views to have multiple cards
                    //use every emoji in the emoji array
                    ForEach(viewModel.cards)
                    {   card in // /.self is used to identify each element
                        cardView(card: card)
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
    let card: MemoryGame<String>.Card
    
    var body: some View
    {
        ZStack // Puts all elements on top of eachother inside the zstack container
        {
            let shape = RoundedRectangle(cornerRadius: 20.0) //you use let when you are defining a constant
            
            if card.isFaceUp
             {
                shape
                    .fill() // creating a white background
                    .foregroundColor(.white)
                shape
                    .stroke(lineWidth: 3) //border with a width of 3px
                Text(card.content)
                    .font(.largeTitle)
             }else if card.isMatched {
                 shape.opacity(0) //you can't see the matched cards anymore
             }else
             {
                shape.fill()
             }
        }
    }
}







































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiViewModel()
        ContentView(viewModel: game)
            .preferredColorScheme(.light) //dark and light mode
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
