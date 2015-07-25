//
//  SuggestionsModel.swift
//  windu
//
//  Created by Petro Rovenskyy on 25.07.15.
//  Copyright (c) 2015 Petro Rovenskyy. All rights reserved.
//

import UIKit
import ObjectMapper

class SuggestionsModel: Mappable {
   
   var suggestions: [SuggestionModel]?
   var type: String?
    
    init() {}
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        suggestions <- map["suggestions"]
        type <- map["type"]
    }
    
    
}
