import SwiftUI
 
 


// This is the main view or the main box
// a view is a input and output area
struct ContentView: View //ContentView behaves like a view
{
    //array of emojis
    var emojis = ["🚗", "🚕", "🚌", "🚎","🏎","🚓","🚑","🛻","🚠","🛵","🚝","✈️","🚀", "test1", "test2", "test3"]
    @State var emojiCount = 4
    
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
                    ForEach(emojis[0..<emojiCount], id: \.self)
                    {   emoji in // /.self is used to identify each element
                        cardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit) // provides a nice card shape
                    }
                }
                .padding()
                .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)//color of border is red
            }
         
        }
     
    }
}
    
// this is a card view
struct cardView: View
{
    var content: String
    // you can't have variables without a value
    // use @State when this variable is changed and build an other view
    @State var isFaceUp: Bool = true
    
    var body: some View
    {
        ZStack // Puts all elements on top of eachother inside the zstack container
        {
            let shape = RoundedRectangle(cornerRadius: 20.0) //you use let when you are defining a constant
            
             if isFaceUp
             {
                shape
                    .fill() // creating a white background
                    .foregroundColor(.white)
                shape
                    .stroke(lineWidth: 3) //border with a width of 3px
                Text(content)
                    .font(.largeTitle)
             }else
             {
                shape.fill()
             }
        }
        .onTapGesture { // when you tap on a cardview it will change this variable
            isFaceUp = !isFaceUp
        }
    }
}







































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light) //dark and light mode
        ContentView()
            .preferredColorScheme(.dark)
    }
}
