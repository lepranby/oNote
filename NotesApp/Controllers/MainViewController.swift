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
    let addButton = UIButton()
    let remindButton = UIButton ()

    func setupAddButton () {

        addButton.setTitle("New note", for: .normal)
        addButton.setTitleColor(.systemOrange, for: .normal)
        addButton.backgroundColor = .systemBackground
        addButton.layer.borderWidth = 2
        addButton.layer.borderColor = UIColor.systemOrange.cgColor
        addButton.layer.cornerRadius = 20
        addButton.clipsToBounds = true
        
        addButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        let _: () = addButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        view.addSubview(addButton)
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(view).inset(115)
            make.left.equalTo(view).inset(-20)
            make.right.equalTo(view).inset(202)
        }
        
    }
    
    func setupRemindButton () {

        remindButton.setTitle("New remind", for: .normal)
        remindButton.setTitleColor(.systemTeal, for: .normal)
        remindButton.backgroundColor = .systemBackground
        remindButton.layer.borderWidth = 2
        remindButton.layer.borderColor = UIColor.systemTeal.cgColor
        remindButton.layer.cornerRadius = 20
        remindButton.clipsToBounds = true
        
        // remindButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        let _: () = remindButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        view.addSubview(remindButton)
        
        remindButton.snp.makeConstraints { make in
            make.top.equalTo(view).inset(115)
            make.right.equalTo(view).offset(20)
            make.left.equalTo(view).inset(202)
        }
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search"
        
        definesPresentationContext = true
        
        setupNavigationController()
        setupTableView()
        fetchNotesFromStorage()
        
        setupRemindButton()
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
        title = "Home"
        navigationController?.hidesBarsOnSwipe = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = false
  
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "oNote", style: .done, target: self, action: #selector(emptyLeftButton))
//        navigationItem.leftBarButtonItem?.tintColor = .systemTeal
        
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
