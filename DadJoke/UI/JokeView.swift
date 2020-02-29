//
//  JokeView.swift
//  DadJoke
//
//  Created by Nikita Galaganov on 10.02.2020.
//  Copyright © 2020 Nikita Galaganov. All rights reserved.
//

import SwiftUI

struct JokeView: View {
    @State private var isFav = false
    @Binding var joke: Joke
    @State private var joke_placeholder = "Hello"
    @EnvironmentObject var favFetcher: FavouritesFetcher
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text(" -  '" + joke.joke + "'")
                    .font(.system(size: 40))
                    .fontWeight(.light)
                    .padding()
                    .minimumScaleFactor(0.8)
                
                Spacer()
                
                Button(action: {
                    self.isFav.toggle()
                    if !self.favFetcher.isFavourite(joke: self.joke){
                        self.favFetcher.addToFavourites(joke: self.joke)
                        print("adding item, id: " + self.joke.id)
                    }else{
                        self.favFetcher.deleteFromFavourites(joke: self.joke)
                        print("deleting item, id: " + self.joke.id)
                    }
                }) {
                    HStack {
                        Image(systemName: favFetcher.isFavourite(joke: joke) ? "suit.heart.fill" : "suit.heart")
                        Text(favFetcher.isFavourite(joke: joke) ? "Remove from favourites" : "Add to favourites")
                            
                    }
                        .foregroundColor(.red)
                }
                    .frame(minHeight:  40, maxHeight:  60)
                    .frame(minWidth: UIScreen.main.bounds.width - 60, maxWidth: UIScreen.main.bounds.width - 60)
                    .border(Color.red, width: 3)
                    .padding()
                
                
            }
                .navigationBarTitle(Text("Dad Joke"))
        }
    }
}

struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView(joke: .constant(Joke(id: "123456789", joke: "What did celery say when he broke up with his girlfriend? She wasn't right for me, so I really don't carrot all.")))
    }
}
