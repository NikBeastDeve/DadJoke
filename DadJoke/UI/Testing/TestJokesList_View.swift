//
//  TestJokesList_View.swift
//  DadJoke
//
//  Created by Nikita Galaganov on 10.02.2020.
//  Copyright © 2020 Nikita Galaganov. All rights reserved.
//

import SwiftUI

struct TestJokesList_View: View {
    var joke: Joke = Joke(id: "123456789", joke: " -  'What did celery say when he broke up with his girlfriend? She wasn't right for me, so I really don't carrot all.'")
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        List{
            JokeCardView_0(joke: joke)
            JokeCardView_0(joke: joke)
            JokeCardView_0(joke: joke)
            JokeCardView_0(joke: joke)
            JokeCardView_0(joke: joke)
        }
    }
}

struct TestJokesList_View_Previews: PreviewProvider {
    static var previews: some View {
        TestJokesList_View()
    }
}

struct JokeCardView_0: View {
    @State private var isShowing = false
    @State var joke: Joke
    var body: some View {
        VStack(alignment: .center){
                Button(action: {
                    self.isShowing.toggle()
                }) {
                    Text(joke.joke)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(15)
                        .frame(minHeight:  160, maxHeight:  220)
                        .frame(minWidth: UIScreen.main.bounds.width - 60, maxWidth: UIScreen.main.bounds.width - 60)
                        .background(Color.green)
                        .cornerRadius(10)
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName: "suit.heart")
                            .foregroundColor(.red)
                    }
                        .padding()
                }
                    .background(Color.green)
                    .cornerRadius(10)
                    .frame(minHeight:  160, maxHeight:  300)
                    .sheet(isPresented: $isShowing) {
                    JokeView(joke: self.$joke)
                }
            }
                .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 0)
                .padding(15)
                .navigationBarTitle(Text("Jokes Daily"))
    }
}

/*
 .background(
     LinearGradient(gradient: Gradient(colors: [.pink, .purple, .blue]), startPoint: .topTrailing, endPoint: .bottomLeading)
         .cornerRadius(10)
 )
 */

/*
 Gradient items list:
 
 struct JokeCardView: View {
     @State var joke: String
     @State private var isShowing = false
     var body: some View {
         VStack(alignment: .center){
                 Button(action: {
                     self.isShowing.toggle()
                 }) {
                     Text(joke)
                         .fontWeight(.bold)
                         .foregroundColor(.white)
                         .padding(15)
                         .frame(minHeight:  160, maxHeight:  250)
                         .frame(minWidth: UIScreen.main.bounds.width - 60, maxWidth: UIScreen.main.bounds.width - 60)
                 }.sheet(isPresented: $isShowing) {
                     JokeView(joke: self.$joke)
                 }
             }
                 .background(
                 LinearGradient(gradient: Gradient(colors: [.pink, .purple, .blue]), startPoint: .topTrailing, endPoint: .bottomLeading)
                     .cornerRadius(10)
             )
                 .shadow(color: Color.black, radius: 10, x: 0, y: 0)
                 .padding(15)
                 .navigationBarTitle(Text("Jokes Daily"))
     }
 }

 */
