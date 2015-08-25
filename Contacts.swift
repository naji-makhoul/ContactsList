//
//  Contacts.swift
//  
//
//  Created by Naji Makhoul on 26/08/15.
//
//

import Foundation
import CoreData

class Contacts: NSManagedObject {

    @NSManaged var phone: String
    @NSManaged var lastName: String
    @NSManaged var firstName: String
    @NSManaged var email: String

}
