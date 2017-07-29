//
//  Network.swift
//  Netguru Interview App
//
//  Created by Maciej Matuszewski on 26.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import Foundation

/// Base of communication in app. Includes all variants of communication's use cases.
enum Network {
    case validate(number: String)
    
    //MARK:- internal
    
    /// Types of comunication Method
    ///
    /// - GET: HTTP GET Method
    /// - POST: HTTP POST Method
    /// - PUT: HTTP PUT Method
    enum HTTPMethod: String{
        case GET
        case POST
        case PUT
    }
    
    /// Return _HTTPMethod_ for selected _Network_ use case
    private var method: HTTPMethod{
        switch self {
        case .validate:
            return HTTPMethod.GET
        }
    }
    
    /// Return url for selected _Network_ use case
    private var url: String {
        return "\(Constants.serverURL)/\(Constants.apiKey)/\(self.urlEnd)"
    }
    
    /// Return url end point for selected _Network_ use case
    private var urlEnd: String {
        switch self {
        case .validate(let number): return number
        }
    }
    
    
    //MARK:- public
    
    /// Request for JSON data
    ///
    /// - Parameters:
    ///   - successCompletion: Callback executed when response is success
    ///   - errorCompletion: Callback executed when response contains errors (optional)
    public func sendRequest(successCompletion: @escaping ([String: Any]) -> Void, errorCompletion: ((Int) -> Void)? = nil) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let url = URL(string: self.url) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            if let error = error {
                print("URL Session Task Failed: %@", error.localizedDescription);
                if let errorCompletion = errorCompletion{
                    errorCompletion(0)
                }
            }
            
            guard let data = data
            else{
                if let errorCompletion = errorCompletion{
                    errorCompletion(-1)
                }
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                successCompletion(json)
            } catch let error as NSError {
                print(error)
                if let errorCompletion = errorCompletion{
                    errorCompletion(-2)
                }
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    /// Request for Model data that conform to MMObjectModelProtocol
    ///
    /// - Parameters:
    ///   - successCompletion: Callback executed when response is success
    ///   - errorCompletion: Callback executed when response contains errors (optional)
    public func sendRequest<T:MMObjectModelProtocol>(successCompletion: @escaping (T) -> Void, errorCompletion: ((Int) -> Void)? = nil) {
        self.sendRequest(
            successCompletion: { (response) in
                DispatchQueue.main.async {
                    if let errorModel = ErrorModel.init(json: response){
                        if let errorCompletion = errorCompletion{
                            errorCompletion(errorModel.error)
                        }
                    }else{
                        successCompletion(T(json: response)!)
                    }
                }
        },
            
            errorCompletion: {(errorCode) in
                DispatchQueue.main.async {
                    if let errorCompletion = errorCompletion{
                        errorCompletion(errorCode)
                    }
                }
            }
        )
    }
}
