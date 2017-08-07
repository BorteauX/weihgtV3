import UIKit
import CoreBluetooth
enum SendDataError:Error {
    case CharacteristicNotFound
}

class ChoiceDeviceVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var choiceDeviceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBAction func backBtnAction(_ sender: Any) {
    }
    
    let app = UIApplication.shared.delegate as! AppDelegate
    var timer:Timer?
    var timer2:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        app.bleManage = BLEManage()
        print(app.mid)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {(timer) in
            self.tableView.reloadData()
        })
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: {(timer) in
            self.tableView.reloadData()
            self.nextView()
        })
        
        
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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //偵測不同裝置變換文字大小
        switch traitCollection.userInterfaceIdiom{
        case .phone:
            choiceDeviceLabel.font = UIFont.systemFont(ofSize: 36)
            backBtn.titleLabel?.font = backBtn.titleLabel?.font.withSize(20)
        case .pad:
            choiceDeviceLabel.font = UIFont.systemFont(ofSize: 60)
            backBtn.titleLabel?.font = backBtn.titleLabel?.font.withSize(36)
        default:break
        }
        backBtn.layer.cornerRadius = 10
        backBtn.layer.shadowColor = UIColor.black.cgColor
        backBtn.layer.shadowRadius = 10
        backBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        backBtn.layer.shadowOpacity = 0.4
    }
    
    //tableView 處理
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return app.bleManage.peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = app.bleManage.peripherals[indexPath.row].name
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        app.bleManage.connectPeripheral = app.bleManage.peripherals[indexPath.row]
        app.bleManage.connectPeripheral.delegate = app.bleManage
        app.bleManage.centralManager.connect(app.bleManage.peripherals[indexPath.row], options: nil)
        timer2 = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {(timer) in
            self.nextView()
        })
        
        
    }
    private func nextView(){
        if app.bleManage.isconnect{
            timer?.invalidate()
            timer = nil
            timer2?.invalidate()
            timer2 = nil
            if let vc = storyboard?.instantiateViewController(withIdentifier: "InsertData"){
                show(vc, sender: self)
            }
        }
    }
    

    
}
