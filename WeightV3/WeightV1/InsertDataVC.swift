//
//  InsertDataVC.swift
//  WeightV1
//
//  Created by Lee on 2017/7/16.
//  Copyright © 2017年 Lee. All rights reserved.
//

import UIKit

class InsertDataVC: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var insertDataLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var sexLabel: UILabel!
    
    @IBOutlet weak var birthYearLabel: UILabel!
    
    @IBOutlet weak var heightTextField: UITextField!

    @IBOutlet weak var nextPageBtn: UIButton!
    
    @IBOutlet weak var genderBtn: UIButton!
    @IBAction func genderBtn(_ btn: UIButton) {
        if btn.tag == 0 {
            btn.tag = 1
            let image = UIImage(named: "gender_M.png")
            genderBtn.setImage(image, for: .normal)
        } else {
            btn.tag = 0
            let image = UIImage(named: "gender_F.png")
            genderBtn.setImage(image, for: .normal)
        }
//        print(btn.tag)
    }
    
    @IBOutlet weak var birthYearPickerView: UIPickerView!
    
    @IBOutlet var birthYearPicker: [UIPickerView]!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBAction func backBtnAction(_ sender: Any) {
    }
    
    @IBAction func nextPageBtn(_ sender: Any) {
        if noText() == true {
            return
        }
        if isheightValue() == false {
            return
        }
        if app.bleManage.disconnect {
            //建立一個 Alert 視窗
            let alertController = UIAlertController(title: "!", message: "Please reconnect divice!", preferredStyle: .alert)
            //建立一個按鈕
            let confirm = UIAlertAction(title: "OK", style: .default, handler: {(action)in
            })
            //把按鈕加進 Alert 視窗
            alertController.addAction(confirm)
            //呈現 Alert 視窗
            present(alertController,animated: true,completion:  nil)
            return
        }
        app.body["gender"] = UInt8(genderBtn.tag)
//        print(app.body)
        app.body["height"] = UInt8(heightTextField.text!) //UInt8(tallLabel.text!)
        app.body["age"] = age //UInt8(birthYearLabel.text!)
        print(age!)
        app.bleManage.writeBody(body: app.body)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ResultVC"){
            show(vc, sender: self)
        }
    }

    //===============================================================================
    
    let app = UIApplication.shared.delegate as! AppDelegate
    var age : UInt8?
    var birthYear:Array<String> = []
    
    
    //picker 1990~目前年份
    //自動判斷目前年份
    func currentYear() -> Int{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let result = formatter.string(from: date)
        
        return Int(result)!
    }
    //1990~目前年份
    func showbirthYear() {
        for i in 1918...currentYear() {
            birthYear.append(String(i))
        }
    }
    //實作UIPickerView協定
    //picker有幾列可以選擇
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    //picker 每列有多少行資料
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return birthYear.count
    }
    //picker 顯示內容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        return birthYear[row]
    }
    //picker 選定後要做的動作
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        age = UInt8(currentYear() - Int(birthYear[row])!)
        print(age!)
    }
    //picker 文字樣式
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        // where data is an Array of String
        label.text = birthYear[row]
        
        return label
    }
    
    
    // 結束編輯 把鍵盤隱藏起來
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    
    //判斷身高欄位空白時跳出 Alert 視窗
    private func noText() -> Bool{
        var isnotext = true
        if heightTextField.text == "" {
            //建立一個 Alert 視窗
            let alertController = UIAlertController(title: "Warning", message: "Weight and Tall can not be empty!", preferredStyle: .alert)
            //建立一個按鈕
            let confirm = UIAlertAction(title: "OK", style: .default, handler: {(action)in
                //self.dismiss(animated: true, completion: nil)
            })
            //把按鈕加進 Alert 視窗
            alertController.addAction(confirm)
            //呈現 Alert 視窗
            present(alertController, animated: true, completion: nil)
            
            print("no")
            
        }else {
            isnotext = false
            print("ok")
        }
        return isnotext
    }
    //判斷身高欄位數值是否在範圍內
    private func isheightValue() ->Bool {
        var isheightinRange = true
        var height = Int(heightTextField.text!)!
        if height > 90 && height < 200 {
            
        }else {
            //建立一個 Alert 視窗
            let alertController = UIAlertController(title: "", message: "height values must be in 90~200cm", preferredStyle: .alert)
            //建立一個按鈕
            let confirm = UIAlertAction(title: "OK", style: .default, handler: {(action)in
            })
            //把按鈕加進 Alert 視窗
            alertController.addAction(confirm)
            //呈現 Alert 視窗
            present(alertController,animated: true,completion:  nil)
            isheightinRange = false
        }
        return isheightinRange
    }
    //點旁邊收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        showbirthYear()
        age = 99
        
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
            insertDataLabel.font = UIFont.systemFont(ofSize: 36)
            heightLabel.font = UIFont.systemFont(ofSize: 20)
            sexLabel.font = UIFont.systemFont(ofSize: 20)
            birthYearLabel.font = UIFont.systemFont(ofSize: 20)
            nextPageBtn.titleLabel?.font = nextPageBtn.titleLabel?.font.withSize(20)
            backBtn.titleLabel?.font = backBtn.titleLabel?.font.withSize(20)
        case .pad:
            insertDataLabel.font = UIFont.systemFont(ofSize: 48)
            heightLabel.font = UIFont.systemFont(ofSize: 36)
            sexLabel.font = UIFont.systemFont(ofSize: 36)
            birthYearLabel.font = UIFont.systemFont(ofSize: 36)
            nextPageBtn.titleLabel?.font = nextPageBtn.titleLabel?.font.withSize(36)
            backBtn.titleLabel?.font = backBtn.titleLabel?.font.withSize(36)
        default:break
        }
        
    //按鈕圓角陰影
    nextPageBtn.layer.cornerRadius = 10
    nextPageBtn.layer.shadowColor = UIColor.black.cgColor
    nextPageBtn.layer.shadowRadius = 10
    nextPageBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
    nextPageBtn.layer.shadowOpacity = 0.4
    backBtn.layer.cornerRadius = 10
    backBtn.layer.shadowColor = UIColor.black.cgColor
    backBtn.layer.shadowRadius = 10
    backBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
    backBtn.layer.shadowOpacity = 0.4

    }




}
