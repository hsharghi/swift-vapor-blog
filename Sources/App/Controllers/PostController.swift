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

    
    /// Deletes a parameterized `Post`.
    /// DELETE /posts/:id
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Post.self).flatMap { post in     //5
            return post.delete(on: req)     //6
        }.transform(to: .noContent)    //7
    }
    
    
    /// Updates an updatable `Post` model to it's new values.
    /// PATCH /posts/:id
    func update(_ req: Request) throws -> Future<Post> {
        return try req.parameters.next(Post.self).flatMap { post  in    //8
            let newPostValues = try req.content.syncDecode(Post.UpdatablePost.self)     //9
            
            //10
            post.title = newPostValues.title ?? post.title
            post.body = newPostValues.body ?? post.body
            
            //11
            return post.update(on: req)
        }
    }

}


