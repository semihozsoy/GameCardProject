//
//  HomeEndpointItem.swift
//  FinalProject
//
//  Created by Semih Özsoy on 29.05.2021.
//

import Foundation
import CoreApi

enum GameEndpointItem:Endpoint {
    
    case gamepage(query: String)
    case platform
    case details(id:Int)
    case search(text:String)
    
    var baseUrl: String {"https://api.rawg.io/api/"}
    var path: String {
        switch self {
        case .gamepage(let query):
            return "games?key=2011cfb71a0b4732aee9db010224b8d7&\(query)"
        case .platform:
            return "platforms/lists/parents?key=2011cfb71a0b4732aee9db010224b8d7"
        case .details(let id):
            return "games/\(id)?key=2011cfb71a0b4732aee9db010224b8d7"
        case .search(let text):
            return "games?key=2011cfb71a0b4732aee9db010224b8d7&search=\(text)"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .gamepage:
            return .get
        case .platform:
            return .get
        case .details:
            return .get
        case .search:
            return .get
        }
    }
    
}
    
