//
//  ArticlesListViewController.swift
//  NYT-JAC-FA-DA
//
//  Created by F_Sur on 17/03/2022.
//

import UIKit

class ArticlesListViewController: UIViewController {
    
    var requestedArticle: String = ""
    lazy var articlesSearchingLists = [SearchingArticleDetails]()
    lazy var articlesPopulareList = [PopulareArticleDetails]()
    
    /// It show arisen from Search or populare View (can extedn in future), 0: for search section, 1: for populare section
    var articlesListViewSection: ArticlesListViewSection!
    
    // View Variables
    var tableView: UITableView!
    let ID_Cell_Home = "ID_Cell_Home"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.backgroundColor = .white
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        configNav()
        configTableView()
        layoutView()
        CallAPI()
    }
}

// MARK: - Confige View

// Navigation Bar
extension ArticlesListViewController {
    func configNav() {
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.2039215686, blue: 0.2039215686, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        
        title = "Articles"
        let textAttribute = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font:  UIFont.boldSystemFont(ofSize: 22)] as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.titleTextAttributes = textAttribute
        
        let backBtn = UIBarButtonItem(image: .init(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backBtnTapped))
        navigationItem.leftBarButtonItem = backBtn
    }
}

// TableView
extension ArticlesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch articlesListViewSection {
        case .searchSection:
            return articlesSearchingLists.count
        case .populareSection:
            return articlesPopulareList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: ID_Cell_Home, for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: ID_Cell_Home)
        
        switch articlesListViewSection {
        case .searchSection:
            let articleDetails = articlesSearchingLists[indexPath.row]
            cell.textLabel?.text = articleDetails.title?.titleName
            if let publichYear = articleDetails.year {
            cell.detailTextLabel?.text = generateShortDateFortmat(date: publichYear)
            }
            return cell
        case .populareSection:
            let articleDetails = articlesPopulareList[indexPath.row]
            cell.textLabel?.text = articleDetails.title
            cell.detailTextLabel?.text = articleDetails.year
            return cell
        default:
            return UITableViewCell()
        }

    }
    
    // MARK: Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch articlesListViewSection {
        case .searchSection:
            presentAlert(title: "Article Details", message: (articlesSearchingLists[indexPath.row].title?.titleName)! + "\n" + generateShortDateFortmat(date: (articlesSearchingLists[indexPath.row].year!)) , options: "Ok") { _ in
            }
        case .populareSection:
            presentAlert(title: "Article Details", message: (articlesPopulareList[indexPath.row].title)! + "\n" + articlesPopulareList[indexPath.row].year! , options: "Ok") { _ in
            }
        case .none:
            return
        }
    }
    func configTableView() {
        tableView = UITableView()
        tableView.indicatorStyle = .black
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ID_Cell_Home)
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
        
    // Layout View
    func layoutView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}

// MARK: - Calling API

extension ArticlesListViewController {
    func CallAPI() {
        switch articlesListViewSection {
        // call search API
        case .searchSection:
            
            showSpinner()
            
            APIManager.shareManager.getDesiredArticleData(desredArticle: requestedArticle, completion: { [weak self] result in
                
                guard let strongSelf = self else { return }
                switch result {
                case .success(let listOf):
                    
                    DispatchQueue.main.async {
                        strongSelf.removeSpinner()
                        strongSelf.articlesSearchingLists = listOf.result!.articles
                        if !strongSelf.articlesSearchingLists.isEmpty {
                        strongSelf.tableView.reloadData()
                        print("dd")
                        } else {
                            strongSelf.presentAlert(title: "Alert", message: "There is not articles.", options: "Ok") { _ in
                                
                            }
                        }
                    }
               
                case .failure(let error):
                    DispatchQueue.main.async {
                        strongSelf.removeSpinner()
                        strongSelf.presentAlert(title: "Alert", message: "It coulnd't load articles, please check you network.", options: "Ok") { _ in
                        }
                        print("Error processing json data: \(error)")

                    }
                  
                }
            })
            
        // call populare API
        case .populareSection:
            
        showSpinner()
            
        APIManager.shareManager.getPopularArticleData(desiredPopulareArctcile: requestedArticle, completion: { [weak self] result in
            
            guard let strongSelf = self else { return }
            switch result {
            case .success(let listOf):
                
                DispatchQueue.main.async {
                    strongSelf.removeSpinner()
                    strongSelf.articlesPopulareList = listOf.results
                    if !strongSelf.articlesPopulareList.isEmpty {
                    strongSelf.tableView.reloadData()
                    print("dd")
                    } else {
                        strongSelf.presentAlert(title: "Alert", message: "There is not articles.", options: "Ok") { _ in
                            
                        }
                    }
                }
           
            case .failure(let error):
                DispatchQueue.main.async {
                    strongSelf.removeSpinner()
                    strongSelf.presentAlert(title: "Alert", message: "It coulnd't load articles, please check you network.", options: "Ok") { _ in
                    }
                    print("Error processing json data: \(error)")
                }
              
            }
        })
        
        case .none:
            return
        }
        
    }
}

// MARK: - Helper Functions

extension ArticlesListViewController {
    // Back Btn Navigation
    @objc func backBtnTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
