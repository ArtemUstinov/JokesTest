//
//  JokesViewController.swift
//  JokesList
//
//  Created by Артём Устинов on 24.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class JokesViewController: UIViewController {
    
    //MARK: - Private properties:
    private let tableView = UITableView()
    private let textField = UITextField(placeholder: "Unput count")
    
    private let loadButton = UIButton(text: "Load", cornerRadius: 10)
    let lineView = UIView(color: .red)
    
    private let networkManager = NetworkManager()
    
    var jokes: [Joke]?
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupTableView()
        setupLayouts()
        
        
        networkManager.fetchData(countText: "20") { data in
            self.jokes = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Private methods:
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell") // ! сделать красивое расширение!
    }
    
    private func setupLayouts() {
        view.addSubview(tableView)
        view.addSubview(textField)
        view.addSubview(loadButton)
        view.addSubview(lineView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: [tableView])
        view.addConstraintsWithFormat(format: "V:|[v0(415)]-1-[v1(1)]-50-[v2]-15-[v3(20)]", views: [tableView, lineView, textField, loadButton])
        
        view.addConstraintsWithFormat(format: "H:|-140-[v0]-140-|", views: [textField])
        view.addConstraintsWithFormat(format: "H:|-140-[v0]-140-|", views: [loadButton])
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: [lineView])
        
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension JokesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        jokes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath
        )
        cell.textLabel?.text = jokes?[indexPath.row].joke
        return cell
    }
}

