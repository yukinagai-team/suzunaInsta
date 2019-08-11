//
//  UserMenuViewController.swift
//  InstagramSmple
//
//  Created by 藤井鈴菜 on 2019/08/08.
//  Copyright © 2019 藤井鈴菜. All rights reserved.
//

import UIKit
import NCMB

class UserMenuViewController: UIViewController {
    
    @IBOutlet var userImageView : UIImageView!
    @IBOutlet var userDisplayNameLabel : UILabel!
    @IBOutlet var userIntroductionTextView : UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2.0
        userImageView.layer.masksToBounds = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //長い間ログインしないでいるとクラッシュしてしまう問題を解決する
        
        if let user = NCMBUser.current(){
            let user = NCMBUser.current()
            userDisplayNameLabel.text = user?.object(forKey: "displayName") as? String
            userIntroductionTextView.text = user?.object(forKey: "introduction") as? String
            self.navigationController?.navigationItem.title = user?.userName
            
            let file = NCMBFile.file(withName: NCMBUser.current()?.objectId, data: nil) as! NCMBFile
            file.getDataInBackground { (data, error) in
                if error != nil {
                    print("error")
                } else {
                    if data != nil {
                        let image = UIImage(data: data!)
                        self.userImageView.image = image
                    }
                }
            }
        } else {
            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
            UIApplication.shared.keyWindow?.rootViewController = rootViewController
            
            let ud = UserDefaults.standard
            ud.set(true, forKey: "isLogIn")
            ud.synchronize()
        }
        
        
    }
    

    @IBAction func ShowMenu(){
        let alertController = UIAlertController(title: "メニュー", message: "メニューを選択してください。", preferredStyle: .actionSheet)
        let signOutAction = UIAlertAction(title: "ログアウト", style: .default) { (action) in
            NCMBUser.logOutInBackground({ (error) in
                if error != nil {
                    print("error")
                }else{
                    let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    let ud = UserDefaults.standard
                    ud.set(true, forKey: "isLogIn")
                    ud.synchronize()
                }
            })
        }
        
        let deleteAction = UIAlertAction(title: "退会", style: .default) { (action) in
            let user = NCMBUser.current()
            user?.deleteInBackground({ (error) in
                if error != nil {
                    print("error")
                } else {
                    let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    let ud = UserDefaults.standard
                    ud.set(true, forKey: "isLogIn")
                    ud.synchronize()
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(signOutAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    

}


//まだプロフィール編集の関連付け終わっていません
