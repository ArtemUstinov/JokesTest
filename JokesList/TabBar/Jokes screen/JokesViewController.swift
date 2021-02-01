//
//  JokesViewController.swift
//  JokesList
//
//  Created by Артём Устинов on 24.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class JokesViewController: UIViewController, KeyboardProtocol {
    
    //MARK: - Properties:
    private let networkManager = NetworkManager()
    lazy private var errorAlertController = ErrorAlertController()
    
    private var jokesData: [Joke]? {
        didSet { parseData(count: jokesData?.count) }
    }
    
    //MARK: - UI elements:
    private let scrollView = UIScrollView()
    private let mainView = UIView()
    private let tableView = UITableView()
    private var textField = UITextField(placeholder: "Input..",
                                        cornerRadius: 12)
    private let loadButton = UIButton(text: "Reset",
                                      cornerRadius: 12)
    private let bottomLineView = UIView(color: .lightGray)
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupKeyboardHandler()
        
        setupTableView()
        setupLayouts()
        setTargets()
        setupGesture()
        setupToolBar()
    }
    
    //MARK: - GetData and ParseData:
    private func getJokesData() {
        networkManager.fetchData(countText: textField.text ?? "") {
            [weak self] result in
            switch result {
            case .success(let data):
                self?.jokesData = data
            case .failure(let error):
                self?.errorAlertController.show(with: error) {
                    [weak self] alert in
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    private func parseData(count: Int?) {
        if count ?? 0 > 0 {
            tableView.isHidden = false
            tableView.reloadData()
            
            if tableView.contentSize.height > tableView.frame.height {
                bottomLineView.isHidden = false
            } else {
                bottomLineView.isHidden = true
            }
        } else {
            tableView.isHidden = true
            bottomLineView.isHidden = true
        }
    }
    
    //MARK: Setup UI targets:
    private func setTargets() {
        loadButton.addTarget(self,
                             action: #selector(loadButtonHandle),
                             for: .touchUpInside)
    }
    
    @objc private func loadButtonHandle() {
        tableView.isHidden = true
        bottomLineView.isHidden = true
        textField.text = ""
        jokesData = nil
        tableView.reloadData()
    }
    
    //MARK: - SetupGesture:
    private func setupGesture() {
        mainView.addGestureRecognizer(
            UITapGestureRecognizer(target: self,
                                   action: #selector(handleTapGesture))
        )
    }
    @objc private func handleTapGesture() {
        view.endEditing(true)
    }
    
    //MARK: - Setup ToolBar:
    private func setupToolBar() {
        
        let toolbar = UIToolbar(
            frame: CGRect.init(x: 0,
                               y: 0,
                               width: UIScreen.main.bounds.width,
                               height: 50)
        )
        toolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneButtonTapped))
        
        toolbar.setItems([flexSpace, doneButton],
                         animated: true)
        toolbar.sizeToFit()
        toolbar.backgroundColor = .lightGray
        textField.inputAccessoryView = toolbar
    }
    
    @objc private func doneButtonTapped() {
        getJokesData()
        textField.resignFirstResponder()
    }
    
    //MARK: - Setup TableView:
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(JokeCell.self)
        tableView.tableFooterView = UIView()
        tableView.isHidden = true
        bottomLineView.isHidden = true
    }
    
    //MARK: - Setup layouts:
    private func setupLayouts() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainView)
        mainView.addSubview(tableView)
        mainView.addSubview(textField)
        mainView.addSubview(loadButton)
        mainView.addSubview(bottomLineView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            scrollView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            scrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            scrollView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
        ])
        
        //        // H and V: scrollView line
        //        view.addConstraintsWithFormat(format: "H:|[v0]|",
        //                                      views: [scrollView])
        //        view.addConstraintsWithFormat(format: "V:|[v0]|",
        //                                      views: [scrollView])
        
        // H and V: mainView line
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|",
                                            views: [mainView])
        scrollView.addConstraintsWithFormat(format: "V:|[v0]|",
                                            views: [mainView])
        
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor,
                                              constant: 0),
            mainView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor,
                                              constant: 0)
        ])
        
        // H: tableView line
        mainView.addConstraintsWithFormat(format: "H:|[v0]|",
                                          views: [tableView])
        
        // V: tableView line
        mainView.addConstraintsWithFormat(
            format: "V:|[v0(430)]-1-[v1(1)]-40-[v2(25)]-15-[v3(25)]",
            views: [tableView, bottomLineView, textField, loadButton]
        )
        
        // H: bottomLineView line
        mainView.addConstraintsWithFormat(format: "H:|[v0]|",
                                          views: [bottomLineView])
        
        // H: textField line and loadButton line
        mainView.addConstraintsWithFormat(format: "H:|-150-[v0]-150-|",
                                          views: [textField])
        mainView.addConstraintsWithFormat(format: "H:|-140-[v0]-140-|",
                                          views: [loadButton])
        
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension JokesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        jokesData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: JokeCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: jokesData?[indexPath.row])
        return cell
    }
}

