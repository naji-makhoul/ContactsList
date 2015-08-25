//
//  ContactDetailViewController.swift
//  ContactsList
//
//  Created by Naji Makhoul on 26/08/15.
//  Copyright (c) 2015 Naji Makhoul. All rights reserved.
//

import UIKit
import CoreData
class ContactDetailViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet var txtFirstName: UITextField!
    @IBOutlet var txtLastName: UITextField!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var txtEmail: UITextField!
    
    var contact: Contacts? = nil
    var isEditMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if contact != nil {
            setEditMode();
            txtFirstName.text = contact?.firstName
            txtLastName.text = contact?.lastName
            txtPhone.text = contact?.phone
            txtEmail.text = contact?.email
        }

    }

    func setEditMode(){
        var title: String = "Save"
        if !isEditMode {
            title = "Edit"
        }
        self.navigationItem.rightBarButtonItem?.title = title
        txtFirstName.userInteractionEnabled  = isEditMode
        txtLastName.userInteractionEnabled  = isEditMode
        txtPhone.userInteractionEnabled  = isEditMode
        txtEmail.userInteractionEnabled  = isEditMode
        //isEditMode = false
    }

    
    @IBAction func Save(sender: AnyObject){
        if contact != nil{
            if !isEditMode {
                isEditMode = true
                setEditMode()
                txtFirstName.becomeFirstResponder()
            }else{
                editContact()
                dismissViewController()
            }
            
        }else{
            createContact()
            dismissViewController()
            
        }
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewController()
    }
    
    func dismissViewController() {
        navigationController?.popViewControllerAnimated(true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Create contact
    func createContact() {
        
        let entity = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: managedObjectContext!)
        let newContact = Contacts(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        newContact.firstName = txtFirstName.text
        newContact.lastName = txtLastName.text
        newContact.phone = txtPhone.text
        newContact.email = txtEmail.text
        
        managedObjectContext?.save(nil)
        
    }
    
    // MARK:- Edit contact
    func editContact() {
        contact?.firstName = txtFirstName.text
        contact?.lastName = txtLastName.text
        contact?.phone = txtPhone.text
        contact?.email = txtEmail.text
        managedObjectContext?.save(nil)
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
