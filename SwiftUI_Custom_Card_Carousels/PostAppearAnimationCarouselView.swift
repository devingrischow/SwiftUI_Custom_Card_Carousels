//
//  PostAppearAnimationCarouselView.swift
//  SwiftUI_Custom_Card_Carousels
//
//  Created by Devin Grischow on 12/11/23.
//



import SwiftUI

struct PostAppearAnimationCarouselView: View {
    
    //Max Drag Values
    let verticleDragThreshold:CGFloat = 69

    
    @GestureState private var dragState = DragState.inactive
    @State var carouselLocation = 0
    
    @State private var centralYOffset:CGFloat = 0
    @State private var animationState:Bool = false
    
    //State value for when full screen is revealed
    @State private var fullBoxAvalible:Bool = false
    
    //Animation state variable for if new card is displayed and needs to do initial popup for out of the way eat food food function
    @State private var animateEatHint:Bool = false
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
        
        //TODO: Create A Tester for height to see if the dragging card exceeeded the maximum Height
        if drag.predictedEndTranslation.height > verticleDragThreshold ||
            drag.translation.height > verticleDragThreshold{
            print("FUll BOXXO")
            fullBoxAvalible.toggle()
            
        }
        
        if drag.predictedEndTranslation.width > dragThreshHold || drag.translation.width > dragThreshHold{
            carouselLocation = carouselLocation - 1
            animationState.toggle()


        }else if (drag.predictedEndTranslation.width) < (-1 * dragThreshHold) || (drag.translation.width) < (-1 * dragThreshHold){
            carouselLocation = carouselLocation + 1
            animationState.toggle()
            print("Auto Dragged")
            //Toggle the next animation
            //isViewReady.toggle()
            
            withAnimation(.easeInOut(duration: 1)){
                animateEatHint.toggle()
            }    

        }//End Of Width Block
        
        
        
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
                                //.animation(.easeInOut(duration: 10), value: animateEatHint)
                            
                                .opacity(self.getOpacity(i))
                            
                            
                                
                                
                                //check if this is the main card
                            
                                //MARK: TODO UP DRAG
                                //ADD DRAG UP GESTURE for card
                                .offset(x: self.getOffset(i), y:self.getYOffset(i))
                            
                            //on the cards appearance set its new Y offset
                            
                            
                            //preform another animation when the animation value is changed
                        
                                
                            //check if new card is selectable
//                            if (i) == relativeLoc(){
//                                //start planting stuff to be animated here
//                                Text("Hello Howdy")
//                                    .transition(.move(edge: .top))
//                                    .opacity(animateEatHint ? 1 : 0) //start at invisible then go towards visible
//                                    .animation(.easeInOut(duration: 4), value: animateEatHint)
//
//
//                            }
                                
                                Spacer()
                            
                            
                            
                                
                            
                            
                            
                                
                            
                            
                        
                            
                            
                                                           
                            
                        
                            
                                    
                                    
                            
                        }
                        
                    }
                    //This is where the invisible Box should GO
                    
                    //Text("Bawk")

                    Rectangle()
                        .frame(width:cardWidth, height: 60)
                        .foregroundColor(.yellow)
                        .offset(y:210)
                        .zIndex(-1)
                    
                    
                }//end of Z Stack
                .gesture(
                    
                    DragGesture()
                        .updating($dragState) { drag, state, transaction in
                            state = .dragging(translation: drag.translation)
                            //animateEatHint.toggle()
                            //While drag is updating, also set the Y offset to 0
                            //animateEatHint.toggle()

                    }
                        .onEnded(onDragEnded)
                    
                    
//                    withAnimation(.interpolatingSpring(stiffness: 300.0, damping: 30.0,initialVelocity: 10.0)){
//
//                    }
//
                    
                ) //Bottom Of Gesture
                Text("Y: \(dragState.translation.height)")
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
        
        if (i) == relativeLoc(){
            //Main Card
            return cardHeight
        } else {
            //Side Card
            return cardHeight - 100
        }
        
    }
    
    
    //MARK getYOffset
    /*
     This Function will determine the what heights to make the other offsets
     
     All offsets besides can be default to 0 (or whatever best determined start number is) Then the main one will be unique, normally when not being animated it will be 0, but once animateFoodHint is changed it moves the card slightly up
     */
    func getYOffset(_ i:Int) -> CGFloat{
        //Max Drag Up Values for up drag
        
        //check views drag state, if dragging return 0
        
        //TODO: Maximum drag value check
        
        //Centeral Card Offset
        
        
        if abs(self.dragState.translation.height) >= verticleDragThreshold{ //If Statement to make sure drag value does not exceed maximum, if it does just set it to the max height
            
            //Set the max preview to avalible
            return verticleDragThreshold * -1
            
        }else if (i) == relativeLoc() && abs(self.dragState.translation.height) > abs(self.dragState.translation.width){//If Statement to Test Whether dragging up or sideways, favor up
            print("Dragging Up")
            return self.dragState.translation.height
        }else if fullBoxAvalible && (i) == relativeLoc(){ //Detects whteher the fullBox is avalible, if it is set the cards height to it
            return (animateEatHint ? (-1 * verticleDragThreshold) : 0 )
            
        }else if (i) == relativeLoc(){ //to make it preform the animation, also check to see if the animation state is true, if it is then preform it
            //Preform the animation parts
            print("Preform Animation")
            return (animateEatHint ? -30 : 0 ) //starts at 0 goes to 50 upon change
        }
        
        else{
            //All other cards can be ignored
            return 0
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



