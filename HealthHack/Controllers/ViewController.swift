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
    
    let fatSecretClient = FatSecretClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Health Hack!")
        fatSecretClient.searchFood(name: "Hotdog") {search in
            print(search.foods[0])
        }
        
    }
    


}

