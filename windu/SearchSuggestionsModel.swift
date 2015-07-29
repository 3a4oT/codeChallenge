//
//  Suggestions.swift
//  windu
//
//  Created by Petro Rovenskyy on 25.07.15.
//  Copyright (c) 2015 Petro Rovenskyy. All rights reserved.
//

import UIKit
import ObjectMapper

class SearchSuggestionsModel: Mappable, SequenceType {
    
    var searchSuggestions: [SuggestionsModel]?
    
    static func newInstance() -> Mappable {
        return SearchSuggestionsModel()
    }
    
    func mapping(map: Map) {
        searchSuggestions <- map["search_suggestions"]
    }
    //MARK : SequenceType protocol
    func generate() -> GeneratorOf<SuggestionsModel> {
        var nextIndex = searchSuggestions!.count-1
        
        return GeneratorOf<SuggestionsModel> {
            if (nextIndex < 0) {
                return nil
            }
            return self.searchSuggestions![nextIndex--]
        }
    }
}
