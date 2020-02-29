//
//  DadAPI.swift
//  DadJoke
//
//  Created by Nikita Galaganov on 31.01.2020.
//  Copyright © 2020 Nikita Galaganov. All rights reserved.
//

import Foundation
import Combine
    
public class JokesFetcher: ObservableObject {
    @Published var jokes = [Joke]()
    @Published var isLoading = true
    @Published var isTroubleWithLoading = false
    @Published var isConnectedToInternet = true
    @Published var limit: Int = 30
    @Published var page: Int = 1{
        willSet {
            load()
            objectWillChange.send()
        }
    }
    
    init(){
        load()
    }
        
    func load() {
        if Connectivity.isConnectedToInternet() {
            self.isConnectedToInternet = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(20000)) {
                if self.jokes.isEmpty{
                    self.isTroubleWithLoading = true
                }
            }
            
            API.getJokes(page:  self.page, limit: self.limit) { (result, statusCode) in
                switch result {
                case .success(let value):
                    print(self.page)
                    self.jokes += value.results
                    self.isLoading = false
                case .failure(let err):
                    print(err.localizedDescription)
                    self.isLoading = false
                }
            }
        }else{
            self.isConnectedToInternet = false
        }
    }
    
    func retryConnection() {
        isConnectedToInternet = Connectivity.isConnectedToInternet()
    }
}
