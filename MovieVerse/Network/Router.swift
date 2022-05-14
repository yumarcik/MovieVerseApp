//
//  Router.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 1.05.2022.
//

// https://api.themoviedb.org/3/discover/movie?api_key=e00ed4b6b619adca474c02f8465e2e23&page=2
// https://api.themoviedb.org/3/movie/580489?api_key=e00ed4b6b619adca474c02f8465e2e23

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    static let apiKey = "e00ed4b6b619adca474c02f8465e2e23"
    
    case nowPlayingMovies(page: Int)
    case upcomingMovies(page: Int)
    case details(movieId: Int)
    case getSimilarMovies(movieId: Int)
    
    var baseURL : URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .nowPlayingMovies, .upcomingMovies, .details, .getSimilarMovies:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        var params: Parameters = [:]
        switch self {
        case .nowPlayingMovies(page: let page):
            params["page"] = page
        case .upcomingMovies(page: let page):
            params["page"] = page
        case .details, .getSimilarMovies:
            break
            //params["movieId"] = movieId

        }
        
        return params
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var path: String {
        switch self {
        case .nowPlayingMovies:
            return "movie/now_playing"
        case .upcomingMovies:
            return "movie/upcoming"
        case .details:
            return "movie"
        case .getSimilarMovies:
            return "movie"
        }
    }
    var route: String {
        
        switch self {
            
        case .nowPlayingMovies, .upcomingMovies:
            return ""
        case .details(let movieId):
            return "\(movieId)"
        case .getSimilarMovies(let movieId):
            return "\(movieId)/similar"
        }
    }
        func asURLRequest() throws -> URLRequest {
            var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path).appendingPathComponent(route))
            print(route)
            print(urlRequest)
            urlRequest.httpMethod = method.rawValue
            
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        var completeParameters = parameters ?? [:]
        
        completeParameters["api_key"] = Router.apiKey
        
        let urlRequestPrint = try encoding.encode(urlRequest, with: completeParameters)
        debugPrint("************> MY URL: ", urlRequestPrint.url ?? "")
        
        return try encoding.encode(urlRequest, with: completeParameters)
    }
    
}

