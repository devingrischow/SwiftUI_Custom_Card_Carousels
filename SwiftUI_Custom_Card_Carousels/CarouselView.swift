//
//  CarouselView.swift
//  SwiftUI_Custom_Card_Carousels
//
//  Created by Devin Grischow on 12/3/23.
//  Videos Used For Carousel https://www.youtube.com/watch?v=fB5MzDD1PZI&list=PLXDTrAZBpeSen1xGBRywUM7CmK47A802j&index=2&t=1391s



import SwiftUI

struct CarouselView: View {
    
    @GestureState private var dragState = DragState.inactive
    @State var carouselLocation = 0
    
    @State private var animationState:Bool = false
    
    var cardHeight:CGFloat
    
    var cardWidth:CGFloat
    
    var cardViews:[AnyView]
    
    /*MARK:onDragEnd()
     Handles what to do when letting go of the card
     
     If the card is dragged beyond a certain point, automatically Swap it
     */
    private func onDragEnded(drag: DragGesture.Value) {
        print("Drag Ended")
        let dragThreshHold:CGFloat = 200 // If the Drag Goes beyond This Value, Move to the Next Card
        
        if drag.predictedEndTranslation.width > dragThreshHold || drag.translation.width > dragThreshHold{
            carouselLocation = carouselLocation - 1
            animationState.toggle()

        }else if (drag.predictedEndTranslation.width) < (-1 * dragThreshHold) || (drag.translation.width) < (-1 * dragThreshHold){
            carouselLocation = carouselLocation + 1
            animationState.toggle()

        }
    }
    
    
    
    
    
    //MARK: View Body
    var body: some View {
        ZStack{
            VStack{
                Text("\(dragState.translation.width)")
                Text("\(carouselLocation)")
                Text("\(relativeLoc()) / \(cardViews.count - 1)")
                Spacer()
            }
            
            VStack{
                ZStack{
                    ForEach(0..<cardViews.count){i in
                        VStack{
                            Spacer()
                            self.cardViews[i]
                            
                            //Attributes for the Cards
                                //Old Width: 300
                                .frame(width:cardWidth, height: self.getHeight(i))
                                .background(Color.white)

                                .cornerRadius(10)

                                .shadow(radius: 3)
                            
                                .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0,initialVelocity: 10.0), value: animationState)

                                //Currently Causing major issues, convert it to modern format
                                .opacity(self.getOpacity(i))
                            
                            

                                .offset(x: self.getOffset(i))
                            Spacer()
                                    
                                    
                            
                        }
                        
                    }
                }
                .gesture(
                    
                    DragGesture()
                        .updating($dragState) { drag, state, transaction in
                            state = .dragging(translation: drag.translation)

                    }
                        .onEnded(onDragEnded)
                    
                    
//                    withAnimation(.interpolatingSpring(stiffness: 300.0, damping: 30.0,initialVelocity: 10.0)){
//
//                    }
//
                    
                ) //Bottom Of Gesture
                Text("\(relativeLoc() + 1)/\(cardViews.count)" )
            }
        }
    }
    
    
    

    //relativeLoc @ 10:07
    /*
     MARK: relativeLoc()
     The relative Location of the card compared to where it current is
     
     //Backwards has a cap of 7000, no issue but thats the purpose of the math
     */
    func relativeLoc() -> Int{
        return ((cardViews.count * 10000) + carouselLocation) % cardViews.count
    }

    
    
    
    
    /*
     MARK: getOpacity:
     Get opacity manages the of the other cards
     pretty much when not close to the other view and in the off Space, become invisible
     
     otherwise make them present and visible
     
     i is the index of the current card
     
     */

    func getOpacity(_ i:Int) -> Double {
        
        //if the conditions are meet, become visible (Opaque) if not, become invisible
        
        if i == relativeLoc()
            || i + 1 == relativeLoc()
            || i - 1 == relativeLoc()
            
            || i + 2 == relativeLoc()
            || i - 2 == relativeLoc()
            
            || (i + 1) - cardViews.count == relativeLoc()
            || (i - 1) + cardViews.count == relativeLoc()
            
            || (i + 2) - cardViews.count == relativeLoc()
            || (i - 2) + cardViews.count == relativeLoc()
        {
            return 1
        } else {
            return 0
        }
            
        
    }
    
    
    
    /*
     MARK: getHeight():
      takes the index and depending on what the index of the card is compared to the relalativelocation of the others,

      if the index card is the main center card, set its height to be the height of the set amount, if not set its height to be smaller than the main card (by 100)
     */
    func getHeight(_ i:Int) -> CGFloat{
        
        if i == relativeLoc(){
            //Main Card
            return cardHeight
        } else {
            //Side Card
            return cardHeight - 100
        }
        
    }


    //MARK: getOffset()
    func getOffset(_ i:Int) -> CGFloat{
        
        //This Sets up the Central Offset
        if (i) == relativeLoc()
        {
            //Set Offset Of Central
            return self.dragState.translation.width
        }
        //These Set Up The +/- 1
        else if
            (i) == relativeLoc() + 1
                ||
                (relativeLoc() == cardViews.count - 1 && i == 0)
        {
            //Set Offset + 1
                                                    //old value was 300: Presumed Width
            return self.dragState.translation.width + (cardWidth + 20)
        }
        else if
            (i) == relativeLoc() - 1
            ||
            (relativeLoc() == 0 && (i) == cardViews.count - 1)
        {
         //Set Offset -1
                                            //old value was 300: Presumed Width
            return self.dragState.translation.width - (cardWidth + 20)
        }
         //These Set Up The Offset for +/- 2
        else if
            (i) == relativeLoc() + 2
            ||
            (relativeLoc() == cardViews.count-1 && i == 1)
            ||
            (relativeLoc() == cardViews.count-2 && i == 0)
        {
            //Set Offset + 2
                                            //old value was 300: Presumed Width
            return self.dragState.translation.width + (2*(cardWidth + 20))
        }
        else if
            (i) == relativeLoc() - 2
            ||
            (relativeLoc() == 1 && i == cardViews.count - 1)
            ||
            (relativeLoc() == 0 && i == cardViews.count - 2)
        {
            //Set Offset -2
                                            //old value was 300: Presumed Width
            return self.dragState.translation.width - (2*(cardWidth + 20))
        }
        //These Set Up The Offset of +/- 3
        else if
            (i) == relativeLoc() + 3
            ||
            (relativeLoc() == cardViews.count - 1 && i == 2)
            ||
            (relativeLoc() == cardViews.count-2 && i == 1)
            ||
            (relativeLoc() == cardViews.count-3 && i == cardViews.count - 3)
        {
            //Set Offset + 3
                                                //old value was 300: Presumed Width
            return self.dragState.translation.width + (3*(cardWidth+20))
        }
        else if
            (i) == relativeLoc() - 3
                ||
                (relativeLoc() == 2 && i == cardViews.count - 1)
                ||
                (relativeLoc() == 1 && i == cardViews.count - 2)
                ||
                (relativeLoc() == 0 && i == cardViews.count - 3)
        {
            //Set Offset - 3
                                            //old value was 300: Presumed Width
            return self.dragState.translation.width - (3*(cardWidth+20))
        }
        //For The Rest Of the Cards, Just give them a really High offset and hide them Far Away
        else {
            return 10000
        }
            
    }

    
    
    
    
}




//struct CarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarouselView()
//    }
//}



/*
 MARK: DragState:
 meant to easily handle the the various states of the carousel view with a simple variable call
 
 VIDEO EXP: Handles How far we have dragged the carousel view and if and when we are dragging it
 Drag gesture is tracked with the state variable to set the offset of the x and y offset
 */
enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    //Variable that handles translation amount when inactive and dragging
    var translation:CGSize {
        
        switch self {
            
        case .inactive: //card is inactive
            return .zero
            
        case .dragging(let translation):
            return translation
            
        }
    }
    
    //Variable that handles the state of a card being dragged
    var isDragging:Bool {
        switch self {
            
        case .inactive:
            return false
            
        case .dragging:
            return true
        
        }
        
    }
    
    
}



