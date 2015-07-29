//
//  GroupType.swift
//  windu
//
//  Created by Petro Rovenskyy on 25.07.15.
//  Copyright (c) 2015 Petro Rovenskyy. All rights reserved.
//

import Foundation

enum GroupType: String {
    
    case Cities = "cities"
    case Regions = "regions"
    case Districts = "districts"
    
    var index: Int {
        switch self {
        case .Cities:
            return 0
        case .Regions:
            return 1
        case .Districts:
            return 2
        default: break
        }
    }
    
    
}