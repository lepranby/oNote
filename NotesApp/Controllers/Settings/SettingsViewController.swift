//  SettingsViewController.swift
//  NotesApp
//
//  Created by Aleksej Shapran on 17.02.23.
//  Modifyed by Aleksej Shapran on 19-22.02.23.

import UIKit
import SnapKit

class SettingsViewController: UIViewController {

    let settingsData = ["Мова інтэрфейсу","Налады адлюстравання","Сінхранізацыя з iCloud"]
    
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
        
        title = "Налады"
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
        
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 8))
            return label
        }()
    
    // MARK: Actions
    
    @objc private func pushingToLanguage() {
        
        let pushToLanguage = SettingsLanguage()
        navigationController?.pushViewController(pushToLanguage, animated: true)
    }
    
    func buttonClicked(sender:AnyObject) {
        print("button clicked!")
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsData.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(settingsData[indexPath.row])"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let language = SettingsLanguage()
        let viewSettings = ViewSettings()
        
        switch indexPath.row {
                case 0:
                    navigationController?.pushViewController(language, animated: true)
                case 1:
                    navigationController?.pushViewController(viewSettings, animated: true)
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
