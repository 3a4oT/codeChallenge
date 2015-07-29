//
//  Router.swift
//  windu
//
//  Created by Petro Rovenskyy on 25.07.15.
//  Copyright (c) 2015 Petro Rovenskyy. All rights reserved.
//

import Foundation
import Alamofire


enum Host {
    
    case RequestToken
    case RequestSearchSuggestion
   
    var host: String {
        switch self {
        case .RequestToken:
            return "http://private-c0c29-andresbrun.apiary-mock.com/api/v3/oauth/token"
        case .RequestSearchSuggestion:
            return "http://private-c0c29-andresbrun.apiary-mock.com/api/v3/search_suggestions"
        }
    }
    
}

enum Router: URLRequestConvertible {
    
    static let baseURLString = Host.RequestSearchSuggestion.host
    
    case Login
    case Search(q: String)
    
    
    var method: Alamofire.Method {
        switch self {
        case .Login:
            return .POST
        case .Search:
            return .GET
        default:
            return .GET
            
        }
    }
    
    var path: String {
        switch self {
        case .Login:
            return Host.RequestToken.host
        case .Search:
            return Host.RequestSearchSuggestion.host
        default:
            return Host.RequestSearchSuggestion.host
        }
        
    }

    // MARK: URLRequestConvertible
    var URLRequest: NSURLRequest {
        let URL = NSURL(string: path)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = method.rawValue
        
        switch self {
        case .Login:
            return mutableURLRequest
            
        case .Search(let q):
            let body = "q=\(q)".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            var error: NSError?
            let anyObj: AnyObject? = NSJSONSerialization.JSONObjectWithData(body!, options: NSJSONReadingOptions(0),
                error: &error)
            
            mutableURLRequest.HTTPBody = anyObj as? NSData
            return mutableURLRequest
            
        default:
            return mutableURLRequest
        }
    }
}
