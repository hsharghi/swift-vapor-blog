import Vapor

public func routes(_ router: Router) throws {

        let postController = PostController() // 1
  
        // 2
        /// GET /posts
        router.get("posts", use: postController.index)
    
        /// GET /posts/:id
        router.get("posts", Post.parameter, use: postController.show)
    
        /// POST /posts
        router.post("posts", use: postController.create)
    
        /// PATCH /posts/:id
        router.patch("posts", Post.parameter, use: postController.update)
    
        /// DELETE /posts/:id
        router.delete("posts", Post.parameter, use: postController.delete)
}
