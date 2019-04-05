//
//  QuizzService.swift
//  Quizzlet
//
//  Created by Zeljko halle on 03/04/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import Foundation

class QuizzService {
    
    func fetchQuizzes(urlString: String, completion: @escaping (([Quizz]?) -> Void)) {
        
        var quizzes: [Quizz] = []
        
        if let url = URL(string: urlString) {
            
            let request = URLRequest(url: url)
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, err) in
                if let data = data {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        if let decoded = json as? [String: Any] {
                            
                            if let finalData = decoded["quizzes"] as? NSArray {
                                
                                for item in finalData {
                                    if let quizz = Quizz(json: item) {
                                        quizzes.append(quizz)
                                    }
                                }
                                completion(quizzes)
                                
                            }
                            
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
            
        } else {
            print("greska 3")
            completion(nil)
        }
        
    }
    
}
