import SwiftUI
 
 
 

// This is the main view or the main box
// a view is a input and output area
struct ContentView: View //ContentView behaves like a view
{
    
    var body: some View //body behaves also like another view = "some view"
    {
        ZStack // Puts all elements on top of eachother inside the zstack container
        {
            RoundedRectangle(cornerRadius: 20.0)
                .stroke(lineWidth: 3) //border with a width of 3px
      
            
            Text("🚗")
                .font(.largeTitle)
                .padding()
        }
        .padding()            //padding
        .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)//color of border is red
       
        
     
    }
    
}






































// This shows our main view above
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
