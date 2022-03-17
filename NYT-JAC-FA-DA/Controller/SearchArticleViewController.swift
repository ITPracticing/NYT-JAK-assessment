//
//  SearchArticleViewController.swift
//  NYT-JAC-FA-DA
//
//  Created by F_Sur on 17/03/2022.
//

import UIKit
import iOSDropDown

class SearchArticleViewController: UIViewController {
    
    // Variables
    var requestedArticle: String?
    
    // View Variables
    lazy var searchBar: DropDown = {
        var searchBar = DropDown()
        searchBar.arrowSize = 14
        searchBar = DropDown(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        searchBar.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 200, height: 200))
        searchBar.textAlignment = .center
        searchBar.backgroundColor = .systemBackground
        searchBar.selectedRowColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        searchBar.optionArray = ArticleData.SearchingArticelNamesArray
        searchBar.cornerRadius = 2
        searchBar.placeholder = "Search articles here ..."
        searchBar.layer.borderWidth = 1
        searchBar.textColor = .black
        searchBar.layer.cornerRadius = 5
        searchBar.layer.borderColor = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1).cgColor
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    lazy var searchBtn: UIButton = {
        let btn = UIButton()
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 5
        btn.backgroundColor = .gray
        btn.isHidden = false
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.white.cgColor
        btn.setTitle("Search", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 20, bottom: 5, right: 20)//        btn.titleLabel!.font =  UIFont(name: "Helvetica", size: 20)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
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
        configeLayoutView()
        configView()
        
    }
}


// MARK: - Configation View

// Navigation Bar
extension SearchArticleViewController {
    func configNav() {
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.2039215686, blue: 0.2039215686, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        
        let textAttribute = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font:  UIFont.boldSystemFont(ofSize: 22)] as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.titleTextAttributes = textAttribute
        
        title = "Search"
        
        let backBtn = UIBarButtonItem(image: .init(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backBtnTapped))
        navigationItem.leftBarButtonItem = backBtn
    }
    
    func configeLayoutView() {
        view.addSubview(searchBar)
        view.addSubview(searchBtn)
        NSLayoutConstraint.activate([
            
            // Search bar
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchBar.bottomAnchor.constraint(equalTo: searchBtn.topAnchor, constant: -20),
            
            // Search btn
            searchBtn.heightAnchor.constraint(equalToConstant: 40),
            
            searchBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    func configView() {
        searchBtn.addTarget(self, action: #selector(searchBtnTapped(_:)), for: .touchUpInside)
    }
    
}




// MARK: - Helper Functions

extension SearchArticleViewController {
    // Back Btn Navigation
    @objc func backBtnTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    // Search Btn Tapped
    @objc func searchBtnTapped(_ sender: UIButton) {
        sender.btnBlink()
        requestedArticle = searchBar.text ?? ""
        if requestedArticle == "" {
            presentAlert(title: "Warning", message: "Please, write or select an article.", options: "Ok") { _ in
            }
        } else if !ArticleData.SearchingArticelNamesArray.contains(requestedArticle!) {
            presentAlert(title: "Warning", message: "This article is not available!", options: "Ok") { _ in
            }
        } else {
            // call api for searching article and move to Article list VC
            let vc = ArticlesListViewController()
            vc.articlesListViewSection = .searchSection
            vc.requestedArticle = requestedArticle!
            let rootVC = UINavigationController(rootViewController: vc)
            rootVC.modalPresentationStyle = .fullScreen
            present(rootVC, animated: true, completion: nil)
        }
    }
}


