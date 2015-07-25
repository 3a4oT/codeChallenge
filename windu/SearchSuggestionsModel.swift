//
//  Suggestions.swift
//  windu
//
//  Created by Petro Rovenskyy on 25.07.15.
//  Copyright (c) 2015 Petro Rovenskyy. All rights reserved.
//

import UIKit
import ObjectMapper

class SearchSuggestionsModel: Mappable {
    
    var searchSuggestions: [SuggestionsModel]?
    
     init() {}
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        searchSuggestions <- map["search_suggestions"]
    }
}
