//
//  Router.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 1.05.2022.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    static let apiKey = "e00ed4b6b619adca474c02f8465e2e23"
    
    case nowPlayingMovies(page: Int)
    case upcomingMovies(page: Int)
    case details(movieId: Int)
    case getSimilarMovies(movieId: Int)
    case getSearchedMovies(searchedText: String)
    
    var baseURL : URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .nowPlayingMovies, .upcomingMovies, .details, .getSimilarMovies, .getSearchedMovies:
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
        case .getSearchedMovies(searchedText: let text):
            params["query"] = text
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
        case .getSearchedMovies:
            return "search/movie"
        }
    }
    var route: String {
        
        switch self {
            
        case .nowPlayingMovies, .upcomingMovies, .getSearchedMovies:
            return ""
        case .details(let movieId):
            return "\(movieId)"
        case .getSimilarMovies(let movieId):
            return "\(movieId)/similar"
        }
    }
        func asURLRequest() throws -> URLRequest {
            var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path).appendingPathComponent(route))
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

