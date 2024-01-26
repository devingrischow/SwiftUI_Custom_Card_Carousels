//
//  AnimationTest.swift
//  SwiftUI_Custom_Card_Carousels
//
//  Created by Devin Grischow on 12/13/23.
//

import SwiftUI

struct AnimationTest: View {
    
    @State private var animate = false
    
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .offset(y: animate ? 50 : 0) //starts at 50, goes to 0
                .opacity(animate ? 1 : 0.5) //starts as semi transparent then goes to full
                .animation(.easeIn(duration: 3), value: animate) //animation type and when to preform it
            //ladadadadadadadadadada
            Button("Animate"){
                animate.toggle()
            }.foregroundColor(.red)
        }
        
        
        
    }
}

struct AnimationTest_Previews: PreviewProvider {
    static var previews: some View {
        AnimationTest()
    }
}
