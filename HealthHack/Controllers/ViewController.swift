//
//  ViewController.swift
//  HealthHack
//
//  Created by kimminho on 2022/11/08.
//

import UIKit
import FSCalendar
import FatSecretSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    let fatSecretClient = FatSecretClient()
    
    let tableViewData = [
        ["1","2","3","4","5"],
        ["1","2","3","4","5"],
        ["1","2","3","4","5"],
        ["1","2","3","4","5"],
    ]
    let mealTitle = ["아침","점심","저녁","간식/기타"]
    
    var hiddenSections = Set<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        // Do any additional setup after loading the view.
        print("Health Hack!")
        fatSecretClient.searchFood(name: "Hotdog") {search in
            print(search.foods[0])
        }
        myTableView.register(UINib(nibName: "CustomHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeaderView")
        
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.tableViewData[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 섹션이 hidden이므로 행을 노출시키지 않는다.
        if self.hiddenSections.contains(section) {
            return 0
        }
        
        // 가진 데이터의 개수만큼 노출시킨다.
        return self.tableViewData[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // UIButton 생성
//        let sectionButton = UIButton()
//
//        // section 제목
//        sectionButton.setTitle(mealTitle[section],
//                               for: .normal)
//
//        // section 배경 색
//        sectionButton.backgroundColor = .systemBlue
//
//        // tag로 섹션을 구분할 것이다.
//        sectionButton.tag = section
//
//        // section을 터치했을 때 실행할 메서드 설정(밑에서 구현한다.)
//        sectionButton.addTarget(self,
//                                action: #selector(self.hideSection(sender:)),
//                                for: .touchUpInside)

//        return sectionButton
        
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderView") as! HeaderView
        headerView.sibalLabel.setTitle(mealTitle[section], for: .normal)
        headerView.sibalLabel.addTarget(self,
                                        action: #selector(self.hideSection(sender:)),
                                        for: .touchUpInside)
        return headerView
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
            self.myTableView.insertRows(at: indexPathsForSection(),
                                      with: .fade)
            self.myTableView.scrollToRow(at: IndexPath(row: self.tableViewData[section].count - 1,
                                section: section), at: UITableView.ScrollPosition.bottom, animated: true)
        } else {
            // section이 원래 노출되어 있었다면 행들을 감춘다.
            self.hiddenSections.insert(section)
            self.myTableView.deleteRows(at: indexPathsForSection(),
                                      with: .fade)
        }
    }
    
}


