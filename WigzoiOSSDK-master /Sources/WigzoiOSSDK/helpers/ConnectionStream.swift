//
//  ConnectionStream.swift
//  
//
//  Created by Rihan on 10/12/22.
//

import Foundation

private enum HTTPMethod : String {
    case POST = "post"
    case GET = "get"
    case PUT = "put"
    case PATCH = "patch"
    case DELETE = "delete"
    
}

internal class ConnectionStream {
    
    internal func post(url : String, data : Dictionary<String, Any>?, headers : Dictionary<String, String>?, responseHandler : @escaping (String?, HTTPURLResponse?, (any Error)?) -> Void) -> Void {
        self.execute(url: url, data: data, httpMethod: .POST, headers: headers, responseHandler: responseHandler)
    }
    
    internal func postJson(url : String, data : Dictionary<String, Any>?, headers : Dictionary<String, String>?, responseHandler : @escaping (String?, HTTPURLResponse?, (any Error)?) -> Void) -> Void {
        var editHeaders = headers == nil ? [:] : headers
        editHeaders?["content-type"] = "application/json"
        self.execute(url: url, data: data, httpMethod: .POST, headers: editHeaders, responseHandler: responseHandler)
    }
    
    internal func put(url : String, data : Dictionary<String, Any>?, headers : Dictionary<String, String>?, responseHandler : @escaping (String?, HTTPURLResponse?, (any Error)?) -> Void) -> Void {
        self.execute(url: url, data: data, httpMethod: .PUT, headers: headers, responseHandler: responseHandler)
    }
    
    internal func putJson(url : String, data : Dictionary<String, Any>?, headers : Dictionary<String, String>?, responseHandler : @escaping (String?, HTTPURLResponse?, (any Error)?) -> Void) -> Void {
        var editHeaders = headers == nil ? [:] : headers
        editHeaders?["content-type"] = "application/json"
        self.execute(url: url, data: data, httpMethod: .PUT, headers: editHeaders, responseHandler: responseHandler)
    }
    
    internal func get(url : String, headers : inout Dictionary<String, String>?, responseHandler : @escaping (String?, HTTPURLResponse?, (any Error)?) -> Void) -> Void {
        self.execute(url: url, data: nil, httpMethod: .GET, headers: headers, responseHandler: responseHandler)
    }
    
    private func execute(url: String, data : Dictionary<String, Any>?, httpMethod : HTTPMethod, headers : Dictionary<String, String>?, responseHandler : @escaping (String?, HTTPURLResponse?, (any Error)?) -> Void) -> Void {
        let someUrl = URL(string: url)
        if someUrl != nil {
            var request = URLRequest(url : someUrl!)
            if data != nil {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: data!)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            
            request.httpMethod = httpMethod.rawValue
            if headers != nil {
                for header in headers! {
                    request.addValue(header.value, forHTTPHeaderField: header.key)
                }
            }
            URLSession.shared.dataTask(with: request){
                data, urlResponse, error in
                responseHandler(data != nil ? String(decoding: data!, as: UTF8.self) : nil, urlResponse as? HTTPURLResponse, error)
            }.resume()

            RunLoop.current.run()
        }
    }
}
