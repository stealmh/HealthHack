//
//  RegisterViewController.swift
//  HealthHack
//
//  Created by kimminho on 2022/12/26.
//

import UIKit

class RegisterViewController: UIViewController {


    private var registerModel = RegisterModel()
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerButtonTapped(_ sender: UIButton) {
        Task {
            await registerModel.registerUser(userID: emailTextField.text!, userPW: passwordTextField.text!)
        }

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
