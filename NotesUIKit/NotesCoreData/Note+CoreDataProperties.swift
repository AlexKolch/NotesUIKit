//
//  Note+CoreDataProperties.swift
//  NotesUIKit
//
//  Created by Алексей Колыченков on 19.11.2023.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: String?
    @NSManaged public var text: String?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?

}

extension Note : Identifiable {
    ///Обновление данных
    func updateNote(newTitle: String, newText: String) {
        self.title = newTitle
        self.text = newText
        self.date = Date()

        try? managedObjectContext?.save() //сохраняем контекст
    }

    ///Удаление объекта
    func deleteNote() {
        managedObjectContext?.delete(self) 
        try? managedObjectContext?.save()
    }
}
