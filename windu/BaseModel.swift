//
//  BaseModel.swift
//  windu
//
//  Created by Petro Rovenskyy on 25.07.15.
//  Copyright (c) 2015 Petro Rovenskyy. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseModel: Mappable {
    
    init() {}
    
    required init?(_ map: Map) {
       // your implemantation here
    }
    
    func mapping(map: Map) {
        // your implemantation here
    }
    

}


