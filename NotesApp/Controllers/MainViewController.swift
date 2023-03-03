//  MainViewController.swift
//  NotesApp
//
//  Created by Aleksej Shapran on 16/02/23.

import UIKit

class MainViewController: UIViewController {
    
    var searchedNotes = [Note]()
    static var notes = [Note]()
    
    var searchController = UISearchController(searchResultsController: nil)
        
    var tableView: UITableView?
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // setting up search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Пошук"
        definesPresentationContext = true
        
        setupNavigationController()
        setupTableView()
        setupLabel()
        fetchNotesFromStorage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeCellIfEmpty()
    }
    
    @objc private func didTapButton() {
        
        let newNote = CoreDataManager.shared.createNote()
        MainViewController.notes.insert(newNote, at: 0)
        
        tableView!.beginUpdates()
        tableView!.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView!.endUpdates()
        
        let noteVC = NoteViewController()
        noteVC.noteCell = nil
        noteVC.set(noteId: newNote.id)
        noteVC.set(noteCell: (tableView?.cellForRow(at: IndexPath(row: 0, section: 0) ) as! NoteCell))
        
        navigationController?.pushViewController(noteVC, animated: true)
    }
    
    @objc private func settingsTapButton() {
        
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    private func setupLabel() {
        view.addSubview(label)
        label.text = "Няма нататак"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 30),
            label.widthAnchor.constraint(equalToConstant: 120),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNavigationController() {
        title = "oNote"
        navigationController?.hidesBarsOnSwipe = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: (UIImage(systemName: "doc.badge.plus"))?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(didTapButton))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: (UIImage(systemName: "gearshape"))?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(settingsTapButton))
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        search(text: text)
    }
    
    func search(text: String) {
        searchNotesFromStorage(text)
    }
    
}
