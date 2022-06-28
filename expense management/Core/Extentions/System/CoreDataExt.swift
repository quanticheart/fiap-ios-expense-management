//
//  CoreDataExt.swift
//  expense management
//
//  Created by Jonatas Alves santos on 22/06/22.
//

import Foundation
import CoreData
import UIKit

extension UIViewController {
    func coreDataController<T: NSManagedObject>(with entityClass:T.Type, sortBy:String, isAscending:Bool = true, predicate:NSPredicate? = nil, delegate callback: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<T> {
        
        let entityName = NSStringFromClass(entityClass)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        
        let sorter = NSSortDescriptor(key:sortBy , ascending:isAscending)
        fetchRequest.sortDescriptors = [sorter]
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController.delegate = callback
        return fetchedResultsController
    }
    
    func loadDatabase<T: NSManagedObject>(with entityClass:T.Type, sortBy:String,isAscending:Bool = true) -> [T] {
        let entityName = NSStringFromClass(entityClass)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        
        let sorter = NSSortDescriptor(key:sortBy, ascending:isAscending)
        fetchRequest.sortDescriptors = [sorter]
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
}

func coreDataController<T: NSManagedObject>(_ entityClass:T.Type ,_ context: NSManagedObjectContext, sortBy:String, isAscending:Bool = true, predicate:NSPredicate? = nil) -> NSFetchedResultsController<T> {
    
    let entityName = NSStringFromClass(entityClass)
    let fetchRequest    = NSFetchRequest<T>(entityName: entityName)
    
    let sorter = NSSortDescriptor(key:sortBy, ascending:isAscending)
    fetchRequest.sortDescriptors = [sorter]
    
    let fetchedResultsController = NSFetchedResultsController(
        fetchRequest: fetchRequest,
        managedObjectContext: context,
        sectionNameKeyPath: nil,
        cacheName: nil
    )
    
    return fetchedResultsController
}

