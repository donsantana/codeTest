//
//  ListController.swift
//  Code Test
//
//  Created by Donelkys Santana on 12/17/18.
//  Copyright © 2018 Donelkys Santana. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class ListController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var peopleContainer = CKContainer.default()
    var peopleList = [Person]()
   
    @IBOutlet weak var listTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listTable.delegate = self
       
        
        navigationItem.title = "List of person"
        navigationController?.navigationBar.prefersLargeTitles = true
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
         self.ListPeople()
    }
    
    //Functions
    
    func ListPeople(){
        let queryPeople = CKQuery(recordType: "People",predicate: NSPredicate(value: true))
        self.peopleContainer.publicCloudDatabase.perform(queryPeople, inZoneWith: nil, completionHandler: ({results, error in
            if (error == nil) {
                self.peopleList.removeAll()
                
                if (results?.count)! > 0{
                    var i = 0
                    
                    while i < (results?.count)!{
                        //Array of Address object
                        var addressArray = [Address]()
                        
                        let addressFromCloud = results?[i].value(forKey: "addresses") as! [String]
                        
                        //Convert the [String] addresses received from the cloud to [Address] to attach to Person
                        for addressString in addressFromCloud{
                            let addStringArray = addressString.components(separatedBy: ",")
                            addressArray.append(Address(address1Text: addStringArray[0], address2Text: addStringArray[1], cityText: addStringArray[2], stateText: addStringArray[3], zipText: addStringArray[4], countryText: addStringArray[5]))
                        }
                        
                        let person = Person(recordName: (results?[i].recordID.recordName)!, firstName: results?[i].value(forKey: "first_name") as! String, lastName: results?[i].value(forKey: "last_name") as! String, dateOfBirth: results?[i].value(forKey: "date_of_birth") as! String, addresses: addressArray, phoneNumbers: results?[i].value(forKey: "phone_numbers") as! [String], emails: results?[i].value(forKey: "emails") as! [String])
                        
                        self.peopleList.append(person)
                        i += 1
                    }
                    DispatchQueue.main.async {
                        self.listTable.reloadData()
                    }
                }else{
                    let alertaClose = UIAlertController (title: NSLocalizedString("No Person",comment:"No Person"), message: NSLocalizedString("No Person were found on your agenda. Do you like to add one?", comment:"No Person were found on your agenda. Do you like to add one?"), preferredStyle: UIAlertController.Style.alert)
                    alertaClose.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment:"Yes"), style: UIAlertAction.Style.default, handler: {alerAction in
                        
                    }))
                    alertaClose.addAction(UIAlertAction(title: NSLocalizedString("No", comment:"No"), style: UIAlertAction.Style.default, handler: {alerAction in
                        exit(0)
                    }))
                    self.present(alertaClose, animated: true, completion: nil)
                }
            }else{
                print("ERROR DE CONSULTA " + error.debugDescription)
            }
        }))
        
    }
    //TABLE FUNCTIONS
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.peopleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        // Configure the cell...
        cell!.textLabel?.text = "\(self.peopleList[indexPath.row].firstName) \(self.peopleList[indexPath.row].lastName)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "NewPerson") as! AddPersonController
        vc.personSelected = peopleList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //FUNCIONES Y EVENTOS PARA ELIMIMAR CELLS, SE NECESITA AGREGAR UITABLEVIEWDATASOURCE
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            self.peopleList[indexPath.row].delete()
            self.peopleList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            tableView.reloadData()
        }
    }
    

    //BUTTONS ACTIONS
    @IBAction func addNewPerson(_ sender: Any) {
        print("herer")
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "NewPerson") as! AddPersonController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
