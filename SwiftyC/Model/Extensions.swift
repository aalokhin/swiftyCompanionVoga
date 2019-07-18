//
//  Extensions.swift
//  SwiftyC
//
//  Created by ANASTASIA on 7/9/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation
import UIKit

extension Date{
    func toString() -> String {
        let format = "dd/MM/yyyy HH:mm"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension String {
    func toDate()-> Date? {
        let format : String = Client.sharedInstance.DateFormat
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


extension Int
{
    func toString() -> String
    {
        let myString = String(self)
        return myString
    }
}

extension Double {
    func toString() -> String {
        return String(format: "%.2f",self)
    }
}

//TODO: needs all the attirbutes to be printed

extension FinalUser {
    func printUser()
    {
        print(self.displayname ?? "No display name")
        
        print(self.email ?? "No email")
        print(self.achievements?.count ?? "No achievements")
        print(self.cursus_users?.count ?? "No cursus_users")
        guard let cUsers = self.cursus_users else {
            print("no cursus users")
            return
            
        }
        for c in cUsers {
            print(c.user?.login ?? "no login")
            print(c.begin_at ?? "no begin at")
            print(c.level ?? "No level")
            guard let skills = c.skills else {
                print("no skills")
                return
            }
            for skill in skills {
                print(skill.id ?? "No skill id")
                print(skill.level ?? "No skill lvl")
                print(skill.name ?? "No skill name")
            }
        }
        print(self.location ?? "", self.correction_point ?? "", self.wallet ?? "")
        
        guard let campus = self.campus else {
            print("No campus decoded")
            return
        }
        print(campus.count)
        for i in campus
        {
            print(i.name ?? "unknown campus", i.address ??  "unknown campus address")
        }
        
        guard let projects = self.projects_users else  {
            print("No projects decoded")
            return
        }
        for p in projects{
            print(p.project?.name ?? "no name", p.final_mark ?? "no mark", p.marked_at ?? "no marked at", p.validated ?? "no info")
        }
    }

}


/*
 func printUser()
 {
 guard let user = Client.sharedInstance.currrentUser else
 {
 callErrorWithCustomMessage("No user set in Client Shared Instance")
 return
 }
 print(user.displayname ?? "No display name")
 print(user.email ?? "No email")
 print(user.achievements?.count ?? "No achievements")
 print(user.cursus_users?.count ?? "No cursus_users")
 guard let cUsers = user.cursus_users else {
 print("no cursus users")
 return
 
 }
 for c in cUsers {
 print(c.user?.login ?? "no login")
 print(c.begin_at ?? "no begin at")
 print(c.level ?? "No level")
 guard let skills = c.skills else {
 print("no skills")
 return
 }
 for skill in skills {
 print(skill.id ?? "No skill id")
 print(skill.level ?? "No skill lvl")
 print(skill.name ?? "No skill name")
 }
 }
 print(user.location ?? "", user.correction_point ?? "", user.wallet ?? "")
 
 guard let campus = user.campus else {
 print("No campus decoded")
 return
 }
 print(campus.count)
 for i in campus
 {
 print(i.name ?? "unknown campus", i.address ??  "unknown campus address")
 }
 
 guard let projects = user.projects_users else  {
 print("No projects decoded")
 return
 }
 for p in projects{
 print(p.project?.name ?? "no name", p.final_mark ?? "no mark", p.marked_at ?? "no marked at", p.validated ?? "no info")
 }
 }
 
 */
