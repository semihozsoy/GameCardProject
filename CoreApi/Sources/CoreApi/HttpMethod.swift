//
//  HttpMethod.swift
//  
//
//  Created by Semih Özsoy on 29.05.2021.
//

import Alamofire


public typealias HTTPMethod = Alamofire.HTTPMethod

public extension Endpoint {
    var encoding: ParameterEncoding{
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }

}
