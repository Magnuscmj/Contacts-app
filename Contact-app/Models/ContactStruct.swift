//
//  ContactStruct.swift
//  Contact-app
//
import UIKit
import Foundation
import Contacts

struct ContactStruct{
    let givenName: String
    let familyName: String
    let number: String
    let email: [CNLabeledValue<NSString>]
    let birthday: Date?
    let age: String
    var postalAddresses: CNPostalAddress?
    var urlAddresses: [CNLabeledValue<NSString>]
}
