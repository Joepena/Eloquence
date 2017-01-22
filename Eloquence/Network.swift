//
//  Network.swift
//  Eloquence
//
//  Created by Joseph Pena on 1/21/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String: AnyObject]

class Network {
    fileprivate static let sentimentAPI = "https://api.havenondemand.com/1/api/sync/analyzesentiment/v2?text=%@&apikey=5df77d7b-b142-43e1-9009-bd98eefb916d"
    fileprivate static let wordOfDay = ""
    
    static func sentimentIndex(speech: String, completion: @escaping (Float?, String?) -> Void) {
        let path = String(format: sentimentAPI, speech.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        Alamofire.request(path)
            .responseJSON { response in
                guard let json = response.result.value as? JSONDictionary else {
                    print("Failed parsing json, below is the current json")
                    print(response)
                    completion(nil, nil)
                    return
                }
                guard let analysis = json["sentiment_analysis"] as? [JSONDictionary], !analysis.isEmpty else {
                    print("Failed parsing json, below is the current json")
                    print(json)
                    completion(nil, nil)
                    return
                }
                
                let aggregate = analysis[0]["aggregate"]
                guard let score = aggregate?["score"] as? Float, let sentiment = aggregate?["sentiment"] as? String else {
                    print("Failed parsing json, below is the current json")
                    print(aggregate!)
                    completion(nil, nil)
                    return
                }
                completion(score, sentiment)
        }
    }

}
