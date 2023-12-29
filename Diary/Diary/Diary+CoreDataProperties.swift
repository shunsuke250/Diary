//
//  Diary+CoreDataProperties.swift
//  Diary
//
//  Created by 副山俊輔 on 2023/12/18.
//
//

import Foundation
import CoreData


extension Diary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Diary> {
        return NSFetchRequest<Diary>(entityName: "Diary")
    }

    @NSManaged public var date: Date?
    @NSManaged public var content: String?

}

extension Diary : Identifiable {

}
