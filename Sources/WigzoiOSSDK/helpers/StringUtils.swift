//
//  StringUtils.swift
//  
//
//  Created by Rihan on 01/12/22.
//

import Foundation

public class StringUtils {
    public static func isEmpty(_ string : String?) -> Bool {
        if nil == string {
            return true
        } else {
            let stringTrimmed = string!.trimmingCharacters(in: .whitespaces)
            return ((stringTrimmed.elementsEqual("")))
        }
    }
    
    public static func isNotEmpty(_ string : String?) -> Bool {
        return !isEmpty(string);
    }
    
    public static func allEmpty(_ string : String?...) -> Bool {
        if string.isEmpty {
            return true;
        } else {
                for str in string {
                if !(isEmpty(str)) {
                    return false;
                }
            }
            return true;
        }
    }
    
    public static func isNoneEmpty(_ string : String?...) -> Bool {
        if (string.isEmpty) {
            return false;
        } else {
            for str in string {
                if (isEmpty(str)) {
                    return false;
                }
            }
            return true;
        }
    }
}
