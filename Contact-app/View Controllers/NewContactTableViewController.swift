//
//  AddNewContactTableTableViewController.swift
//  Contact-app
//
import UIKit
import Contacts

class NewContactTableViewController: UITableViewController {

    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Cancel and Save buttons for create new contacts
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let contact = CNMutableContact()
            contact.givenName = txtFirstName.text!
            contact.familyName = txtLastName.text!
        
        if let hasEnteredEmail = txtEmail.text {
               let homeEmail = CNLabeledValue(label: CNLabelHome, value: hasEnteredEmail as NSString)
                   contact.emailAddresses = [homeEmail]
        }
        
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)
        print("Contact Saved Successfuly")
        
        do {
            try store.execute(saveRequest)
            self.dismiss(animated: true, completion: nil)
            
        } catch {
            print("Saving contact failed, error: \(error)")
            // Handle the error
        }
    }
}
