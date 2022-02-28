//
//  DetailViewController.swift
//  Contact-app
//
import UIKit
import Contacts

class DetailViewController: UIViewController {
    
    var addressHolder = ""
    var contactStruct: ContactStruct? {
        didSet {
        updateViews()
        }
    }
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var streetLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    func updateViews() {
         guard isViewLoaded,
         let contactStruct = contactStruct else {return}
         title = contactStruct.givenName + " " + contactStruct.familyName
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        
        nameLbl.text = contactStruct.givenName + " " + contactStruct.familyName
        phoneLbl.text = contactStruct.number
        emailLbl.text = String(contactStruct.email.first?.value ?? "")
        ageLbl.text = contactStruct.age
        websiteLbl.text = String(contactStruct.urlAddresses.first?.value ?? "")
        
        if let hasBirthday = contactStruct.birthday{
            birthdayLbl.text = String(dateFormatterPrint.string(from: hasBirthday))
        } else {
            birthdayLbl.text = ""
        }
        
        if let hasPostal = contactStruct.postalAddresses{
            let street = contactStruct.postalAddresses!.street
            let city = contactStruct.postalAddresses!.city
            let country = contactStruct.postalAddresses!.country
            let isoCountryCode = contactStruct.postalAddresses!.isoCountryCode
            let state = contactStruct.postalAddresses!.state
            
            streetLbl.text = CNPostalAddressFormatter.string(from: hasPostal, style: .mailingAddress)
            addressHolder = "\(street) \(city) \(country) \(state) \(isoCountryCode)"
        } else {
            streetLbl.text = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addressSegue = segue.destination as! MapViewController
        
        addressSegue.showAddress = addressHolder
    }
}
    
    

