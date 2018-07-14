//
//  UserMO+CoreDataProperties.swift
//  
//
//  Created by Admin on 7/14/18.
//
//

import Foundation
import CoreData


extension UserMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserMO> {
        return NSFetchRequest<UserMO>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var heroID: String?
    @NSManaged public var tien: String?
    @NSManaged public var diachi: String?
    @NSManaged public var linkima: String?
    @NSManaged public var tokenfb: String?

    
    static func insertNewDepartment(name: String?, heroID: String?, tien: String?, diachi: String?, linkima: String?, tokenfb: String?) -> UserMO{
        let department = 
        
    }
}
