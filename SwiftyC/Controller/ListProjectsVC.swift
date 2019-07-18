//
//  ListProjectsVC.swift
//  SwiftyC
//
//  Created by ANASTASIA on 7/15/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation
import UIKit


class  ListProjectsVC : UIViewController {
    
    var projects : [Project] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "ProjectCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ProjectCell")
        
        guard let allProjects =  Client.sharedInstance.currrentUser?.projects_users else {
            navigationController?.popViewController(animated: true)
            return
        }
        projects = allProjects
        print("Hey from ListProjectsVC!")
        }
    
}

extension ListProjectsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
        
        
        let project = projects[indexPath.row]
        cell.mark.text = "Final mark: \(project.final_mark?.toString() ?? "")"
        cell.name.text = "Project: \(project.project?.name ?? "")"
        if (project.validated == true){
            cell.backgroundColor = UIColor(red: 0.4588, green: 0.7137, blue: 0.4, alpha: 1.0)  /* #75B666 */
            cell.validate.text = "Validated"
        }
        else {
            if (project.status == "in_progress" || project.status == "waiting_for_correction" || project.status ==  "searching_a_group"){
                cell.backgroundColor = .white
                
                if let status = project.status  {
                    switch status{
                    case "in_progress":
                            cell.validate.text = "In progress"
                    case "waiting_for_correction":
                            cell.validate.text = "Waiting for correction"
                    default:
                        cell.validate.text = ""
                    }
                }
                else{
                     cell.validate.text = ""
                }
               
            } else {
                cell.backgroundColor = UIColor(red: 0.9608, green: 0.7608, blue: 0.7569, alpha: 1.0) /* #f5c2c1 */
                cell.validate.text = "Failed"
            }
        }
        cell.name.sizeToFit()
        //cell.name.numberOfLines = 0
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


/*
 color
 HTML code:    #75B666
 RGB code:    R: 117 G: 182 B: 102
 HSV:    108.75° 43.96% 71.37%

*/
