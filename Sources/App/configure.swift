import FluentSQLite
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {

    //1
    // Register providers first
    try services.register(FluentSQLiteProvider())

    //2
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    //3
    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    //4
    // Configure a SQLite database
    let sqlite = try SQLiteDatabase(storage: .file(path: "blog.db"))

    //5
    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
    services.register(databases)

    //6
    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Post.self, database: .sqlite)
    services.register(migrations)
}
