//
//  PostController.swift
//  App
//
//  Created by Hadi Sharghi on 12/20/19.
//

import Vapor

/// Controls basic CRUD operations on `Post`s.
final class PostController {
    
    /// Returns a list of all `Posts`s.
    /// GET /posts
    func index(_ req: Request) throws -> Future<[Post]> {
        return Post.query(on: req).all()    //1
    }

    /// Returns a `Posts` for given ID.
    /// GET /posts/:id
    func show(_ req: Request) throws -> Future<Post> {
        return try req.parameters.next(Post.self)   //2
    }

    /// Saves a decoded `Post` to the database.
    /// POST /posts
    func create(_ req: Request) throws -> Future<Post> {
        let post = try req.content.syncDecode(Post.self)    //3
        return post.save(on: req)   //4
    }

    
    /// Updates an updatable `Post` model to it's new values.
    /// PATCH /posts/:id
    func update(_ req: Request) throws -> Future<Post> {
        return try req.parameters.next(Post.self).flatMap { post  in    //5
            let newValues = try req.content.syncDecode(Post.UpdatablePost.self)     //6
            
            //7
            post.title = newValues.title ?? post.title
            post.body = newValues.body ?? post.body
            
            //8
            return post.update(on: req)
        }
    }

    
    /// Deletes a parameterized `Post`.
    /// DELETE /posts/:id
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Post.self).flatMap { post in     //9
            return post.delete(on: req)     //10
        }.transform(to: .noContent)    //11
    }
}


