//
//  SignUpViewController.swift
//  InstagramSmple
//
//  Created by 藤井鈴菜 on 2019/08/04.
//  Copyright © 2019 藤井鈴菜. All rights reserved.
//

import UIKit
import NCMB

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var userIDTextField : UITextField!
    @IBOutlet var emailTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!
    @IBOutlet var confirmTextField : UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        userIDTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signUP(){
        let user = NCMBUser()
        
        if (userIDTextField.text?.count)! <= 4 {
            print("文字数が足りません")
            return
        }
        
        user.userName = userIDTextField.text!
        user.mailAddress = emailTextField.text!
        if passwordTextField.text == confirmTextField.text {
            user.password = passwordTextField.text!
        }else{
            print("パスワードの不一致")
        }
        user.signUpInBackground { (error) in
            if error != nil {
                print("error")
            }else{
                print("ログイン成功")
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
                UIApplication.shared.keyWindow?.rootViewController = rootViewController
            }
        }
    }

}
