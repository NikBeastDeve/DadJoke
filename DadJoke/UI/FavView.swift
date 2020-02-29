//
//  FavView.swift
//  DadJoke
//
//  Created by Nikita Galaganov on 11.02.2020.
//  Copyright © 2020 Nikita Galaganov. All rights reserved.
//

import SwiftUI

struct FavView: View {
    @EnvironmentObject var favFetcher: FavouritesFetcher
    
    var body: some View {
        VStack(alignment: .center){
            if(favFetcher.favJokes.isEmpty){
                Spacer()
                Text("No Favourites Jokes Yet" + "\n" + "😔")
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 35))
                    .minimumScaleFactor(0.8)
                Spacer()
            }else{
                List(favFetcher.favJokes){ joke in
                    JokeCardView(joke: joke)
                }
            }
        }
            .navigationBarTitle(Text("Favourites"))
    }
}

struct FavView_Previews: PreviewProvider {
    static var previews: some View {
        FavView()
    }
}
