//
//  Friend+CoreDataClass.swift
//  Photos_Core_data
//
//  Created by Anand Kulkarni on 10/19/18.
//  Copyright © 2018 Anand Kulkarni. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Friend)
public class Friend: NSManagedObject {

    var image: Data?{
        get {
            return rawImage as Data?
        }
        set {
            rawImage = newValue as NSData?
        }
    }
    
//    func UIImagePNGRepresentation(_ image: UIImage) -> Data?{
//        if let imagedata = rawImage as Data?{
//            return UIImage(data: imagedata)
//        }
//    }

    convenience init?(firstName: String?, lastName: String?, contentInfo: String? /*image: Data?*/) {
        let appdelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appdelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Friend.entity(), insertInto: managedContext)
        
        self.firstName = firstName
        self.lastName = lastName
        self.contactInfo = contentInfo
        //self.image = image
    }
}
