import SwiftUI
 
 
 

// This is the main view or the main box
// a view is a input and output area
struct ContentView: View //ContentView behaves like a view
{
    
    var body: some View //body behaves also like another view = "some view"
    {
        RoundedRectangle(cornerRadius: 20.0)
            .stroke(lineWidth: 3) //border with a width of 3px
            .padding()            //padding
            .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)//color of border is red
        
     //   Text("Memorize").font(.largeTitle).padding()
    }
    
}






































// This shows our main view above
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
