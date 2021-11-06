import SwiftUI
 
 


// This is the main view or the main box
// a view is a input and output area
struct ContentView: View //ContentView behaves like a view
{
    
    var body: some View //body behaves also like another view = "some view"
    {
        HStack // stack of elements next to eachother
        {
            //repeating card views to have multiple cards
            cardView()
            cardView()
            cardView()
            cardView()
        }
        .padding()            //padding
        .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)//color of border is red
    }
    
}
    
// this is a card view
struct cardView: View
{
    // you can't have variables without a value
    var isFaceUp: Bool = true
    
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
                Text("🚗")
                    .font(.largeTitle)
                    .padding()
             }else
             {
                shape.fill()
             }
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
