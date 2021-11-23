import SwiftUI
 
 


// This is the main view or the main box
// a view is a input and output area
struct EmojiMemoryGameView: View //ContentView behaves like a view
{
    @ObservedObject var viewModel: EmojiViewModel //@observedObject rebuild at change
   
    @Namespace private var dealingNamespace
    
    var body: some View //body behaves also like another view = "some view"
    {
        ZStack(alignment: .bottom){
            VStack{
                gameBody
                HStack{
                    shuffle
                    Spacer()
                    restart
                }
                .padding(.horizontal)
            }
            deckBody
        }
        .padding()

    }
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiViewModel.Card){
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiViewModel.Card) -> Bool {
        return !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiViewModel.Card) -> Animation {
        var delay = 0.0
        
        if let i = viewModel.cards.firstIndex(where: { $0.id == card.id }){
            delay = Double(i) * (CardConstants.totalDealDuration / Double(viewModel.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiViewModel.Card) -> Double {
        -Double(viewModel.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    
    var gameBody: some View{
        AspectVGrid(items: viewModel.cards, aspectRatio: 2/3, content: { card in
            if isUndealt(card) || card.isMatched && !card.isFaceUp {
                Color.clear
            }else {
                cardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture{
                        withAnimation{
                            viewModel.choose(card: card)
                        }
                    }
            }
        })
        .padding(.horizontal)
        .foregroundColor(CardConstants.color)//color of border is red
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(viewModel.cards.filter(isUndealt)) { card in
                cardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
                    for card in viewModel.cards {
                        withAnimation(dealAnimation(for: card)){
                        deal(card)
                    }
                }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation(.easeInOut(duration: 1)){
                viewModel.shuffle()
            }
        }
    }
    
    var restart: some View {
        Button("Restart") {
            withAnimation{
                dealt = [] // empty dealt cards
                viewModel.restart()
            }
        }
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
    
}
    
// this is a card view
struct cardView: View
{
    private let card: MemoryGame<String>.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    
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
                        Group{
                            if(card.isConsumingBonusTime){
                                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedBonusRemaining) * 360 - 90)) // pie shape
                                    .onAppear{
                                        animatedBonusRemaining = card.bonusRemaining
                                        withAnimation(.linear(duration: card.bonusTimeRemaining)){
                                            animatedBonusRemaining = 0
                                        }
                                    }
                            }else{
                                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusRemaining) * 360 - 90)) // pie shape
                            }
                        }
                        .padding(5)
                        .opacity(0.5)
                    
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
        return EmojiMemoryGameView(viewModel: game).preferredColorScheme(.dark)
        
    }
}
