//
//  AddMemberTableViewController.swift
//  FinalProject
//
//  Created by Rodrigo Coutinho on 2017-04-04.
//  Copyright © 2017 Rodrigo Coutinho. All rights reserved.
//

import UIKit
import MapKit

protocol AddMemberTableViewControllerDelegate: class {
    func addMemberTableViewControllerDidCancel(_ controller: AddMemberTableViewController)
    func addMemberTableViewController(_ controller: AddMemberTableViewController, didFinishAddingMember member: MemberMO)
    func addMemberTableViewController(_ controller: AddMemberTableViewController, didFinishEditing member: MemberMO)
}

class AddMemberTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var member: MemberMO?
    var annotation = MKPointAnnotation()
    
    var delegate: AddMemberTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let member = member {
            
            title = "Edit Member"
            
            nameTextField.text = member.name
            phoneTextField.text = member.phone
            emailTextField.text = member.email
            addressTextField.text = member.address
            
            if let address = addressTextField.text, !address.isEmpty {
                locateMemberAddress(address)
            }
            
        }
        
    }
    
    func locateMemberAddress(_ address: String) {
        
        mapView.removeAnnotation(annotation)
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address, completionHandler: { (placemarks, erro) in
            
            guard let placemarks = placemarks, let location = placemarks.first!.location else {
                return
            }
            
            let zoom = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegionMake(location.coordinate, zoom)
            self.mapView.setRegion(region, animated: true)
            
            let memberAnnotation = MKPointAnnotation()
            memberAnnotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            self.mapView.addAnnotation(memberAnnotation)
            self.annotation = memberAnnotation
            
        })
        
    }

    @IBAction func presentMemberAddress(_ sender: UIButton) {
        
        view.endEditing(true)
        guard let address = addressTextField.text, !address.isEmpty else {
            let alertController = UIAlertController(title: "Empty address", message: "Please type the member address to present it on the map", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            addressTextField.becomeFirstResponder()
            return
        }
        
        locateMemberAddress(address)
        
    }
    
    @IBAction func saveMember(_ sender: Any) {
        
        if let member = member {
            
            if let name = nameTextField.text, !name.isEmpty {
                
                member.name = name
                member.phone = phoneTextField.text!
                member.email = emailTextField.text!
                member.address = addressTextField.text!
                
                delegate?.addMemberTableViewController(self, didFinishEditing: member)
                
                
            } else {
                let alertController = UIAlertController(title: "Empty name", message: "Please provide the member name before trying to save", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
                
                nameTextField.becomeFirstResponder()
            }
            
        } else {
            
            if let name = nameTextField.text, !name.isEmpty {
                if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                    let member = MemberMO(context: appDelegate.persistentContainer.viewContext)
                    member.name = name
                    member.address = addressTextField.text
                    member.phone = phoneTextField.text
                    member.email = emailTextField.text
                    
                    delegate?.addMemberTableViewController(self, didFinishAddingMember: member)
                }
            } else {
                let alertController = UIAlertController(title: "Empty name", message: "Please provide the member name before trying to save", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
                
                nameTextField.becomeFirstResponder()
            }
            
        }
        
    }
    
    @IBAction func cancelAddMember(_ sender: UIBarButtonItem) {
        delegate?.addMemberTableViewControllerDidCancel(self)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
