//  NoteCell.swift
//  NotesApp
//
//  Created by Aleksej Shapran on 16/02/23.

import UIKit

class NoteCell: UITableViewCell {
    
    static let id = "NoteCell"
    private var note: Note?
    var dateLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemGray6.withAlphaComponent(0.5)
        
        // If note is creating now...
        
        textLabel?.font = .systemFont(ofSize: 24, weight: .regular)
        detailTextLabel?.font = .systemFont(ofSize: 20, weight: .light)
        
        setupDateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    

    
    private func setupDateLabel() {
        
        dateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        dateLabel.textAlignment = .right
        accessoryView = dateLabel
        dateLabel.font = .systemFont(ofSize: 16, weight: .light)
    }
    
    func configureLabels() {
        
        self.textLabel?.text = note?.title ?? ""
        self.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        self.detailTextLabel?.text = note?.text ?? ""
        self.detailTextLabel?.font = .systemFont(ofSize: 17, weight: .light)
        self.detailTextLabel?.numberOfLines = 3
        
        guard let note = note else {
            print("Found nil value in variable note")
            return
        }
        let formatter = DateFormatter()
        if Date.isToday(day: note.date.get(.day)) {
            formatter.dateFormat = "HH:mm"
        } else if Date.isThisYear(year: note.date.get(.year)) {
            formatter.dateFormat = "dd.MM"
        } else {
            formatter.dateFormat = "MM/dd/yyyy"
        }
        
        dateLabel.text = formatter.string(from: note.date)
    }
    
    func configure(note: Note) {
        self.note = note
    }
    
    func prepareNote() {
        self.note = nil
    }
}

