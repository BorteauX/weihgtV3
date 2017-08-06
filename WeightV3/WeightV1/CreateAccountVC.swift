//
//  CreateAccountVC.swift
//  WeightV1
//
//  Created by user on 2017/7/19.
//  Copyright © 2017年 Lee. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    var accountInfo:Dictionary<String,String> = [:]
    @IBOutlet weak var LogoImg: UIImageView!
    
    @IBOutlet weak var createNewAccountLabel: UILabel!

    @IBOutlet weak var continueBtn: UIButton!

    @IBOutlet weak var newAccountTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var checkPasswdTextField: UITextField!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var newEmailTextField: UITextField!
    
    @IBAction func emailTFActuon(_ sender: Any) {
        
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
    }
    
    
    @IBAction func continueBtn(_ sender: Any) {
// 
        if noText() == true {
            return
        }
//        if  !isPasswordValid(newPasswordTextField.text!) {
//            print("XX")
//            return
//        }
        
        if checkPasswd() == false {
            return
        }
        
        if addMember() == true {
            
            return
        }
    }
    //點旁邊收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //結束編輯 把鍵盤隱藏 view放下
        UIView.animate(withDuration: 0.4, animations: {
            self.view.frame.origin.y = 0
        })
        return true
    }
    func textFieldDidBeginEditing(_ textView:UITextField) {
        //view彈起
        UIView.animate(withDuration: 0.4, animations: {
            self.view.frame.origin.y = -230
        })
    }
    
    
       //判斷帳號密碼空白時跳出 Alert 視窗
    private func noText() -> Bool {
        
        var isNoText:Bool = true
        
        if newAccountTextField.text == "" || newPasswordTextField.text == "" {
            //建立一個 Alert 視窗
            let alertController = UIAlertController(title: "Warning", message: "Account and Password can not be empty!", preferredStyle: .alert)
            //建立一個按鈕
            let confirm = UIAlertAction(title: "ok", style: .default, handler: {(action)in
                //self.dismiss(animated: true, completion: nil)
            })
            //把按鈕加進 Alert 視窗
            alertController.addAction(confirm)
            //呈現 Alert 視窗
            present(alertController, animated: true, completion: nil)
            
            isNoText = true
            print("no, no text")
        }else {

            isNoText = false
            print("yes, text inputted")
        }
        
        return isNoText
    }
    
    //密碼重複驗證Alert
    private func checkPasswd() -> Bool {
        
        var isSame:Bool = false
        
        if newPasswordTextField.text != checkPasswdTextField.text {
            //建立一個 Alert 視窗
            let alertController = UIAlertController(title: "WARNING!", message: "Password must be the same!", preferredStyle: .alert)
            //建立一個按鈕
            let check = UIAlertAction(title: "ok", style: .default, handler: {(action)in
            })
            //把按鈕加進 Alert 視窗
        alertController.addAction(check)
            //呈現 Alert 視窗
            present(alertController, animated: true, completion: nil)
            print("pasd not the same")
            isSame = false
        }else {
            print("pswd pass")
            isSame = true
        }
        
        return isSame
    }
    //輸入字元字數限制
//    func isPasswordValid(_ password : String) -> Bool{
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
//        return passwordTest.evaluate(with: password)
//    }
//    
    
    
//    private func parseJson(json:Data){
//        do{
//            if let jsonObj = try? JSONSerialization.jsonObject(with: json, options: .allowFragments) {
//                let allObj = jsonObj as! [[String: AnyObject]]
//                print(allObj.count)
//                for r in allObj  {
//                    let account = AccountIfno()
//                    account.result = r["result"]                   as! String
//                    account.id = r["id"]                   as! String
//                    self.accountInfo.append(account)
//                }
//            }
//        }catch{
//            print(error)
//        }
//        
//    }

    // Get 傳值給後台
    private func addMember() -> Bool {
        var isAdd:Bool = true
        do{
            let account = newAccountTextField.text
            let passwd = newPasswordTextField.text
            let email = newEmailTextField.text
            
            let urlString = "http://www.brad.tw/cloudfitness/login.php?account=\(account!)&passwd=\(passwd!)"
    
            let url = URL(string: urlString)
            
            if let source = try? Data(contentsOf: url!){
                do{
                    if let jsonObj = try? JSONSerialization.jsonObject(with: source, options: .allowFragments) {
                        let allObj = jsonObj as! [[String:String]]
                        for r in allObj  {
                            var account = accountInfo
                            account = r["result"]
                        
                            
                            
                            
                            if account == ["result" : "1"] {
                            print("Add OK")
                            DispatchQueue.main.async {
                            self.addAccess()
                                }
                
                                }else {
                                    print("Add Fail")
                            }
                        }
                    }
                }catch{
                    print(error)
                }
                
                
            }

            }
        return isAdd
    }
    
    //創建成功Alert
    private func addAccess()  {
            let alertController = UIAlertController(title: "", message: "Add member access!", preferredStyle: .alert)
            //建立一個按鈕
            let check = UIAlertAction(title: "ok", style: .default, handler: {(action)in
                DispatchQueue.main.async {
                    self.goIndexPage()
                }
                
            })
            //把按鈕加進 Alert 視窗
            alertController.addAction(check)
            //呈現 Alert 視窗
            present(alertController, animated: true, completion: nil)
            print("pasd not the same")
    }
    //跳回首頁
    private func goIndexPage(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainStoryBoard")
        show(vc!, sender: self)
    }


    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //View背景顏色
        //背景漸層的兩個漸層顏色
        let color1 = UIColor(colorLiteralRed: 62/255, green: 101/255, blue: 93/255, alpha: 1)
        let color2 = UIColor(colorLiteralRed: 57/255, green: 65/255, blue: 101/255, alpha: 1)
        //產生漸層Layer
        let gradient = CAGradientLayer()
        gradient.frame = self.view.frame
        gradient.colors = [color1.cgColor , color2.cgColor]
        //把漸層Layer加入畫面中
        self.view.layer.insertSublayer(gradient, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //偵測不同裝置變換文字大小
        switch traitCollection.userInterfaceIdiom{
        case .phone:
            createNewAccountLabel.font = UIFont.systemFont(ofSize: 30)
            continueBtn.titleLabel?.font = continueBtn.titleLabel?.font.withSize(20)
            backBtn.titleLabel?.font = backBtn.titleLabel?.font.withSize(20)
        case .pad:
            createNewAccountLabel.font = UIFont.systemFont(ofSize: 48)
            continueBtn.titleLabel?.font = continueBtn.titleLabel?.font.withSize(36)
            backBtn.titleLabel?.font = backBtn.titleLabel?.font.withSize(36)
        default:break
        }
        
    //按鈕圓角陰影
    continueBtn.layer.cornerRadius = 10
    continueBtn.layer.shadowColor = UIColor.black.cgColor
    continueBtn.layer.shadowRadius = 10
    continueBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
    continueBtn.layer.shadowOpacity = 0.4
    backBtn.layer.cornerRadius = 10
    backBtn.layer.shadowColor = UIColor.black.cgColor
    backBtn.layer.shadowRadius = 10
    backBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
    backBtn.layer.shadowOpacity = 0.4
    }

}
