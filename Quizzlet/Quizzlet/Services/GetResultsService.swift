//
//  GetResultsService.swift
//  Quizzlet
//
//  Created by Zeljko halle on 09/05/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import Foundation

class GetResultsService {
    
    func getResults(quizzId: Int, completion: @escaping ([UserResult]?) -> Void) {
        
        let urlString = "https://iosquiz.herokuapp.com/api/score?quiz_id=\(quizzId)"
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if let token = UserDefaults.standard.string(forKey: "token") {
                request.addValue(token, forHTTPHeaderField: "Authorization")
            }
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, err) in
                if let data = data {
                    do {
                        print("dohvacam")
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        if let decoded = json as? NSArray {
                            var results: [UserResult] = []
                            
                            for user in decoded {
                                var dict = user as! [String: Any]
                                let user = dict["username"] as! String
                                let score = Double(dict["score"] as! String)
                                
                                results.append(UserResult(score: score, username: user))
                            }
                            
                            completion(results)
                            
                        }
                        
                    } catch {
                        print("greska 1")
                        completion(nil)
                    }
                    
                } else {
                    print("greska 2")
                    completion(nil)
                }
            }
            dataTask.resume()
            
        }
        
    }
    
    
    struct UserResult {
        var score: Double!
        var username: String!
    }

    
}

