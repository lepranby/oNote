//  SettingsLanguage.swift
//  NotesApp
//
//  Created by Aleksej Shapran on 21.02.23.

import UIKit
import SnapKit

class SettingsLanguage: UIViewController {
    
    let languageData = ["English language","Беларуская мова ","Українська мова","Deutsche sprache","język Polski"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.largeTitleDisplayMode = .never
        
        setupNavigationBarItem()
        configureViews()
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setupNavigationBarItem() {
        
        title = "Мова інтэрфейсу"
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    lazy var tableView: UITableView = {
           
        let tableView = UITableView.init()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorColor = .black.withAlphaComponent(0.2)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerLabel
            
        return tableView
    }()
    
    var headerLabel: UILabel = {
        
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 7))
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 22)
            return label
        }()
    
    // MARK: Actions
    
    func buttonClicked(sender:AnyObject) {
        print("button clicked!")
    }
}

extension SettingsLanguage: UITableViewDelegate, UITableViewDataSource {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageData.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(languageData[indexPath.row])"
        cell.selectionStyle = .none
        cell.target(forAction: Selector(("buttonClicked:")), withSender: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtindexPath indexPath: IndexPath) {
        print(indexPath.row)
    }
        
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
        
    // MARK: Configuration
        
    func configureViews () {
        view.addSubview(tableView)
    }
        
    func configureConstraints () {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
