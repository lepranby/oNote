//  SettingsViewSettings.swift
//  NotesApp
//
//  Created by Aleksej Shapran on 21.02.23.

import UIKit
import SnapKit

class ViewSettings: UIViewController {
    
    let spellingRows = ["Невялікія","Сярэднія", "Вялікія"]
    
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
        
        title = "Налады адлюстравання"
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    lazy var tableView: UITableView = {
           
        let tableView = UITableView.init()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorColor = .black.withAlphaComponent(0.2)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerLabel
        tableView.tableFooterView = footerLabel
            
        return tableView
    }()
    
    var headerLabel: UILabel = {
        
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 7))
            return label
        }()
    
    var footerLabel: UILabel = {
       
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: 60, height: 35))
        label.textAlignment = .left
        label.text = "* Памер якія адлюстроўваюцца вочак на галоўным экране."
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    // MARK: Actions
    
    func buttonClicked(sender:AnyObject) {
        print("button clicked!")
    }
}

extension ViewSettings: UITableViewDelegate, UITableViewDataSource {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spellingRows.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(spellingRows[indexPath.row])"
        cell.selectionStyle = .none
        cell.target(forAction: Selector(("buttonClicked:")), withSender: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
//                case 0:
//                case 1:
//                case 2:
                
                default:
                    print("Out of index")
                }
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

