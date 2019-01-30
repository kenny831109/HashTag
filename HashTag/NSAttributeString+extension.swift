//
//  NSAttributeString+extension.swift
//  HashTag
//
//  Created by 逸唐陳 on 2018/9/21.
//  Copyright © 2018年 逸唐陳. All rights reserved.
//

import Foundation

extension NSAttributedString {
    func getFullString() -> NSMutableString {
        let plainString: NSMutableString = NSMutableString(string: self.string)
        var base = 0
        self.enumerateAttribute(NSAttributedString.Key.link, in: NSRange(location: 0, length: self.length), options: NSAttributedString.EnumerationOptions(rawValue: 0)) { (value, range, stop) in
            if value != nil {
                print(range)
                let userID = value as! String
                plainString.replaceCharacters(in: NSRange(location: range.location + base, length: range.length), with: userID)
                base += userID.count - range.length
            }
        }
        return plainString
    }
}
