//
//  AddViewController.swift
//  NotesUIKit
//
//  Created by Алексей Колыченков on 20.11.2023.
//

import UIKit

class AddViewController: UIViewController {
    private let manager = CoreManager.shared
    var note: Note? //Чтобы понимать редактируем или добавляем новый

    private lazy var titleTF: UITextField = {
        let title = UITextField()
        title.placeholder = "Title"
        title.text = note?.title ?? ""
        title.translatesAutoresizingMaskIntoConstraints = false
        title.heightAnchor.constraint(equalToConstant: 50).isActive = true
        title.backgroundColor = .systemGray5
        return title
    }()

    private lazy var textView: UITextView = {
        let text = UITextView()
        text.text = note?.text ?? ""
        text.translatesAutoresizingMaskIntoConstraints = false
        text.heightAnchor.constraint(equalToConstant: 50).isActive = true
        text.backgroundColor = .systemGray5
        text.font = UIFont.systemFont(ofSize: 16)
        return text
    }()

    private lazy var saveButton: UIButton = {
        let btn = UIButton(primaryAction: action)
        btn.setTitle("Save", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private lazy var action = UIAction { [self] _ in
        if self.note == nil {
            self.manager.addNewNote(title: self.titleTF.text ?? "", text: self.textView.text)
        } else {
            self.note?.updateNote(newTitle: self.titleTF.text ?? "", newText: self.textView.text)
        }

        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Add"
        view.addSubview(titleTF)
        view.addSubview(textView)
        view.addSubview(saveButton)
        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            textView.topAnchor.constraint(equalTo: titleTF.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
