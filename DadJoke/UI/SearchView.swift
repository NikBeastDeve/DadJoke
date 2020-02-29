//
//  SearchView.swift
//  DadJoke
//
//  Created by Nikita Galaganov on 07.02.2020.
//  Copyright © 2020 Nikita Galaganov. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State private var query: String = ""
    @ObservedObject var fetcher = SearchJokesFetcher()
    
    var body: some View {
        VStack {
            if fetcher.isConnectedToInternet{
                TextField("Start your search here 🔍", text: $query, onCommit: fetch)
                    .padding()
                    .border(Color("primary"), width: 3)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))

                VStack{
                    if(fetcher.isLoading) {
                        VStack(alignment: .center) {
                            Spacer()
                            ActivityIndicator(isAnimating: fetcher.isLoading)
                            .configure {
                                $0.hidesWhenStopped = true
                            }
                            Text("Loading...")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                    }else{
                        if(fetcher.isEmpty){
                            Spacer()
                            Text("No results for " + "\"" + query + "\"")
                            Spacer()
                        }else{
                            List(fetcher.searchJokes){ joke in
                                JokeCardView(joke: joke)
                            }
                            ActivityIndicator(isAnimating: fetcher.isLoading)
                                .configure {
                                    $0.hidesWhenStopped = true
                                }
                                .onAppear {
                                    self.fetcher.page = self.fetcher.page + 1
                            }
                        }
                    }
                }
            }else{
                Spacer()
                Button(action: {self.fetcher.retryConnection()}) {
                    Text("No connection to Network" + "\n" + "Tap here to retry")
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 30))
                            .minimumScaleFactor(0.8)
                }
                Spacer()
            }
        }
            .navigationBarTitle(Text("Search"))
    }
    
    private func fetch() {
        fetcher.search(page: 1, limit: 30, term: query)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
