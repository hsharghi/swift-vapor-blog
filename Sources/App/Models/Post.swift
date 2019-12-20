//
//  Post.swift
//  App
//
//  Created by Hadi Sharghi on 12/20/19.
//

import Vapor
import FluentSQLite    // 1


final class Post: SQLiteModel {        // 2
    var id: Int?
    var title: String
    var body: String    // 3
    
    init(id: Int? = nil, title: String, body: String) {    // 4
        self.id = id
        self.title = title
        self.body = body
    }
    
    struct UpdatablePost: Content {
        var title: String?
        var body: String?
    }

}

extension Post: Migration { } // 5
extension Post: Content { }   // 6
extension Post: Parameter { } // 7

