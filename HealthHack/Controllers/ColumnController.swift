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
    
}


// UITableViewDataSource
extension ColumnController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = columnTable.dequeueReusableCell(withIdentifier: "ColumnTableViewCell", for: indexPath) as! ColumnTableViewCell
        cell.columnTitle.attributedText = tableListArr[indexPath.row].title.htmlToAttributedString(font: .systemFont(ofSize: 20))
        cell.columnDate.attributedText = tableListArr[indexPath.row].description.htmlToAttributedString(font: .systemFont(ofSize: 20))
        if let url = URL(string: tableListArr[indexPath.row].thumbnail){
            print(tableListArr[indexPath.row].thumbnail)
            cell.columnImageView.load(url: url)
        } else{
            cell.columnImageView.image = UIImage(systemName: "plus")
        }
        return cell
    }
}

extension String {
  func htmlToAttributedString(font: UIFont) -> NSAttributedString? {
      let newHTML = String(format:"<body style=\"font-family: '-apple-system', '\(font.fontName)';\">%@</body>", self)
        
    guard let data = newHTML.data(using: .utf8) else {
      return NSAttributedString()
    }
    
    do {
      return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
    } catch {
      return NSAttributedString()
    }
  }
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
