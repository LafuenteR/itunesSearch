//
//  Network.swift
//  Itunes Search
//
//  Created by Ruel Lafuente on 6/12/21.
//

import Foundation
import Alamofire

class Network: NSObject {
    
    typealias complete = (Bool?,Any?)->Void
    
    //Handling Network Request
    static func request(URLString: String, successed: @escaping complete, failed: @escaping complete) {
        AF.request(URLString).responseJSON { response in
            print(response.value)
            switch response.result {
            case .success(_):
                successed(true, response.value)
            case .failure(_):
                successed(false, response.value )
            }
        }
    }
}
