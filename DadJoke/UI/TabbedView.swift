//
//  TabbedView.swift
//  DadJoke
//
//  Created by Nikita Galaganov on 07.02.2020.
//  Copyright © 2020 Nikita Galaganov. All rights reserved.
//

import SwiftUI

struct TabbedView: View {
    
    var body: some View {
            VStack {
                TabView {
                   NavigationView {
                       FeedView()
                   }
                   .tag(0)
                   .tabItem {
                       Image(systemName: "list.bullet")
                       Text("Feed")
                    }
                    
                    NavigationView {
                        SearchView()
                    }
                    .tag(1)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    
                    NavigationView {
                        FavView()
                    }
                    .tag(2)
                    .tabItem {
                        Image(systemName: "suit.heart")
                        Text("Favourites")
                    }
                }
                    .animation(.linear)
                    .accentColor(.red)
            }
        }
}

struct TabbedView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView()
    }
}
