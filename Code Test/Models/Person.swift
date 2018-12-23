//
//  Person.swift
//  Code Test
//
//  Created by Donelkys Santana on 12/17/18.
//  Copyright © 2018 Donelkys Santana. All rights reserved.
//

import Foundation
import CloudKit

class Person {
    var recordName: String
    var firstName: String
    var lastName: String
    var dateOfBirth: String
    var addresses:[Address]
    var phoneNumbers: [String]
    var emails: [String]
    
    //Cloud Container
    var personContainer = CKContainer.default()
    
    
    init(recordName: String, firstName: String, lastName: String, dateOfBirth: String, addresses:[Address], phoneNumbers: [String], emails: [String]) {
        
        self.recordName = recordName
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.addresses = addresses
        self.phoneNumbers = phoneNumbers
        self.emails = emails
        
    }
    
    func save(){
        
        var addressArray = [String]()
        for address in addresses{
            //let address = "\(address.address1Text!),\(address.address2Text),\(address.cityText),\(address.stateText),\(address.zipText),\(address.countryText)"
            addressArray.append("\(address.address1Text!),\(address.address2Text!),\(address.cityText!),\(address.stateText!),\(address.zipText!),\(address.countryText!),")
        }
        
        let recordPerson = CKRecord(recordType: "People")
        recordPerson.setObject(self.firstName as CKRecordValue, forKey: "first_name")
        recordPerson.setObject(self.lastName as CKRecordValue, forKey: "last_name")
        recordPerson.setObject(self.dateOfBirth as CKRecordValue, forKey: "date_of_birth")
        recordPerson.setObject(addressArray as CKRecordValue, forKey: "addresses")
        recordPerson.setObject(self.phoneNumbers as CKRecordValue, forKey: "phone_numbers")
        recordPerson.setObject(self.emails as CKRecordValue, forKey: "emails")
        
        if self.recordName == ""{
            let personRecordsOperation = CKModifyRecordsOperation(recordsToSave: [recordPerson],recordIDsToDelete: nil)
            self.personContainer.publicCloudDatabase.add(personRecordsOperation)
        }else{
            let recordId = CKRecord.ID(recordName: self.recordName)
            self.personContainer.publicCloudDatabase.fetch(withRecordID: recordId, completionHandler: { (record, error) in
                if error != nil {
                    print("Error fetching record: \(error?.localizedDescription)")
                } else {
                    // Save this record again
                    record!.setObject(self.firstName as CKRecordValue, forKey: "first_name")
                    record!.setObject(self.lastName as CKRecordValue, forKey: "last_name")
                    record!.setObject(self.dateOfBirth as CKRecordValue, forKey: "date_of_birth")
                    record!.setObject(addressArray as CKRecordValue, forKey: "addresses")
                    record!.setObject(self.phoneNumbers as CKRecordValue, forKey: "phone_numbers")
                    record!.setObject(self.emails as CKRecordValue, forKey: "emails")
                    
                    self.personContainer.publicCloudDatabase.save(record!, completionHandler: { (savedRecord, saveError) in
                        if saveError != nil {
                            print("dkfjd \(saveError.debugDescription)")
                        } else {
                            print("rere")
                        }
                    })
                }
                
            })
        }
        
    }
    
    func delete(){
        let recordId = CKRecord.ID(recordName: self.recordName)
        self.personContainer.publicCloudDatabase.delete(withRecordID: recordId, completionHandler: { (deletedRecord, deleteError) in
            if deleteError != nil {
                print("error \(deleteError.debugDescription)")
            } else {
                print("deleted")
            }
        })
    }
    
    
}
