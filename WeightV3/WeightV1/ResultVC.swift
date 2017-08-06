//
//  ResultVC.swift
//  WeightV1
//
//  Created by Lee on 2017/7/16.
//  Copyright © 2017年 Lee. All rights reserved.
//

import UIKit

class ResultVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    let app = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var bodyDataLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var tallLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var editLabel: UIButton!
    @IBOutlet weak var uploadLabel: UIButton!
    @IBOutlet weak var logOutLabel: UIButton!
    @IBAction func editBtn(_ sender: Any) {
    }
    
    @IBAction func uploadBtn(_ sender: Any) {
    }
    
    @IBOutlet weak var logOutBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        //顯示預設體重
        weightLabel.text = "0.0 kg"
        
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
        
        
        //顯示資料
        tallLabel.text = "\(app.body["height"]!) cm"
        ageLabel.text = "Age:\(app.body["age"]!)"
        if app.body["gender"] == 0 {
            sexLabel.text = "Female"
        }else{
            sexLabel.text = "Male"
        }
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(timer) in
        
            if self.app.bleManage.isFinish {
                self.weightLabel.text = "\(self.app.bleManage.weight) kg"
                self.tableView.reloadData()
                //timer.invalidate()
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        //偵測不同裝置變換文字大小
        switch traitCollection.userInterfaceIdiom{
        case .phone:
            bodyDataLabel.font = UIFont.systemFont(ofSize: 36)
            weightLabel.font = UIFont.systemFont(ofSize: 20)
            tallLabel.font = UIFont.systemFont(ofSize: 20)
            ageLabel.font = UIFont.systemFont(ofSize: 20)
            sexLabel.font = UIFont.systemFont(ofSize: 20)
            editLabel.titleLabel?.font = editLabel.titleLabel?.font.withSize(20)
            uploadLabel.titleLabel?.font = uploadLabel.titleLabel?.font.withSize(20)
            logOutLabel.titleLabel?.font = logOutLabel.titleLabel?.font.withSize(20)
        case .pad:
            bodyDataLabel.font = UIFont.systemFont(ofSize: 48)
            weightLabel.font = UIFont.systemFont(ofSize: 40)
            tallLabel.font = UIFont.systemFont(ofSize: 40)
            ageLabel.font = UIFont.systemFont(ofSize: 40)
            sexLabel.font = UIFont.systemFont(ofSize: 40)
            editLabel.titleLabel?.font = editLabel.titleLabel?.font.withSize(36)
            uploadLabel.titleLabel?.font = uploadLabel.titleLabel?.font.withSize(36)
            logOutLabel.titleLabel?.font = logOutLabel.titleLabel?.font.withSize(36)
        default:break
        }
        
    //按鈕圓角陰影
    uploadLabel.layer.cornerRadius = 10
    uploadLabel.layer.shadowColor = UIColor.black.cgColor
    uploadLabel.layer.shadowRadius = 10
    uploadLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
    uploadLabel.layer.shadowOpacity = 0.4
    
    logOutLabel.layer.cornerRadius = 10
    logOutLabel.layer.shadowColor = UIColor.black.cgColor
    logOutLabel.layer.shadowRadius = 10
    logOutLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
    logOutLabel.layer.shadowOpacity = 0.4
    
    editLabel.layer.cornerRadius = 10
    editLabel.layer.shadowColor = UIColor.black.cgColor
    editLabel.layer.shadowRadius = 10
    editLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
    editLabel.layer.shadowOpacity = 0.4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return app.bleManage.arrName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let str = "\(app.bleManage.arrName[indexPath.row]): \(app.bleManage.arrValue[indexPath.row])"
        cell?.textLabel?.text = str
        return cell!
    }

}
