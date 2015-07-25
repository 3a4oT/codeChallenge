//
//  NetworkOperation.swift
//  windu
//
//  Created by Petro Rovenskyy on 25.07.15.
//  Copyright (c) 2015 Petro Rovenskyy. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class NetworkOperation: ConcurrentOperation {
    
    let networkOperationCompletionHandler: (responseObject: AnyObject?, error: NSError?) -> ()
    weak var request: Alamofire.Request?
    let router: Router
    let manager: Manager

    
    init(router: Router, networkOperationCompletionHandler: (responseObject: AnyObject?, error: NSError?) -> ()) {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        manager = Alamofire.Manager(configuration: configuration)
        self.router = router
        self.networkOperationCompletionHandler = networkOperationCompletionHandler
        super.init()
    }
    
    override func main() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        request =  manager.request(router).responseObject { ( responseObject: SearchSuggestionsModel?, error) in
                /*
                let data = responseObject!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                let cachedURLResponse = NSCachedURLResponse(response: response!, data: data!, userInfo: nil, storagePolicy: .Allowed)
                NSURLCache.sharedURLCache().storeCachedResponse(cachedURLResponse, forRequest: request)
                */
                self.networkOperationCompletionHandler(responseObject: responseObject, error: error)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                self.completeOperation()
                
        }
    }
    
    // we'll also support canceling the request, in case we need it
    override func cancel() {
        print("canceling operation")
        request?.cancel()
        super.cancel()
    }

}
