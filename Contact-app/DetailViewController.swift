//
//  DetailViewController.swift
//  Contact-app
//
//  Created by Magnus Jensen on 25/02/2022.
//

import UIKit
import Contacts

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var contact:ContactStruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = contact?.givenName
        phoneLabel.text = contact?.number
        
        
    }
}
