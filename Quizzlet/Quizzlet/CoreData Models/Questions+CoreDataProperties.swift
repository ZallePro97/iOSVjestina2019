//
//  Questions+CoreDataProperties.swift
//  
//
//  Created by Zeljko halle on 29/05/2019.
//
//

import Foundation
import CoreData


extension Questions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Questions> {
        return NSFetchRequest<Questions>(entityName: "Questions")
    }

    @NSManaged public var answers: NSObject?
    @NSManaged public var correctAnswer: Int16
    @NSManaged public var id: Int16
    @NSManaged public var question: String?
    @NSManaged public var toQuizz: Quizzes?

}
