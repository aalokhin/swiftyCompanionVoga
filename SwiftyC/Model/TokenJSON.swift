//
//  TokenJSON.swift
//  SwiftyC
//
//  Created by Anastasiia ALOKHINA on 7/13/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation


//JSON  IMplementation of token data received ====> how to refresh tokn , preferably in a background
class TokenJSON : Decodable {
    
    let access_token : String?
    let created_at : Int?
    let expires_in :  Int?   
    
    enum CodingKeys: String, CodingKey {
        case access_token = "access_token"
        case created_at = "created_at"
        case expires_in = "expires_in"
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.access_token = (try? values.decode(String.self, forKey: .access_token))
        self.expires_in = (try? values.decode(Int.self, forKey: .expires_in))
        self.created_at = try? values.decode(Int.self, forKey: .created_at)
    }
    
    
}

