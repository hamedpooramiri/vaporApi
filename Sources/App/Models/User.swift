
import Vapor
import FluentSQLite




final class User: SQLiteModel {
    
    var id:Int?
    var name:String
    var job:String
    
    init(name: String, job: String){
        self.name = name
        self.job = job
        
    }

}
/// Allows `Todo` to be used as a dynamic migration.
extension User: Migration { }

/// Allows `Todo` to be encoded to and decoded from HTTP messages.
extension User: Content { }

/// Allows `Todo` to be used as a dynamic parameter in route definitions.
//extension User: Parameter { }
