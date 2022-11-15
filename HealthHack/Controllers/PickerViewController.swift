//
//  PickerViewController.swift
//  HealthHack
//
//  Created by sehooon on 2022/11/15.
//

import UIKit

class PickerViewController: UIViewController {

    @IBOutlet weak var mealTimer: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func alarmButtonTapped(_ sender: UIButton) {
        print("추가완료!")
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
