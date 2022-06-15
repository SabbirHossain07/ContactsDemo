//
//  ContentView.swift
//  ContactsDemo
//
//  Created by Sopnil Sohan on 16/6/22.
//

import SwiftUI
import Contacts

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                Task.init {
                    await fetchAllContacts()
                }
            }
    }
    
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
                print (contact.givenName)
                for number in contact.phoneNumbers {
                    
                    switch number.label {
                    case CNLabelPhoneNumberMobile:
                        print("- Mobile: \(number.value.stringValue)")
                    case CNLabelPhoneNumberMain:
                        print("- Main: \(number.value.stringValue)")
                    default:
                        print("- Other: \(number.value.stringValue)")
                    }
                }
            })
        } catch {
            //if there was an error, hendel it here
            print("error")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
