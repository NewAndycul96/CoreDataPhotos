//
//  PhotosViewController.swift
//  Photos_Core_data
//
//  Created by Anand Kulkarni on 10/19/18.
//  Copyright © 2018 Anand Kulkarni. All rights reserved.
//

import UIKit
import CoreData

class PhotosViewController: UIViewController  {


    @IBOutlet weak var photosTableView: UITableView!
    
    var friend = [Friend]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appdelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Friend> = Friend.fetchRequest()
        do {
            friend = try managedContext.fetch(fetchRequest)
            
            photosTableView.reloadData()
        } catch {
            print("Fetch could not be performed")
        }
}
    @IBAction func addNewFriend(_ sender: Any) {
        performSegue(withIdentifier: "infoCell", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SingleFriendViewController,
            let selectedRow = self.photosTableView.indexPathForSelectedRow?.row else {
                return
        }
        
        destination.existingFriend = friend[selectedRow]
    }
    
    func deleteFriend(at indexPath: IndexPath) {
        let friends = friend[indexPath.row]
        
         if let managedContext = friends.managedObjectContext {
            managedContext.delete(friends)
            
            do{
                try managedContext.save()
                
                self.friend.remove(at: indexPath.row)
                
                photosTableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print("Delete Failed")
                
                photosTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

extension PhotosViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friend.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = photosTableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath as IndexPath) as! imageTableViewCell
        let friends = friend[indexPath.row]
        
        cell.textLabel?.text = friends.firstName
        cell.textLabel?.text = friends.lastName
        cell.textLabel?.text = friends.contactInfo
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFriend(at: indexPath)
        }
    }
}

extension PhotosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "infoCell", sender: self)
    }
}
