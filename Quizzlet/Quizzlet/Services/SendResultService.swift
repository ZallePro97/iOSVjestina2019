//
//  SendResultService.swift
//  Quizzlet
//
//  Created by Zeljko halle on 09/05/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import Foundation

class SendResultService {
    
    func sendResult(quizzId: Int, userId: Int, time: Double, numberOfCorrectAnswers: Int, completion: @escaping ((ServerResponse) -> Void)) {
        
        let urlString = "https://iosquiz.herokuapp.com/api/result"
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if let token = UserDefaults.standard.string(forKey: "token") {
                request.addValue(token, forHTTPHeaderField: "Authorization")
            }
            
            let params = ["quiz_id" : quizzId, "user_id": userId, "time": time, "no_of_correct": numberOfCorrectAnswers] as [String : Any]
            
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            } catch {
                print("Error sending data")
            }
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, err) in
                let response = response as! HTTPURLResponse
                if let serverResponse = ServerResponse(rawValue: response.statusCode) {
                    print("Saljem odgovor!")
                    completion(serverResponse)
                }
                
            }
            dataTask.resume()
            
        }
        
    }
    
}
