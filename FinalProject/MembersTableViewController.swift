//
//  MembersTableViewController.swift
//  FinalProject
//
//  Created by Rodrigo Coutinho on 21/03/17.
//  Copyright © 2017 Rodrigo Coutinho. All rights reserved.
//

import UIKit
import CoreData

protocol MembersTableViewControllerDelegate: class {
    func membersTableViewController(_ controller: MembersTableViewController, didFinishSelecting member: MemberMO)
}

class MembersTableViewController: UITableViewController {

    weak var delegate: MembersTableViewControllerDelegate?
    
    var members = [MemberMO]()
    
    var fetchResultController: NSFetchedResultsController<MemberMO>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<MemberMO> = MemberMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    members = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath)
        
        let member = members[indexPath.row]
        cell.textLabel?.text = member.name
        cell.detailTextLabel?.text = member.phone
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let member = members[indexPath.row]
        
        delegate?.membersTableViewController(self, didFinishSelecting: member)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editMember" {
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                
                let member = members[indexPath.row]
                
                let navController = segue.destination as! UINavigationController
                let addMemberVC = navController.topViewController as! AddMemberTableViewController
                addMemberVC.delegate = self
                addMemberVC.member = member
                
            }
            
        } else if segue.identifier == "addMember" {
            
            let navController = segue.destination as! UINavigationController
            let addMemberVC = navController.topViewController as! AddMemberTableViewController
            addMemberVC.delegate = self
            
        }
        
    }
    
}

extension MembersTableViewController: AddMemberTableViewControllerDelegate {
    
    func addMemberTableViewControllerDidCancel(_ controller: AddMemberTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addMemberTableViewController(_ controller: AddMemberTableViewController, didFinishAddingMember member: MemberMO) {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            appDelegate.saveContext()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func addMemberTableViewController(_ controller: AddMemberTableViewController, didFinishEditing member: MemberMO) {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            if let index = members.index(of: member) {
                members[index] = member
                appDelegate.saveContext()
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension MembersTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchObjects = controller.fetchedObjects {
            members = fetchObjects as! [MemberMO]
        }
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}

func < (lhs: Member, rhs: Member) -> Bool {
    return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
}
