//
//  UserInfoVC.swift
//  SwiftyC
//
//  Created by ANASTASIA on 7/9/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation
import UIKit

class UserInfoVC : UIViewController {
    
    @IBOutlet weak var userPicture: UIImageView!
    
    @IBOutlet weak var SkillsButton: UIButton!
    @IBOutlet weak var SeeAllProjectsButton: UIButton!
    
    @IBOutlet weak var displayNameLbl: UILabel!
    @IBOutlet weak var xLoginlbl: UILabel!
    
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var lvl: UILabel!
    
    @IBOutlet weak var corrections: UILabel!
    @IBOutlet weak var wallet: UILabel!
    var cursusCur : CursusUser?
    
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            print("42 selected")
            setCursus("42")
            updateView()
        case 1:
            print("piscine c selected")
            setCursus("piscine-c")
            updateView()
        default:
            break
        }
    }
    
    func setCursus (_ cursusName : String){
        guard let cursusUsers = Client.sharedInstance.currrentUser?.cursus_users else {
            self.navigationController?.popViewController(animated: true)
            return
            
        }
    
        let index = cursusUsers.index(where: { (item) -> Bool in
            item.cursus?.slug == cursusName
        })
        
        guard let i = index else {
            print("No cursus  detected")
            hideExtra()
           // self.navigationController?.popViewController(animated: true)
            return
        }
        self.cursusCur = cursusUsers[i]
    }
    
    
    @IBAction func SkillsTapped(_ sender: UIButton) {
        
        print("tapped skills ")
        evokeViewController(storyboard: "ChartView", vcIdentifier: "ChartVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = Client.sharedInstance.currrentUser else {
            navigationController?.popViewController(animated: true)
            return
        }
       
        setCursus("42")
        print("Hey from UserInfoVC!")
        updateView()
        xLoginlbl.sizeToFit()
        xLoginlbl.numberOfLines = 0
        displayNameLbl.sizeToFit()
        displayNameLbl.numberOfLines = 0
        displayNameLbl.text = "\(cursusCur?.user?.login ?? "")"
        xLoginlbl.text = user.displayname ?? ""
        print(user.location ?? "Unavailable")

        let location : String = user.location ?? "Unavailable"
        locationLbl.text = location
        
        emailLbl.text = user.email ?? ""
        phoneLbl.text = user.phone ?? ""
     
        if let pctr = user.image_url{
            if let pctrURL = URL(string: pctr)
            {
                userPicture.load(url : pctrURL)
                print("all right, picture exists and loads")
            }
        }
        if (user.staff == true){
            self.hideExtra()
           // return
        }
      
    }
    
    @IBAction func SeeAllProjectsTapped(_ sender: UIButton) {
        print("SeeAllProjects Tapped")
        evokeViewController(storyboard: "ListProjects", vcIdentifier: "ListProjectsVC")
    }
    
}

extension UserInfoVC {
    
    func updateView(){
        guard let user = Client.sharedInstance.currrentUser else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        if (cursusCur?.cursus?.slug == "42"){
            corrections.isHidden = false
            corrections.sizeToFit()
            wallet.sizeToFit()
            wallet.isHidden = false
            lvl.isHidden = false
            corrections.text = "CP: \(user.correction_point?.toString() ?? "")"
            wallet.text = "Wallet: \(user.wallet?.toString() ?? "")₳"
            SeeAllProjectsButton.isHidden = false
            lvl.text = "Level: \(cursusCur?.level?.toString() ?? "")"
        } else {
            corrections.isHidden = true
            lvl.isHidden = true
            SeeAllProjectsButton.isHidden = true
            wallet.text =  "Level: \(cursusCur?.level?.toString() ?? "")"
            
        }
       
    }
    
    func evokeViewController(storyboard : String, vcIdentifier : String) {
        let storyboard = UIStoryboard.init(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier : vcIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func hideExtra(){
//        guard let user = Client.sharedInstance.currrentUser else {
//            self.navigationController?.popViewController(animated: true)
//            return
//        }
        print("User is staff")
//        SkillsButton.isHidden = true
//        SeeAllProjectsButton.isHidden = true
//        lvl.isHidden = true
//        wallet.isHidden = true
//        corrections.isHidden = true
//        segmentControl.isHidden = true
//        displayNameLbl.isHidden = true
//       locationLbl.isHidden = true
//        phoneLbl.isHidden = true
        
        SkillsButton.isEnabled = false
        SeeAllProjectsButton.isEnabled = false
        segmentControl.isEnabled = false
        
//        lvl.text = ""
//        wallet.text = ""
//        corrections.text = ""
//        displayNameLbl.text = ""

        return

    }
}



