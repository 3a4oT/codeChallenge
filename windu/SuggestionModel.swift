//
//  SuggestionModel.swift
//  windu
//
//  Created by Petro Rovenskyy on 25.07.15.
//  Copyright (c) 2015 Petro Rovenskyy. All rights reserved.
//

import UIKit
import ObjectMapper

class SuggestionModel: Mappable {
   
    var localizedCountryName: String?
    var localizedName: String?
    var offerCount: String?
    var searchKeys: Array<String>?
    
    
    init() {}
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        localizedCountryName <- map["localized_country_name"]
        localizedName <- map["localized_name"]
        offerCount <- map["offer_count"]
        searchKeys <- map["search_keys"]
    }

}
