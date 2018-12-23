//
//  AddPersonController.swift
//  Code Test
//
//  Created by Donelkys Santana on 12/18/18.
//  Copyright © 2018 Donelkys Santana. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects

@available(iOS 11.0, *)
class AddPersonController: UITableViewController, UITextFieldDelegate {
    
    var personSelected: Person!
    var phoneNumbersArray = [String]()
    var emailsArray = [String]()
    var addressArray = [Address]()
    
    private var datePicker: UIDatePicker?
    
    var firstName: HoshiTextField!
    var lastName: HoshiTextField!
    var dateOfBirth: HoshiTextField!
    var dataView = UIView()
    
    @IBOutlet weak var actionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let widthScreen = UIScreen.main.bounds.width - 20
       
        navigationItem.title = "Person Info"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Initializing placeholder
        self.firstName = HoshiTextField.init(frame: CGRect(x: 20, y: 10, width: widthScreen, height: 40))
        self.firstName.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        self.firstName.placeholderColor = UIColor.gray
        self.firstName.placeholderFontScale = 1.0
        self.firstName.placeholder = "First name"
        self.firstName.borderInactiveColor = UIColor.gray
        
        self.lastName = HoshiTextField.init(frame: CGRect(x: 20, y: 55, width: widthScreen, height: 40))
        self.lastName.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        self.lastName.placeholderColor = UIColor.gray
        self.lastName.placeholderFontScale = 1.0
        self.lastName.placeholder = "Last name"
        self.lastName.borderInactiveColor = UIColor.gray
        
        self.dateOfBirth = HoshiTextField.init(frame: CGRect(x: 20, y: 100, width: widthScreen, height: 40))
        self.dateOfBirth.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        self.dateOfBirth.placeholderColor = UIColor.gray
        self.dateOfBirth.placeholderFontScale = 1.0
        self.dateOfBirth.placeholder = "Date of birth"
        self.dateOfBirth.borderInactiveColor = UIColor.gray
        
        
        self.dataView.addSubview(self.firstName)
        self.dataView.addSubview(self.lastName)
        self.dataView.addSubview(self.dateOfBirth)
        
        self.firstName.delegate = self
        self.lastName.delegate = self
        self.dateOfBirth.delegate = self

        
        //binding dateOfBirth with datePicker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        datePicker?.addTarget(self, action: #selector(AddPersonController.dateChange(datePicker:)), for: .valueChanged)
        dateOfBirth.inputView = datePicker
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(AddPersonController.dismissPicker))
        dateOfBirth.inputAccessoryView = toolBar
        
        if personSelected != nil {
            self.firstName.text = personSelected.firstName
            self.lastName.text = personSelected.lastName
            self.dateOfBirth.text = personSelected.dateOfBirth
            self.addressArray = personSelected.addresses
            self.phoneNumbersArray = personSelected.phoneNumbers
            self.emailsArray = personSelected.emails
        }else{
            self.actionButton.setTitle("Create", for: .normal)
        }

    }
    
    //Date picker functions
    @objc func dateChange( datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        self.dateOfBirth.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    @objc func addPhone(){
        let lastRow = self.tableView!.numberOfRows(inSection: 1)-1
        if lastRow >= 0{
            let cell = self.tableView.viewWithTag(Int("1\(lastRow)")!) as! ItemViewCell
            self.phoneNumbersArray[lastRow] = cell.itemText.text!
        }
        self.phoneNumbersArray.append("")
        self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
    }
    
    @objc func addEmail(){
        let lastRow = self.tableView!.numberOfRows(inSection: 2)-1
        if lastRow >= 0{
            let cell = self.tableView.viewWithTag(Int("2\(lastRow)")!) as! ItemViewCell
            self.emailsArray[lastRow] = cell.itemText.text!
      
        }
        self.emailsArray.append("")
        self.tableView.reloadSections(IndexSet(integer: 2), with: .none)
    }
    
    @objc func addAddress(){
        let lastRow = self.tableView!.numberOfRows(inSection: 3)-1
        if lastRow >= 0{
            let cell = self.tableView.viewWithTag(Int("3\(lastRow)")!) as! AddressViewCell
            let address = Address(address1Text: cell.address1Text.text!, address2Text: cell.address2Text.text!, cityText: cell.cityText.text!, stateText: cell.stateText.text!, zipText: cell.zipText.text!, countryText: cell.countryText.text!)
            self.addressArray[lastRow] = address
            
        }
        let address = Address(address1Text: "", address2Text: "", cityText: "", stateText: "", zipText: "", countryText: "")
        self.addressArray.append(address)
        self.tableView.reloadSections(IndexSet(integer: 3), with: .none)
    }
    
    //TABLE FUNCTIONS
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        switch section {
        case 0:
            return self.dataView
        case 1:
            label.text = "Phone Numbers:"
        case 2:
            label.text = "Emails:"
        case 3:
            label.text = "Address:"
        default:
            label.text = ""
        }
        return label
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let addressView = UIView()
            let button:UIButton = UIButton.init(frame: CGRect(x: 0, y: 5, width: 120, height: 20))
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.setTitle("+ Phone", for: .normal)
            button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 15)
            button.addTarget(self, action: #selector(AddPersonController.addPhone), for: .touchUpInside)
            addressView.addSubview(button)
            return addressView
        case 2:
            let addressView = UIView()
            let button:UIButton = UIButton.init(frame: CGRect(x: 0, y: 5, width: 120, height: 20))
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.setTitle("+ Email", for: .normal)
            button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 15)
            button.addTarget(self, action: #selector(AddPersonController.addEmail), for: .touchUpInside)
            addressView.addSubview(button)
            return addressView
        case 3:
            let addressView = UIView()
            let button:UIButton = UIButton.init(frame: CGRect(x: 0, y: 5, width: 120, height: 20))
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.setTitle("+ Address", for: .normal)
            button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 15)
            button.addTarget(self, action: #selector(AddPersonController.addAddress), for: .touchUpInside)
            addressView.addSubview(button)
            return addressView
        default:
            return UITextField()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 1:
            return self.phoneNumbersArray.count
        case 2:
            return self.emailsArray.count
        case 3:
            return self.addressArray.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("ItemViewCell", owner: self, options: nil)?.first as! ItemViewCell
        cell.itemText.delegate = self
        switch indexPath.section {
        case 1:
            cell.itemText.placeholder = "Phone number"
            cell.itemText.keyboardType = .phonePad
            cell.itemText.becomeFirstResponder()
            cell.itemText.text = self.phoneNumbersArray[indexPath.row]
        case 2:
            cell.itemText.placeholder = "Email"
            cell.itemText.keyboardType = .emailAddress
            cell.itemText.becomeFirstResponder()
            cell.itemText.text = self.emailsArray[indexPath.row]
        case 3:
            let addressCell = Bundle.main.loadNibNamed("AddressViewCell", owner: self, options: nil)?.first as! AddressViewCell
            addressCell.address1Text.text = self.addressArray[indexPath.row].address1Text
            addressCell.address2Text.text = self.addressArray[indexPath.row].address2Text
            addressCell.cityText.text = self.addressArray[indexPath.row].cityText
            addressCell.stateText.text = self.addressArray[indexPath.row].stateText
            addressCell.zipText.text = self.addressArray[indexPath.row].zipText
            addressCell.countryText.text = self.addressArray[indexPath.row].countryText
            addressCell.tag = Int("\(indexPath.section)\(indexPath.row)")!
            //addressCell.address1Text.becomeFirstResponder()
            return addressCell
        default:
            cell.itemText.text = ""
        }
        cell.tag = Int("\(indexPath.section)\(indexPath.row)")!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 130
        default:
            return 40.0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 3:
            return 183
        default:
            return 40.0
        }
    }
    
   
    //BUTTONS
    
    @IBAction func savePerson(_ sender: Any) {
        if (self.firstName.text != "") && (self.lastName.text != "") && (self.dateOfBirth.text != "") {
            if self.tableView!.numberOfRows(inSection: 1)-1 >= 0{
                self.phoneNumbersArray = [String]()
                for indexPath in 0...(self.tableView!.numberOfRows(inSection: 1)-1){
                    let phoneCell = self.tableView.viewWithTag(Int("1\(indexPath)")!) as! ItemViewCell
                    if phoneCell.itemText.text != ""{
                        self.phoneNumbersArray.append(phoneCell.itemText.text!)
                    }
                }
            }
            if self.tableView!.numberOfRows(inSection: 2)-1 >= 0{
                self.emailsArray = [String]()
                for indexPath in 0...(self.tableView!.numberOfRows(inSection: 2)-1){
                    let emailCell = self.tableView.viewWithTag(Int("2\(indexPath)")!) as! ItemViewCell
                    if emailCell.itemText.text != ""{
                        self.emailsArray.append(emailCell.itemText.text!)
                    }
                }
            }
            if self.tableView!.numberOfRows(inSection: 3)-1 >= 0{
                self.addressArray = [Address]()
                for indexPath in 0...(self.tableView!.numberOfRows(inSection: 3)-1){
                    let addressCell = self.tableView.viewWithTag(Int("3\(indexPath)")!) as! AddressViewCell
                    if addressCell.address1Text.text != ""{
                        let addressTemp = Address(address1Text: addressCell.address1Text.text!, address2Text: addressCell.address2Text.text!, cityText: addressCell.cityText.text!, stateText: addressCell.stateText.text!, zipText: addressCell.zipText.text!, countryText: addressCell.countryText.text!)
                        self.addressArray.append(addressTemp)
                    }
                }
            }
            
            let newPerson = Person(recordName: self.personSelected != nil ? self.personSelected.recordName : "", firstName: self.firstName.text!, lastName: self.lastName.text!, dateOfBirth: self.dateOfBirth.text!, addresses: self.addressArray, phoneNumbers: self.phoneNumbersArray, emails: self.emailsArray)
            newPerson.save()
            
            //Navigate back to List of person view
            self.navigationController?.popToRootViewController(animated: true)
            
            
        }else{
            let alertaClose = UIAlertController (title: NSLocalizedString("No Person",comment:"No Person"), message: NSLocalizedString("First Name, Last Name and Date of Birth are required to create or update a person. Please type that information.", comment:"No data"), preferredStyle: UIAlertController.Style.alert)
            alertaClose.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment:"Yes"), style: UIAlertAction.Style.default, handler: {alerAction in
                
            }))
    
            self.present(alertaClose, animated: true, completion: nil)
        }
    
    }
    
}

extension UIToolbar {
    
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}
