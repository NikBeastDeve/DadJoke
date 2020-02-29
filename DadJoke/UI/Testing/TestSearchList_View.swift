//
//  TestSearchList_View.swift
//  DadJoke
//
//  Created by Nikita Galaganov on 10.02.2020.
//  Copyright © 2020 Nikita Galaganov. All rights reserved.
//

import SwiftUI

struct TestSearchList_View: View {
    @State private var query: String = "Swift"
    @ObservedObject var fetcher = SearchJokesFetcher()
    
    var body: some View {
        VStack {
            TextField("Type something...", text: $query, onCommit: fetch)
            List(fetcher.searchJokes){ joke in
                JokeCardView(joke: joke)
            }
        }
            .navigationBarTitle(Text("Search"))
    }
    
    private func fetch() {
        fetcher.search(page: 1, limit: 30, term: query)
    }
}

struct TestSearchList_View_Previews: PreviewProvider {
    static var previews: some View {
        TestSearchList_View()
    }
}
