//
//  ViewController.swift
//  HealthHack
//
//  Created by kimminho on 2022/11/08.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeaderView")
    }
    
    let tableViewData = [["1","2","3","4","5"],["1","2","3","4","5"],["1","2","3","4","5"]]
    
    var hiddenSections = Set<Int>()
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            guard let header = view as? UITableViewHeaderFooterView else { return }
            
            let view: UIView = {
                let v = UIView(frame: .zero)
                v.backgroundColor = .brown
                
                return v
            }()
            
            header.textLabel?.textAlignment = .center
            header.textLabel?.textColor = .systemBlue
            header.backgroundView = view
            
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            return 0
        }
        
        return self.tableViewData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.tableViewData[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionButton = UIButton()
        
        sectionButton.setTitle(String(section), for: .normal)
        
        sectionButton.backgroundColor = .systemGreen
        
        sectionButton.tag = section
        
        sectionButton.addTarget(self, action: #selector(self.hideSection(sender:)), for: .touchUpInside)
        
        return sectionButton
    }
    
    @objc
    private func hideSection(sender: UIButton) {
        // section의 tag 정보를 가져와서 어느 섹션인지 구분한다.
        let section = sender.tag
        
        // 특정 섹션에 속한 행들의 IndexPath들을 리턴하는 메서드
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            for row in 0..<self.tableViewData[section].count {
                indexPaths.append(IndexPath(row: row,
                                            section: section))
            }
            
            return indexPaths
        }
        
        // 가져온 section이 원래 감춰져 있었다면
        if self.hiddenSections.contains(section) {
            // section을 다시 노출시킨다.
            self.hiddenSections.remove(section)
            self.tableView.insertRows(at: indexPathsForSection(), with: .fade)
        } else {
            // section이 원래 노출되어 있었다면 행들을 감춘다.
            self.hiddenSections.insert(section)
            self.tableView.deleteRows(at: indexPathsForSection(), with: .fade)
        }
        
    }
}


