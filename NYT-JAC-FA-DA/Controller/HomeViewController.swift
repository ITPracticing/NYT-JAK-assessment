//
//  ViewController.swift
//  NYT-JAC-FA-DA
//
//  Created by F_Sur on 17/03/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    // View Variables
    var tableView: UITableView!
    let ID_Cell_Home = "ID_Cell_Home"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        configTableView()
        layoutView()
    }
}

// MARK: - Confige View

// Navigation Bar
extension HomeViewController {
    func configNav() {
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.2039215686, blue: 0.2039215686, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        
        title = "NYT"
        let textAttribute = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font:  UIFont.boldSystemFont(ofSize: 22)] as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.titleTextAttributes = textAttribute
    }
}

// TableView
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return  1
        case 1:
            return MostPopulareArticleTypeModel.populaterTiltesArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID_Cell_Home, for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "Search Articles"
            return cell
            
        case 1:
            cell.textLabel?.text = MostPopulareArticleTypeModel.populaterTiltesArray[indexPath.row]
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            
            let VC = SearchArticleViewController()
            let rootVC = UINavigationController.init(rootViewController: VC)
            rootVC.modalPresentationStyle = .fullScreen
            present(rootVC, animated: true, completion: nil)
            
        case 1:
            let vc = ArticlesListViewController()
            vc.articlesListViewSection = .populareSection
            vc.requestedArticle = MostPopulareArticleTypeModel.allCases[indexPath.row].description
            let rootVC = UINavigationController(rootViewController: vc)
            rootVC.modalPresentationStyle = .fullScreen
            present(rootVC, animated: true, completion: nil)
        default:
            return
        }
        
    }
    
    // MARK: Header
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .white
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        
        switch section {
        case 0:
            label.text = " Search"
            headerView.addSubview(label)
            return headerView
        case 1:
            label.text = " Populare"
            headerView.addSubview(label)
            return headerView
        default:
            return nil
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


