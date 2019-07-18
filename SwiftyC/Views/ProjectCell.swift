//
//  ProjectCell.swift
//  SwiftyC
//
//  Created by ANASTASIA on 7/18/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var validate: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mark: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
