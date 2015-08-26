//
//  ContactsTableViewController.swift
//  ContactsList
//
//  Created by Naji Makhoul on 26/08/15.
//  Copyright (c) 2015 Naji Makhoul. All rights reserved.
//

import UIKit
import CoreData
class ContactsTableViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: contactFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func contactFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Contacts")
        // ** if need  to sort data
        let sortFirstName = NSSortDescriptor(key: "firstName", ascending: true)
        let sortLastName = NSSortDescriptor(key: "lastName", ascending: true)
        fetchRequest.sortDescriptors = [sortFirstName,sortLastName]
        return fetchRequest
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        let numberOfSections = fetchedResultController.sections?.count
        return numberOfSections!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        let numberOfRowsInSection = fetchedResultController.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        let contact = fetchedResultController.objectAtIndexPath(indexPath) as! Contacts
        cell.textLabel?.text =  contact.firstName + " " + contact.lastName
        return cell
    }
    
    // MARK: - TableView Delete
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let managedObject:NSManagedObject = fetchedResultController.objectAtIndexPath(indexPath) as! NSManagedObject
        managedObjectContext?.deleteObject(managedObject)
        managedObjectContext?.save(nil)
    }
    
    // MARK: - TableView Refresh
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "edit" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let contactController:ContactDetailViewController = segue.destinationViewController as! ContactDetailViewController
            let contact:Contacts = fetchedResultController.objectAtIndexPath(indexPath!) as! Contacts
            contactController.contact = contact
        }

    }
    

}
