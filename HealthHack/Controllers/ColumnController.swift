//
//  ViewController.swift
//  SearchBar
//
//  Created by sehooon on 2022/11/13.
//

import UIKit

class ColumnController: UIViewController {
    
    
    
    // MARK: - Properties
    let searchController = UISearchController()
    var tableListArr:[EncycData] = []
    var searchListArr:[String] = []
    
    @IBOutlet weak var columnSearchBar: UISearchBar!
    @IBOutlet weak var columnTable: UITableView!
    
    
    // MARK: - Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupColumnTable()
        setupSearchBar()
    }
    
    
    // MARK: - UIConfigure
    func setupSearchBar(){
        columnSearchBar.delegate = self
        columnSearchBar.autocapitalizationType = .none
    }
    
    
    func setupColumnTable(){
        columnTable.delegate = self
        columnTable.dataSource = self
        columnTable.register(UINib(nibName: "ColumnTableViewCell", bundle: nil), forCellReuseIdentifier: "ColumnTableViewCell")
        Task{
            do{
                tableListArr = try await EncycManager.shared.getData(with: "간 건강")
                
                columnTable.reloadData()
            }
        }
    }
}


// MARK: - Extension

// UISearchBarDelegate 채택
extension ColumnController: UISearchBarDelegate{
    
    
    
}


// UITableViewDelegate
extension ColumnController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let webVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
            webVC.url = tableListArr[indexPath.row].link
            present(webVC, animated: true)
        }
    }
}


// UITableViewDataSource
extension ColumnController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = columnTable.dequeueReusableCell(withIdentifier: "ColumnTableViewCell", for: indexPath) as! ColumnTableViewCell
        cell.columnTitle.text = tableListArr[indexPath.row].title.htmlEscaped
        cell.columnTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        cell.columnBody.text = tableListArr[indexPath.row].description.htmlEscaped
        return cell
    }
}


// MARK: - Html 태그 제거
extension String {
    var htmlEscaped: String {
        guard let encodedData = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributed = try NSAttributedString(data: encodedData, options: options, documentAttributes: nil)
            return attributed.string
        } catch {
            return self
        }
    }
}


