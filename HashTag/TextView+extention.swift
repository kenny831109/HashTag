//
//  TextView+extention.swift
//  HashTag
//
//  Created by 逸唐陳 on 2018/7/25.
//  Copyright © 2018年 逸唐陳. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    
    func resolveHashTags(result:[user]) {
        
        // turn string in to NSString
        let nsText = NSString(string: self.text)
        // this needs to be an array of NSString.  String does not work.
        let words = nsText.components(separatedBy: " ")
        print(words)
        
        // you can staple URLs onto attributed strings
        let attrString = NSMutableAttributedString()
        attrString.setAttributedString(self.attributedText)
        
        // tag each word if it has a hashtag
        for word in words.reversed() {
            if word.count < 3 {
                continue
            }
            
            // found a word that is prepended by a hashtag!
            // homework for you: implement @mentions here too.
            if word.hasPrefix("#") {
                
                // a range is the character position, followed by how many characters are in the word.
                // we need this because we staple the "href" to this range.
                let matchRange:NSRange = nsText.range(of: word as String)
                
                // drop the hashtag
                let stringifiedWord = word
    
                
//                let encodeKeyword = stringifiedWord.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
//                print(encodeKeyword)
//                if let firstChar = stringifiedWord.unicodeScalars.first, NSCharacterSet.decimalDigits.contains(firstChar) {
                    // hashtag contains a number, like "#1"
                    // so don't make it clickable
//                } else {
                    // set a link for when the user clicks on this word.
                    // it's not enough to use the word "hash", but you need the url scheme syntax "hash://"
                    // note:  since it's a URL now, the color is set to the project's tint color
//                    attrString.addAttribute(NSAttributedString.Key.link, value: "hash:\(stringifiedWord.dropFirst())", range: matchRange)
                attrString.addAttributes([NSAttributedString.Key.link : "hash:\(stringifiedWord.dropFirst())"], range: matchRange)
                result.forEach { (user) in
                    if stringifiedWord.dropFirst() == user.id {
                        attrString.replaceCharacters(in: matchRange, with: "\(user.name)")
                    }
                }
//                    attrString.replaceCharacters(in: matchRange, with: "#章魚哥123")
//                }
            
            }
        }
        
        // we're used to textView.text
        // but here we use textView.attributedText
        // again, this will also wipe out any fonts and colors from the storyboard,
        // so remember to re-add them in the attrs dictionary above
        self.attributedText = attrString
    }
    
    func addTag(text: String, range: NSRange) {
        let attrString = NSMutableAttributedString()
        attrString.setAttributedString(self.attributedText)
        attrString.addAttributes([NSAttributedString.Key.link : "hash:\(text)"], range: range)
        
    }

}
