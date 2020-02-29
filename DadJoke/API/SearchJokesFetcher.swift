//
//  SearchJokesFetcher.swift
//  DadJoke
//
//  Created by Nikita Galaganov on 08.02.2020.
//  Copyright © 2020 Nikita Galaganov. All rights reserved.
//

import Foundation
import Combine
    
public class SearchJokesFetcher: ObservableObject {
    @Published var searchJokes = [Joke]()
    @Published var isLoading = false
    @Published var limit: Int = 1
    @Published var term: String = "joke"
    @Published var isEmpty: Bool = false
    @Published var isConnectedToInternet = true
    @Published var page: Int = 1{
        willSet {
            self.search(page: self.page, limit: self.limit, term: self.term)
            objectWillChange.send()
        }
    }
    
    init(){
        isConnectedToInternet = Connectivity.isConnectedToInternet()
    }
        
    func search(page: Int, limit: Int, term: String) {
        if Connectivity.isConnectedToInternet() {
            self.isConnectedToInternet = true
            API.searchForJokes(page: page, limit: limit, term: term) { (result, statusCode) in
                switch result {
                case .success(let value):
                    self.searchJokes = value.results
                    self.isEmpty = self.searchJokes.isEmpty
                    self.isLoading = false
                case .failure(let err):
                    print(err.localizedDescription)
                    self.isLoading = false
                }
            }
        }else{
            self.isConnectedToInternet = false
            print("No connection/search section")
        }
    }
    
    func retryConnection() {
        isConnectedToInternet = Connectivity.isConnectedToInternet()
    }
}

