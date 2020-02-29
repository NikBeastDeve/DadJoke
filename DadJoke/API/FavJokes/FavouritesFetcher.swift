//
//  FavouritesFetcher.swift
//  DadJoke
//
//  Created by Nikita Galaganov on 11.02.2020.
//  Copyright © 2020 Nikita Galaganov. All rights reserved.
//

import Foundation

public class FavouritesFetcher: ObservableObject {
    
    private let saveKey = "FavJokesData"
    @Published public var favJokes: [Joke]{
        willSet {
            objectWillChange.send()
        }
    }
    
    init(){
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Joke].self, from: data) {
                self.favJokes = decoded
                return
            }
        }

        self.favJokes = []
    }
       
    func addToFavourites(joke: Joke){
        if !favJokes.contains(joke){
            favJokes.append(joke)
            if let encoded = try? JSONEncoder().encode(favJokes) {
                UserDefaults.standard.set(encoded, forKey: saveKey)
            }
            objectWillChange.send()
        }
    }
    
    func deleteFromFavourites(joke: Joke){
        favJokes = favJokes.filter { $0.id != joke.id }
        if let encoded = try? JSONEncoder().encode(favJokes) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
        objectWillChange.send()
    }
    
    func isFavourite(joke: Joke) -> Bool{
        if favJokes.contains(joke) {
            return true
        } else {
            return false
        }
    }
}
