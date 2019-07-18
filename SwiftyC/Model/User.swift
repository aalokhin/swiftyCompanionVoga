//
//  User.swift
//  SwiftyC
//
//  Created by Anastasiia ALOKHINA on 7/14/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation

class FinalUser : Decodable{
    let displayname : String?
    let email : String?
    let achievements : [Achievement]?
    let cursus_users : [CursusUser]?
    let phone : String?
    let correction_point : Int?
    let image_url : String?
    let location : String?
    let wallet : Int?
    let campus : [Campus]?
    let projects_users : [Project]?
    let staff : Bool? //"staff?" = 0;
   
    
    enum CodingKeys: String, CodingKey {
        case displayname = "displayname"
        case email = "email"
        case achievements = "achievements"
        case cursus_users = "cursus_users"
        case phone = "phone"
        case correction_point = "correction_point";
        case image_url = "image_url";
        case location = "location";
        case wallet = "wallet";
        case campus = "campus";
        case projects_users = "projects_users";
        case staff = "staff?"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.displayname = (try? values.decode(String.self, forKey: .displayname))
        self.email = (try? values.decode(String.self, forKey: .email))
        self.achievements = (try? values.decode([Achievement].self, forKey: .achievements))
        self.cursus_users = (try? values.decode([CursusUser].self, forKey: .cursus_users))
        self.phone = (try? values.decode(String.self, forKey: .phone))
        self.correction_point = (try? values.decode(Int.self, forKey: .correction_point))
        self.image_url = (try? values.decode(String.self, forKey: .image_url))
        self.location = (try? values.decode(String.self, forKey: .location))
        self.wallet = (try? values.decode(Int.self, forKey: .wallet))
        self.campus = (try? values.decode([Campus].self, forKey: .campus))
        self.projects_users = (try? values.decode([Project].self, forKey: .projects_users))
        self.staff = (try? values.decode(Bool.self, forKey: .staff))
    
    }
    
}

/*
 "projects_users" =     (
    {
         "current_team_id" = 1771080;
         "cursus_ids" =             (
         4
         );
         "final_mark" = 25;
         id = 683524;
         marked = 1;
         "marked_at" = "2017-09-23T07:26:28.562Z";
         occurrence = 0;
 //project info
         project =             {
                 id = 157;
                 name = "Day 03";
                 "parent_id" = "<null>";
                 slug = "piscine-c-day-03";
             };
         status = finished;
         "validated?" = 1;
     },
 
     {
     "current_team_id" = 1769858;
     "cursus_ids" =             (
     4
     );
     "final_mark" = 98;
     id = 682671;
     marked = 1;
     "marked_at" = "2017-09-20T20:37:19.029Z";
     occurrence = 0;
     project =             {
         id = 154;
         name = "Day 00";
         "parent_id" = "<null>";
         slug = "piscine-c-day-00";
         };
     status = finished;
     "validated?" = 1;
 },
 */

class Project : Decodable {
    let final_mark : Int?
    let project : ProjectInfo?
    let status : String?
    let validated : Bool?
    let marked_at : String?

    
    enum CodingKeys: String, CodingKey {
        case final_mark = "final_mark"
        case project = "project"
        case status = "status"
        case validated = "validated?"
        case marked_at = "marked_at"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.final_mark = (try? values.decode(Int.self, forKey: .final_mark))
        self.project = (try? values.decode(ProjectInfo.self, forKey: .project))
        self.status = (try? values.decode(String.self, forKey: .status))
        self.validated = (try? values.decode(Bool.self, forKey: .validated))
        self.marked_at = (try? values.decode(String.self, forKey: .marked_at))
    }
    
    
}

class ProjectInfo : Decodable {
    let id : Int?
    let parent_id : Int?
    let name : String?
    let slug : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case parent_id = "parent_id"
        case name = "name"
        case slug = "slug"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = (try? values.decode(Int.self, forKey: .id))
        self.parent_id = (try? values.decode(Int.self, forKey: .parent_id))
        self.name = (try? values.decode(String.self, forKey: .name))
        self.slug = (try? values.decode(String.self, forKey: .slug))
    }

}

class Campus : Decodable {
    let address : String?
    let city : String?
    let country : String?
    let facebook : String?
    let name : String?
    let users_count : Int?
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case city = "city"
        case country = "country"
        case facebook = "facebook"
        case name = "name"
        case users_count = "users_count"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.address = (try? values.decode(String.self, forKey: .address))
        self.city = (try? values.decode(String.self, forKey: .city))
        self.country = (try? values.decode(String.self, forKey: .country))
        self.facebook = (try? values.decode(String.self, forKey: .facebook))
        self.name = (try? values.decode(String.self, forKey: .name))
        self.users_count = (try? values.decode(Int.self, forKey: .users_count))        
    }
    
    
    
}

/*
 (, , , , location, wallet, correction...)
 campus =     (
 {
 address = "Dorohozhytska St, 3";
 city = Kyiv;
 country = Ukraine;
 facebook = "https://www.facebook.com/unit.factory/";
 id = 8;
 language =             {
 "created_at" = "2016-08-21T11:42:57.272Z";
 id = 5;
 identifier = uk;
 name = Ukrainian;
 "updated_at" = "2019-01-25T16:39:53.418Z";
 };
 name = Kyiv;
 "time_zone" = "Europe/Kiev";
 twitter = "";
 "users_count" = 2628;
 "vogsphere_id" = 3;
 website = "https://unit.ua/";
 zip = 04119;
 }
 );
 
 */




class CursusUser : Decodable {
    let cursus : Cursus?
    let begin_at : String?
    let level : Double?
    let skills : [Skill]?
    let user : User?
    
    enum CodingKeys: String, CodingKey {
        case begin_at = "begin_at"
        case level = "level"
        case skills = "skills"
        case user = "user"
        case cursus = "cursus"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.begin_at = (try? values.decode(String.self, forKey: .begin_at))
        self.level = (try? values.decode(Double.self, forKey: .level))
        self.skills = (try? values.decode([Skill].self, forKey: .skills))
        self.user = (try? values.decode(User.self, forKey: .user))
        self.cursus =  (try? values.decode(Cursus.self, forKey: .cursus))
    }
    
}

class Cursus : Decodable {
    
    let created_at : String?
    let id : Int?
    let name : String?
    let slug : String?
    
    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case id = "id"
        case name = "name"
        case slug = "slug"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.created_at = (try? values.decode(String.self, forKey: .created_at))
        self.id = (try? values.decode(Int.self, forKey: .id))
        self.name = (try? values.decode(String.self, forKey: .name))
        self.slug = (try? values.decode(String.self, forKey: .slug))
    }
}

/*
 cursus =             {
     "created_at" = "2014-11-02T16:43:38.480Z";
     id = 1;
     name = 42;
     slug = 42;
 };
*/

class User : Decodable {
    let id : Int?
    let login : String?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case url = "url"
        
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = (try? values.decode(Int.self, forKey: .id))
        self.login = (try? values.decode(String.self, forKey: .login))
        self.url = try? values.decode(String.self, forKey: .url)
    }
}


//class Skills {
//
//    let skills : [Skill]?
//    enum CodingKeys: String, CodingKey {
//        case skills = "skills"
//    }
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        self.skills = (try? values.decode([Skill].self, forKey: .skills))
//    }
//}

class Skill : Decodable {
    let id : Int?
    let level : Double?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case level = "level"
        case name = "name"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = (try? values.decode(Int.self, forKey: .id))
        self.level = (try? values.decode(Double.self, forKey: .level))
        self.name = (try? values.decode(String.self, forKey: .name))
    }
}




class Achievement : Decodable {
    let description : String?
    let id : Int?
    let image : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case id = "id"
        case image = "image"
        case name = "name"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.description = (try? values.decode(String.self, forKey: .description))
        self.id = (try? values.decode(Int.self, forKey: .id))
        self.image = (try? values.decode(String.self, forKey: .image))
        self.name = (try? values.decode(String.self, forKey: .name))
    }
    
}


/*
 
 class CursusUsers : Decodable {
 
 let cursus_users : [CursusUser]?
 
 enum CodingKeys: String, CodingKey {
 case cursus_users = "cursus_users"
 }
 required init(from decoder: Decoder) throws {
 let values = try decoder.container(keyedBy: CodingKeys.self)
 self.cursus_users = (try? values.decode([CursusUser].self, forKey: .cursus_users))
 }
 
 }
 
 */


/*
 class Achievements : Decodable {
 let achievements : [Achievement]?
 
 enum CodingKeys: String, CodingKey {
 case achievements = "achievements"
 }
 required init(from decoder: Decoder) throws {
 let values = try decoder.container(keyedBy: CodingKeys.self)
 self.achievements = (try? values.decode([Achievement].self, forKey: .achievements))
 }
 
 }
 
 */

