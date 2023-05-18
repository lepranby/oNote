//  MainViewController.swift
//  NotesApp
//
//  Created by Aleksej Shapran on 16/02/23

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var searchedNotes = [Note] ()
    static var notes = [Note] ()
    
    var searchController = UISearchController(searchResultsController: nil)
        
    var tableView: UITableView?
    let label = UILabel ()
    let addButton = UIButton ()
    
    private func setupLabel () {
        
        view.addSubview(label)
        label.text = "No notes yet. You can add a new note right now!"
        label.font = .systemFont(ofSize: 24, weight: .light)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.numberOfLines = 3
        
        label.snp.makeConstraints { make in
            make.top.equalTo(view).inset(225)
            make.left.right.equalTo(view).inset(100)
        }
    }


    func setupAddButton () {

        addButton.setTitle("New note", for: .normal)
        addButton.setTitleColor(.systemOrange, for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 28, weight: .light)
        addButton.titleLabel?.textAlignment = .center
        addButton.configuration?.titleAlignment = .center
        addButton.backgroundColor = .systemGray6
        addButton.layer.borderWidth = 2
        addButton.layer.borderColor = UIColor.systemOrange.cgColor
        
//        addButton.setTitle("New note", for: .normal)
//        addButton.setTitleColor(.white, for: .normal)
//        addButton.titleLabel?.font = .systemFont(ofSize: 28, weight: .light)
//        addButton.titleLabel?.textAlignment = .center
//        addButton.configuration?.titleAlignment = .center
//        addButton.backgroundColor = .systemOrange
//        addButton.clipsToBounds = true
        
        addButton.layer.cornerRadius = 12
        
        addButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        let _: () = addButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(addButton)
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).inset(40)
            make.left.right.equalTo(view).inset(18)
        }
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
        
        setupNavigationController()
        setupTableView()
        fetchNotesFromStorage()
        
        setupLabel()
        setupAddButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeCellIfEmpty()
    }
    
    
    @objc private func didTapButton() {
        
        let newNote = CoreDataManager.shared.createNote()
        MainViewController.notes.insert(newNote, at: 0)
        
        tableView!.beginUpdates()
        tableView!.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        tableView!.endUpdates()
        
        let noteVC = NoteViewController()
        noteVC.noteCell = nil
        noteVC.set(noteId: newNote.id)
        noteVC.set(noteCell: (tableView?.cellForRow(at: IndexPath(row: 0, section: 0) ) as! NoteCell))
        
        navigationController?.pushViewController(noteVC, animated: true)
    }
    
    private func setupNavigationController() {
        title = "oNotes"
        navigationController?.hidesBarsOnSwipe = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: (UIImage(systemName: "person.crop.rectangle.stack.fill"))?.withTintColor(UIColor.systemOrange, renderingMode: .alwaysOriginal), style: .plain,  target: self, action: #selector(emptyLeftButton))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: (UIImage(systemName: "gearshape.fill"))?.withTintColor(UIColor.systemTeal, renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(emptyLeftButton))
        
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
    
    @objc func emptyLeftButton () {
        print("logo tapped")
    }
    
}
