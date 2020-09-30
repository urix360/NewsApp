//
//  Article.swift
//  News
//
//  Created by Uri Vishnevski on 27/09/2020.
//  Copyright © 2020 Uri Vishnevski. All rights reserved.
//

import Foundation
struct article : Decodable{
    var title : String
    var description : String
    var urlToImage : String
    var url : String
    var imageUrl : String {
        let newUrl = urlToImage.replacingOccurrences(of: "http", with: "https")
        return newUrl.replacingOccurrences(of: "httpss", with: "https")
    }
    var webUrl : String {
        let newUrl = url.replacingOccurrences(of: "http", with: "https")
        return newUrl.replacingOccurrences(of: "httpss", with: "https")
    }
}

