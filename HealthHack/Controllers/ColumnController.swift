//
//  ViewController.swift
//  SearchBar
//
//  Created by sehooon on 2022/11/13.
//

import UIKit

class ColumnController: UIViewController {

    
    
    let searchController = UISearchController()
    let tableListArr:[String] = ["간 건강", "피로회복", "피부개선"]
    var searchListArr:[String] = []
    
    @IBOutlet weak var columnSearchBar: UISearchBar!
    @IBOutlet weak var columnTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupColumnTable()
        setupSearchBar()
        
    }

    
    // MARK: - UISearchbarSetup
    func setupSearchBar(){
        columnSearchBar.delegate = self
        columnSearchBar.autocapitalizationType = .none
    }
    
    
    func setupColumnTable(){
        columnTable.delegate = self
        columnTable.dataSource = self
        columnTable.register(UINib(nibName: "ColumnTableViewCell", bundle: nil), forCellReuseIdentifier: "ColumnTableViewCell")
    }
}


// MARK: - UISearchBarDelegate 채택
extension ColumnController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchListArr = []
        for idx in 0..<tableListArr.count{
            if tableListArr[idx].contains(searchText){
                searchListArr.append(tableListArr[idx])
            }
            columnTable.reloadData()
        }
        
    }
    
    
}


// MARK: - UITableViewDelegate
extension ColumnController: UITableViewDelegate{

}



// MARK: - UITableViewDataSource
extension ColumnController: UITableViewDataSource{
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchListArr.isEmpty ? tableListArr.count:  searchListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = columnTable.dequeueReusableCell(withIdentifier: "ColumnTableViewCell", for: indexPath) as! ColumnTableViewCell
        if searchListArr.isEmpty{
            cell.columnTitle.text = tableListArr[indexPath.row]
            cell.columnDate.text = tableListArr[indexPath.row]
            cell.columnImageView.image = UIImage(systemName: "sun.fill")
        } else{
            cell.columnTitle.text = searchListArr[indexPath.row]
            cell.columnDate.text = searchListArr[indexPath.row]
            cell.columnImageView.image = UIImage(systemName: "sun.fill")
        }
        
        return cell
    }
}

