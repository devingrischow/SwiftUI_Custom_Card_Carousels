//
//  SwiftUI_Custom_Card_CarouselsApp.swift
//  SwiftUI_Custom_Card_Carousels
//
//  Created by Devin Grischow on 11/18/23.
//

import SwiftUI

@main
struct SwiftUI_Custom_Card_CarouselsApp: App {
    var body: some Scene {
        WindowGroup {
            
            
            
            
            
            PostAppearAnimationCarouselView(cardHeight: 500, cardWidth: 300,cardViews: [
            
                AnyView(Circle().frame(width: 50, height: 50).foregroundColor(.purple)),
                
                AnyView(Text("This is a test of a card!")),
                
                AnyView(VStack{
                    Text("Hello World!")
                    Text("This is a Sub Text!")
                         
                }),
                
                AnyView(Text("Guitar Hero")),
                
                
                
                AnyView(Text("Guitar Hero")),
                
                AnyView(Text("Guitar Hero")),
                
                
                
                
                
                
                
            ])//End Of Carousel
        }
    }
}
