//
//  String+extension.swift
//  HashTag
//
//  Created by 逸唐陳 on 2018/9/21.
//  Copyright © 2018年 逸唐陳. All rights reserved.
//

import Foundation

extension String {
    
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
}
