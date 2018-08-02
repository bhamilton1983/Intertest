//
//  Extension_String.swift
//  RtspClient
//
//  Created by Brian Hamilton on 7/31/18.
//  Copyright © 2018 Andres Rojas. All rights reserved.


import Foundation
extension String {
        subscript(value: CountableClosedRange<Int>) -> Substring {
            get {
                return self[index(at: value.lowerBound)...index(at: value.upperBound)]
            }
        }
        
        subscript(value: CountableRange<Int>) -> Substring {
            get {
                return self[index(at: value.lowerBound)..<index(at: value.upperBound)]
            }
        }
        
        subscript(value: PartialRangeUpTo<Int>) -> Substring {
            get {
                return self[..<index(at: value.upperBound)]
            }
        }
        
        subscript(value: PartialRangeThrough<Int>) -> Substring {
            get {
                return self[...index(at: value.upperBound)]
            }
        }
        
        subscript(value: PartialRangeFrom<Int>) -> Substring {
            get {
                return self[index(at: value.lowerBound)...]
            }
        }
        
        func index(at offset: Int) -> String.Index {
            return index(startIndex, offsetBy: offset)
        }
    }
    extension String {
        
        func sliceByCharacter(from: Character, to: Character) -> String? {
            let fromIndex = self.index(self.index(of: from)!, offsetBy: 1)
            let toIndex = self.index(self.index(of: to)!, offsetBy: -1)
            return String(self[fromIndex...toIndex])
        }
        
        func sliceByString(from:String, to:String) -> String? {
            //From - startIndex
            var range = self.range(of: from)
            let subString = String(self[range!.upperBound...])
            
            //To - endIndex
            range = subString.range(of: to)
            return String(subString[..<range!.lowerBound])
        }
        
    }

  


