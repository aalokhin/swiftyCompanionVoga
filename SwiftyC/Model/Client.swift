//
//  Client.swift
//  SwiftyC
//
//  Created by ANASTASIA on 7/9/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation


final class Client {
    
    static let apiUid = "6af74bd217ef8e833ce6a8577e4c06852c2e484455bc8ea9c71c15fd8ed18223"
    static let apiSecret = "fc0832170af85e9f14539acbd1179105b9c5d43d867f6785acac5e42468f7d7e"
    static let scope = "public".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    static let baseUrl = "https://api.intra.42.fr/"
    static let redirectURI = "myapp01://sc".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    static let authorizationURL = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=\(apiUid)&redirect_uri=\(redirectURI)&scope=\(scope)&response_type=code")
    
    let allSkillsC : [String] = [
                                "Algorithms & AI",
                                "Group & interpersonal",
                                "Rigor",
                                "Unix",
                                ]
    let allSkills42 : [String] = ["Adaptation & creativity",
                                "Algorithms & AI",
                                "Company experience",
                                "DB & Data",
                                "Functional programming",
                                "Graphics",
                                "Group & interpersonal",
                                "Imperative programming",
                                "Network & system administration",
                                "Object-oriented programming",
                                "Organization",
                                "Parallel computing",
                                "Rigor",
                                "Security",
                                "Technology integration",
                                "Unix",
                                "Web"
    ]
    
    let DateFormat = "E MMM dd HH:mm:ss Z yyyy"
//    
//    var isSignedIn : Bool
//    var myId = 0
//    var myLogin = ""
    var token : String
    var currrentUser : FinalUser?
    
    
    static let sharedInstance = Client()
    
    private init(){
        print("Singleton client has been initialized")
        token = ""
       // isSignedIn = false
        //currrentUser = FinalUser()
    }

    func setToken(t : String){
        self.token = t
    }
    
    func setUser(u : FinalUser){
        self.currrentUser = u
    }
    
}

