import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var firstTextBox: UITextField!
    @IBOutlet weak var secondTextBox: UITextField!
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    func celsiusToFahrenheit(value: Double) -> Double {
        ((value * (9/5) + 32) * 1000).rounded() / 1000
    }
    
    enum convertMode {
        case temperature
        case distance
    }
    
    @IBAction func celcDidChange(_ sender: UITextField) {
        if var celc = Double(sender.text ?? "") {
            if celc <= -80  {
                sender.text = "-80"
                celc = -80
                secondTextBox.text = String(((celc * (9/5) + 32) * 1000).rounded() / 1000)
                return
            }
            else if celc >= 50 {
                sender.text = "50"
                celc = 50
                secondTextBox.text = String(((celc * (9/5) + 32) * 1000).rounded() / 1000)
                return
            }
            secondTextBox.text = String(((celc * (9/5) + 32) * 1000).rounded() / 1000)
        }
        else {
            secondTextBox.text = ""
        }
    }
    
    @IBAction func farengDidChanged(_ sender: UITextField) {
        if var celc = Double(sender.text ?? "") {
            if celc <= -112{
                sender.text = "-112"
                celc = -112
                firstTextBox.text = String((((celc - 32) * (5/9)) * 1000).rounded()/1000)
                return
            }
            else if celc >= 122 {
                sender.text = "122"
                celc = 122
                firstTextBox.text = String((celc - 32) * (5/9))
                return
            }
            firstTextBox.text = String((((celc - 32) * (5/9)) * 1000).rounded()/1000)
        }
        else {
            firstTextBox.text = ""
        }
        if let celc = Double(sender.text ?? "") {
            firstTextBox.text = String((((celc - 32) * (5/9)) * 1000).rounded()/1000)
        } else {
            firstTextBox.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modeSegmentedControl.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .normal)
    }
    
    @IBAction func onModeChanged(_ sender: UISegmentedControl) {
        switch sender.titleForSegment(at: sender.selectedSegmentIndex) {
        case "Температура":
            firstLabel.text = "Цельсия"
            secondLabel.text = "Фаренгейты"
        case "Расстояние":
            firstLabel.text = "Киллометры"
            secondLabel.text = "Мили"
        case .none:
            break
        case .some(_):
            break
        }
    }
    @objc func changeOnTmpMode(_ sender: Any) {
        firstLabel.text = "Цельсия"
        secondLabel.text = "Фаренгейты"
    }
}
