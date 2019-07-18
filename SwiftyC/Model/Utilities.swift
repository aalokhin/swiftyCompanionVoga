//
//  Utilities.swift
//  SwiftyC
//
//  Created by Anastasiia ALOKHINA on 7/13/19.
//  Copyright © 2019 ANASTASIA. All rights reserved.
//

import Foundation
import UIKit


class Utilities {
    func callErrorWithCustomMessage(message : String, vc : UIViewController) {
        
        let alert = UIAlertController(
            title : "Error",
            message : message,
            preferredStyle : UIAlertControllerStyle.alert
        );
        alert.addAction(UIAlertAction(title: "allright, thank you", style: UIAlertActionStyle.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}

