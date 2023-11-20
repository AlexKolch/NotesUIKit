//
//  CoreManager.swift
//  NotesUIKit
//
//  Created by Алексей Колыченков on 19.11.2023.
//

import Foundation
import CoreData

class CoreManager {
    static let shared = CoreManager()
    var notes = [Note]()

    private init() {
        fetchAllNotes()
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "NotesUIKit")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    ///Запрос заметок
    func fetchAllNotes() {
        let req = Note.fetchRequest()
        //достаем заметки
        if let notes = try? persistentContainer.viewContext.fetch(req) {
            self.notes = notes
        }
    }

    ///Добавление заметки
    func addNewNote(title: String, text: String) {
        let newNote = Note(context: persistentContainer.viewContext)
        newNote.id = UUID().uuidString
        newNote.title = title
        newNote.text = text
        newNote.date = Date()

        saveContext() //Cохраняем
        fetchAllNotes() //Получаем обновленные данные
    }
}
