//
//  NotesTableVCTableViewController.swift
//  NotesUIKit
//
//  Created by Алексей Колыченков on 19.11.2023.
//

import UIKit

class NotesTableVC: UITableViewController {

    private let manager = CoreManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        configureNavBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    private func configureNavBar() {
        title = "Notes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { _ in
            let addVC = AddViewController()
            self.navigationController?.pushViewController(addVC, animated: true)
        }))
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = manager.notes[indexPath.row].title
        content.secondaryText = manager.notes[indexPath.row].text

        cell.contentConfiguration = content
        return cell
    }

    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddViewController()
        vc.note = manager.notes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = manager.notes[indexPath.row]
            note.deleteNote()
            manager.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension NotesTableVC {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
