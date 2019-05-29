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
    @NSManaged public var questions: NSObject?
    @NSManaged public var title: String?
    @NSManaged public var image: NSData?
    @NSManaged public var toQuestions: NSSet?

}

// MARK: Generated accessors for toQuestions
extension Quizzes {

    @objc(addToQuestionsObject:)
    @NSManaged public func addToToQuestions(_ value: Questions)

    @objc(removeToQuestionsObject:)
    @NSManaged public func removeFromToQuestions(_ value: Questions)

    @objc(addToQuestions:)
    @NSManaged public func addToToQuestions(_ values: NSSet)

    @objc(removeToQuestions:)
    @NSManaged public func removeFromToQuestions(_ values: NSSet)

}
