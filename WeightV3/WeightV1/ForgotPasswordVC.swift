//
//  ForgotPasswordVC.swift
//  WeightV1
//
//  Created by user on 2017/7/19.
//  Copyright © 2017年 Lee. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var forgotPasswordLabel: UILabel!
    
    @IBOutlet weak var enterEmailLabel: UILabel!
    
    @IBOutlet weak var ContinueBtn: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBAction func ContinueBtn(_ sender: Any) {
        noText()
    }
    
    //結束編輯 按 return 收鍵盤
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //判斷帳號密碼空白時跳出 Alert 視窗
    private func noText(){
        if emailTextField.text == "" {
            //建立一個 Alert 視窗
            let alertController = UIAlertController(title: "Warning", message: "Email can not be empty!", preferredStyle: .alert)
            //建立一個按鈕
            let confirm = UIAlertAction(title: "ok", style: .default, handler: {(action)in
                //self.dismiss(animated: true, completion: nil)
            })
            //把按鈕加進 Alert 視窗
            alertController.addAction(confirm)
            //呈現 Alert 視窗
            present(alertController, animated: true, completion: nil)
            
            print("no")
        }else {
            print("ok")
        }
        
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
            forgotPasswordLabel.font = UIFont.systemFont(ofSize: 36)
            enterEmailLabel.font = UIFont.systemFont(ofSize: 20)
            ContinueBtn.titleLabel?.font = ContinueBtn.titleLabel?.font.withSize(20)
        case .pad:
            forgotPasswordLabel.font = UIFont.systemFont(ofSize: 48)
            enterEmailLabel.font = UIFont.systemFont(ofSize: 36)
            ContinueBtn.titleLabel?.font = ContinueBtn.titleLabel?.font.withSize(20)
        default:break
        }
        
        //按鈕圓角陰影
        ContinueBtn.layer.cornerRadius = 15
        ContinueBtn.layer.shadowColor = UIColor.black.cgColor
        ContinueBtn.layer.shadowRadius = 15
        ContinueBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        ContinueBtn.layer.shadowOpacity = 0.4
    }

}
