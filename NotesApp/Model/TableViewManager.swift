//  TableViewManager.swift
//  NotesApp
//
//  Created by Aleksej Shapran on 16/02/23.

import UIKit
import SnapKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    private var searchBarIsEmpty: Bool {
        
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    
    private var isSearching: Bool {
        
        return searchController.isActive && !searchBarIsEmpty
    }

    internal func setupTableView() {
        
        let tableView = UITableView(frame: .zero)
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.id)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.backgroundColor = .systemGray2.withAlphaComponent(0.2)
        tableView.separatorColor = .systemGray2.withAlphaComponent(0.2)
        self.tableView = tableView

        tableView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            label.isHidden = true
            return searchedNotes.count
        } else {
            label.isHidden = false
            MainViewController.notes.count == 0 ? label.animateIn() : label.animateOut()
            return MainViewController.notes.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 72 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.id, for: indexPath) as? NoteCell else {
            return UITableViewCell()
        }
        if isSearching {
            cell.configure(note: searchedNotes[indexPath.row])
        } else {
            cell.configure(note: MainViewController.notes[indexPath.row])
        }
        
        cell.configureLabels()
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = .systemGray2.withAlphaComponent(0.2)
        
        return cell
    }

    // Did select any row by indexPath.Row
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteVC = NoteViewController()
        if isSearching {
            noteVC.set(noteId: searchedNotes[indexPath.row].id)
        } else {
            noteVC.set(noteId: MainViewController.notes[indexPath.row].id)
        }
        guard let cell = tableView.cellForRow(at: indexPath) as? NoteCell else {
            return
        }
        
        noteVC.set(noteCell: cell)
        navigationController?.pushViewController(noteVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        removeNote(row: indexPath.row, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if isSearching {
            return false
        }
        return true
    }
    
    internal func removeNote(row: Int, tableView: UITableView) {
        deleteNoteFromStorage(at: row)
        MainViewController.notes.remove(at: row)
        let path = IndexPath(row: row, section: 0)
        tableView.deleteRows(at: [path], with: .top)
    }
    
    internal func removeCellIfEmpty() {
        guard let firstNoteCell = MainViewController.notes.first else {
            return
        }
        if firstNoteCell.title.trimmingCharacters(in: .whitespaces).isEmpty &&
            firstNoteCell.text.trimmingCharacters(in: .whitespaces).isEmpty {
            removeNote(row: 0, tableView: tableView!)
        }
    }
}

extension MainViewController {
    
    func fetchNotesFromStorage() {
        MainViewController.notes = CoreDataManager.shared.fetchNotes()
    }
    
    private func deleteNoteFromStorage(at index: Int) {
        CoreDataManager.shared.deleteNote(MainViewController.notes[index])
    }
    
    func searchNotesFromStorage(_ text: String) {
        searchedNotes = CoreDataManager.shared.fetchNotes(filter: text)
        tableView?.reloadData()
    }
    
}
