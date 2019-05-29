//
//  Quizzes+CoreDataProperties.swift
//  
//
//  Created by Zeljko halle on 29/05/2019.
//
//

import Foundation
import CoreData


extension Quizzes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quizzes> {
        return NSFetchRequest<Quizzes>(entityName: "Quizzes")
    }

    @NSManaged public var id: Int16
    @NSManaged public var level: Int16
    @NSManaged public var quizzDescription: String?
    @NSManaged public var imageStringUrl: String?
    @NSManaged public var title: String?
    @NSManaged public var image: NSData?
    @NSManaged public var questions: NSSet?

}

// MARK: Generated accessors for questions
extension Quizzes {

    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: Questions)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: Questions)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)

}
