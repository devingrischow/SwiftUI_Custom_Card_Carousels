//
//  ContentView.swift
//  SwiftUI_Custom_Card_Carousels
//
//  Created by Devin Grischow on 11/18/23.
//

import SwiftUI

let x:Int = 4

struct ContentView_Previews:PreviewProvider {
    
    
    
    
    static var previews: some View{
        
        
            
            
            DynamicCarouselWithCards(cardHeight: 500, cardWidth: 300,cardViews: [
            
                
                
                AnyView(VStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 294, height: 392.48)
                        .background(
                          AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/easyeats-43b0d.appspot.com/o/superCrop.webp?alt=media&token=5aaeec33-85c8-4405-9081-80ca7c28e79a"))
    //                        .resizable()
    //                        .aspectRatio(contentMode: .fill)
    //
    //                        .clipped()
                        )
                        .cornerRadius(15)
                        .offset(x: 0, y: -0)
                    Text("The Food is in The Image")
                }),
                
                AnyView(Text("Guitar Hero Guitar Hero")),
                
                AnyView(Text("Test 123")),
                
                AnyView(Text("Guitar Hero")),
                
                AnyView(Text("Guitar Hero")),
                
                AnyView(Text("Guitar Hero")),
                
                AnyView(Text("Guitar Hero")),
                
                AnyView(Text(x.description)),
                
                AnyView(Text("Guitar Hero")),
                
                AnyView(Text("Guitar Hero")),
                
                AnyView(Text("Guitar Hero")),
                
                AnyView(Text("Guitar Hero")),
                AnyView(Button(){
                    print("Hello World!")
                }label: {
                        Text("Hello World")
                }),
                AnyView(Button(){
                    print("Hello World!")
                }label: {
                        Text("Hello World")
                }),AnyView(Button(){
                    print("Hello World!")
                }label: {
                        Text("Hello World")
                })
                
                
                
                
                
            ])//End Of Carousel
        }
        
    }

