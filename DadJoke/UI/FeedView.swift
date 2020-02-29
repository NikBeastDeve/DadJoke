//
//  FeedView.swift
//  DadJoke
//
//  Created by Nikita Galaganov on 07.02.2020.
//  Copyright © 2020 Nikita Galaganov. All rights reserved.
//

import SwiftUI

struct FeedView: View {
    @State private var isShowingJokeView = false
    @ObservedObject var fetcher = JokesFetcher()
    var joke = " -  'What did celery say when he broke up with his girlfriend? She wasn't right for me, so I really don't carrot all.'"
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        VStack{
            if fetcher.isConnectedToInternet{
                if(fetcher.isLoading) {
                    VStack(alignment: .center) {
                        ActivityIndicator(isAnimating: fetcher.isLoading)
                        .configure {
                            $0.hidesWhenStopped = true
                        }
                        Text("Loading...")
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .foregroundColor(.gray)
                    }
                }else{
                    List{
                        ForEach(fetcher.jokes){ joke in
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
            else if fetcher.isTroubleWithLoading{
                Button(action: {self.fetcher.retryConnection()}) {
                    Text("No connection to Network" + "\n" + "Tap here to retry")
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 30))
                            .minimumScaleFactor(0.8)
                }
            }
            else{
                Button(action: {self.fetcher.retryConnection()}) {
                    Text("No connection to Network" + "\n" + "Tap here to retry")
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 30))
                            .minimumScaleFactor(0.8)
                }
            }
        }.navigationBarTitle(Text("Jokes Daily"))
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

struct JokeCardView: View {
    @State var joke: Joke
    @State private var isShowing = false
    var body: some View {
        VStack(alignment: .center){
                Button(action: {
                    self.isShowing.toggle()
                }) {
                    Text(" -  '"  + joke.joke + "'")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(15)
                            .frame(minHeight:  160, maxHeight:  250)
                            .frame(minWidth: UIScreen.main.bounds.width - 60, maxWidth: UIScreen.main.bounds.width - 60)
                            .background(Color.red)
                            .cornerRadius(10)
                }.sheet(isPresented: $isShowing) {
                    JokeView(joke: self.$joke)
                        .modifier(SystemServices())
                }
            }
                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 0)
                .padding(15)
    }
}
