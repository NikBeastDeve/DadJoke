//
//  DadJokesFetcher.swift
//  DadJoke
//
//  Created by Nikita Galaganov on 07.02.2020.
//  Copyright © 2020 Nikita Galaganov. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    static var baseURLString = "https://icanhazdadjoke.com"
    case searchForJokes(page : Int, limit: Int, term: String)
    case getJokes(page : Int, limit: Int)
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .searchForJokes(let page, let limit, let term):
            return "/search?term=\(term)&page=\(page)&limit=\(limit)"
        case .getJokes(let page, let limit):
            return "/search?page=\(page)&limit=\(limit)"
        }
    }
    
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {

        let url = URL(string: APIRouter.baseURLString+path)!

        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        //urlRequest.setValue("User-Agent:", forHTTPHeaderField: "My Git https://github.com/NikBeastDeve My email: nickgalaganov@gmail.com")
        
        return urlRequest
    }
}

class API {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>, _ statusCode: Int)->Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                //print(response.response?.statusCode ?? "")
                if let resp = response.response {
                    completion(response.result, resp.statusCode)
                }
        }
    }
    
    static func searchForJokes(page: Int, limit: Int, term: String, completion:@escaping (Result<DadJokes, AFError>, _ statusCode: Int)->Void) {
        performRequest(route: APIRouter.searchForJokes(page: page, limit: limit, term: term), completion: completion)
    }
    
    static func getJokes(page: Int, limit: Int, completion:@escaping (Result<DadJokes, AFError>, _ statusCode: Int)->Void) {
        performRequest(route: APIRouter.getJokes(page: page, limit: limit), completion: completion)
    }
}

