//
//  Model.swift
//  
//
//  Created by Rihan on 25/11/22.
//

import Foundation

protocol Model {
    func dict() -> Dictionary<String, Any>
    
    func isValid() throws -> Bool
}
