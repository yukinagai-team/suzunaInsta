//
//  SignInViewController.swift
//  InstagramSmple
//
//  Created by 藤井鈴菜 on 2019/08/07.
//  Copyright © 2019 藤井鈴菜. All rights reserved.
//

import UIKit
import NCMB

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var userIdTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        userIdTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func SignIn(){
        if (userIdTextField.text?.count)! > 0 &&
            (passwordTextField.text?.count)! > 0 {
            NCMBUser.logInWithUsername(inBackground: userIdTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error != nil {
                    print("error")
                }else{
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    let ud = UserDefaults.standard
                    ud.set(true, forKey: "IsLogIn")
                    ud.synchronize()
                }
            }
        }
    }
}
