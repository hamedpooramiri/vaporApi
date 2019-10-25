import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    
    router.get("kill",String.parameter) { (req) -> String in
        let name = try! req.parameters.next(String.self)
        print(req.http.version)
        print(req.redirect(to: "hello"))
        return name
        
    }
    
    router.post("1","2") { (req) -> Future<HTTPStatus> in
        
        return try! req.content.decode(User.self)
                .flatMap(to: User.self, { (user)  in
                        return user.save(on: req).transform(to: HTTPStatus.ok)
                })
    }
    
    
    
    
    router.post(InfoData.self, at: "info") { (req, data) -> ServerResponse<String> in
        
        let name  = "welcome back \(data.name)"
        
        let serverResponse = ServerResponse<String>(sucssesfull: true, response: "", returnValue: name)
        
        return serverResponse
    }
    
    

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

struct InfoData:Content {
    let  name:String
}
struct ServerResponse<T:Content>:Content {
    let sucssesfull:Bool
    let response:String
    let returnValue:T
}
