//
//  ViewController+CoreData.swift
//  WTesteApp
//
//  Created by mac on 10/03/19.
//  Copyright © 2019 Wesley S. Favarin. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}
