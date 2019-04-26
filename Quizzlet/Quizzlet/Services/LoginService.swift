//
//  LoginService.swift
//  Quizzlet
//
//  Created by Zeljko halle on 26/04/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import Foundation

class LoginService {
    
    func getToken(username: String, password: String, completion: @escaping (([String: Any]) -> Void)) {
        
        let urlString = "https://iosquiz.herokuapp.com/api/session"
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            let parameters: [String: Any] = [
                "username": username,
                "password": password
            ]
            request.httpBody = parameters.percentEscaped().data(using: .utf8)
            
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, err) in
                
                if let data = data {
                    print(data)
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        if let decoded = json as? [String: Any] {
                            
//                            if let finalData = decoded["quizzes"] as? NSArray {
//                                let quizzes = finalData.compactMap({ (json) -> Quizz? in
//                                    Quizz(json: json)
//                                })
//
//                                completion(quizzes)
//                            }
                            completion(decoded)
                            
                        }
                        
                    } catch {
                        print("greska")
                    }
                    
                }
                
            }
            dataTask.resume()
            
        }
        
    }
    
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}
