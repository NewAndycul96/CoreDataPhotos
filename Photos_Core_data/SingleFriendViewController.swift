//
//  SingleFriendViewController.swift
//  Photos_Core_data
//
//  Created by Anand Kulkarni on 10/19/18.
//  Copyright © 2018 Anand Kulkarni. All rights reserved.
//

import UIKit

class SingleFriendViewController: UIViewController {

    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var contactInfoText: UITextField!
    @IBOutlet weak var photo: UIImage!
    
    var existingFriend: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstNameText.delegate = self as? UITextFieldDelegate
        lastNameText.delegate = self as? UITextFieldDelegate
        contactInfoText.delegate = self as? UITextFieldDelegate
        
        firstNameText.text = existingFriend?.firstName
        lastNameText.text = existingFriend?.lastName
        contactInfoText.text = existingFriend?.contactInfo
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        firstNameText.resignFirstResponder()
        lastNameText.resignFirstResponder()
        contactInfoText.resignFirstResponder()
    }
    
    
    @IBAction func saveFriend(_ sender: Any) {
        let firstName = firstNameText.text
        let lastName = lastNameText.text
        let contactInfo = contactInfoText.text
        
        var friend: Friend?
        
        if let existingFriend = existingFriend {
            existingFriend.firstName = firstName
            existingFriend.lastName = lastName
            existingFriend.contactInfo = contactInfo
            
            friend = existingFriend
        } else {
            friend = Friend(firstName: firstName, lastName: lastName, contentInfo: contactInfo)
        }
        
        if let friend = friend {
            do {
                let managedContext = friend.managedObjectContext
                
                try managedContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            } catch {
                print("Could not be saved")
            }
        }

    }
    
}
