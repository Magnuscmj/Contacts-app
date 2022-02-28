//
//  ViewController.swift
//  Contact-app
//
import UIKit
import Contacts

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var contactStore = CNContactStore()
    let contact = CNMutableContact()
    var contacts = [ContactStruct](){
            didSet{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let contactToDisplay = contacts[indexPath.row]
        cell.textLabel?.text = contactToDisplay.givenName + " " + contactToDisplay.familyName
        cell.detailTextLabel?.text = contactToDisplay.number + "   |   Age: " + contactToDisplay.age
        
        return cell
    }

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        title = "Contacts"
        
        contactStore.requestAccess(for: .contacts) {
            (success, error) in
            if success {
                print("Authorazation Success")
            } else {
                print("Authorazation Error")
            }
        }
        
        fetchContacts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
            print("I RAN")
            fetchContacts()
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.contactStruct = contacts[(tableView.indexPathForSelectedRow?.row)!]
        }
    }


    func fetchContacts() {
        
        contacts = []
        let key = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactPostalAddressesKey, CNContactUrlAddressesKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: key)
        
        try! contactStore.enumerateContacts(with: request) { (contact, stoppingPointer) in
            let name = contact.givenName
            let familyName = contact.familyName
            let number = contact.phoneNumbers.first?.value.stringValue
            let email = contact.emailAddresses
            let birthday = contact.birthday?.date
            let postalAddresses = contact.postalAddresses.first?.value
            let urlAdress = contact.urlAddresses
            
            if let hasBirthday = birthday{
                let contactToAppend = ContactStruct(givenName: name, familyName: familyName, number: number!, email: email, birthday: birthday, age: String(self.calcAge(birthday: hasBirthday)), postalAddresses: postalAddresses, urlAddresses: urlAdress)
                
                self.contacts.append(contactToAppend)
            
            } else {
                let contactToAppend = ContactStruct(givenName: name, familyName: familyName, number: number ?? "", email: email, birthday: birthday, age: "", postalAddresses: postalAddresses, urlAddresses: urlAdress)
                
                self.contacts.append(contactToAppend)
            }
        }

        tableView.reloadData()
        print(contacts.first?.givenName as Any)
    }
    
    //calculate the age
    func calcAge(birthday: Date) -> Int{
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!

        return age
    }
}



