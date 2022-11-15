//
//  AlaramViewController.swift
//  HealthHack
//
//  Created by sehooon on 2022/11/15.
//

import UIKit

class AlaramViewController: UIViewController {

    @IBOutlet weak var alaramTableView: UITableView!
    
    
    var timerArray:[String] = ["아침 식사 시간", "점심 식사 시간", "저녁 식사 시간", "간식 시간"]
    var timerTime:[String] = ["08:30", "12:00", "18:00", "15:00"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTable()
    }
    
    func setupTable(){
        alaramTableView.dataSource = self
        alaramTableView.register(UINib(nibName: "AlarmTableViewCell", bundle: nil), forCellReuseIdentifier: "AlarmTableViewCell")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AlaramViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timerTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = alaramTableView.dequeueReusableCell(withIdentifier: "AlarmTableViewCell", for: indexPath) as! AlarmTableViewCell
        cell.mealTimeLabel.text = timerArray[indexPath.row]
        cell.mealTimer.text = timerTime[indexPath.row]
        return cell
    }
    
    
}

extension AlaramViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alarmVC = storyboard?.instantiateViewController(withIdentifier: "PickerVC") as! PickerViewController
        present(alarmVC, animated: true)
    }
}



