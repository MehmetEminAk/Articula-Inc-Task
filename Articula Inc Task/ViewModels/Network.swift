//
//  Network.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 11.04.2023.
//

import Foundation


class Network {
    static let shared = Network()
    private init(){}
    
    private let session = URLSession.shared
    
    func generateRequest(operationType : ApiOperations, parameters : [String : Any]) -> NSMutableURLRequest {
        
        
        
        let queryString = parameters.map { key , value in
            return "\(key)=\(value)"
        }.joined(separator: "&")
        
        let urlString = "\(apiScheme):/\(baseUrl)/\(operationType.rawValue)?\(queryString)"
        
        let request = NSMutableURLRequest(url: URL(string: urlString)!)
        return request
    }
    
    
    
    func requestToApi<T : Codable>(request : NSMutableURLRequest , expectingType : T.Type) async -> (T?,Error?) {
        
        var err : Error? = nil
        var result : T? = nil
        
        do {
            let (data,_) = await try session.data(for: request as! URLRequest)
            
            do {
                
                result = try JSONDecoder().decode(T.self, from: data)
                } catch {
                    err = error
                }
        }catch {
            err = error
        }
    
        return (result,err)
    }
}

enum ApiOperations : String {
    case generateRtcToken = "RtcTokenBuilderSample.php"
    case generateRtmToken = "RtmTokenBuilder2Sample.php"
}
