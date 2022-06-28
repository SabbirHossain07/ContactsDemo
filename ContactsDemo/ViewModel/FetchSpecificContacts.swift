//
//  fetchSpecificContacts.swift
//  ContactsDemo
//
//  Created by Sopnil Sohan on 20/6/22.
//

import SwiftUI
import Contacts

class FetchSpecificContacts: ObservableObject {
    
    @Published var contacts: [ContactModel] = []
    var contact: ContactModel?
    
    func fetchSpecificContacts() async {
        //Run this in the background async
        
        //Get access to the contacts store
        let store = CNContactStore()
        
        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        
        let predicate = CNContact.predicateForContacts(matchingName: "Kate")
        
        do {
           let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keys)
            
            print(contacts)
        }
        catch {
            //error
        }
    }

    func fetchAllContacts() async {
        //Run this in the background async
        let store = CNContactStore()
        //Get access to the contacts store
        
        //spacify which data key we want to fetch
        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        // Create fetch request
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        
        //call method to fetch all contacts
        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, result in
                //Do something with the block
                self.contact = ContactModel()
                self.contact?.name = contact.givenName
                print (contact.givenName)
                
                for number in contact.phoneNumbers {
                    
                    switch number.label {
                    case CNLabelPhoneNumberMobile:
                        self.contact?.mobile.append(number.value.stringValue)
                        print("- Mobile: \(number.value.stringValue)")
                    case CNLabelPhoneNumberMain:
                        
                        self.contact?.main.append(number.value.stringValue)
                        print("- Main: \(number.value.stringValue)")
                    default:
                        self.contact?.other.append(number.value.stringValue)
                        print("- Other: \(number.value.stringValue)")
                    }
                }
                self.contacts.append(self.contact!)
                print(self.contacts)
            })
        } catch {
            //if there was an error, hendel it here
            print("error")
        }
    }
}
