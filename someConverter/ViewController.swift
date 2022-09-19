import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var firstTextBox: UITextField!
    @IBOutlet weak var secondTextBox: UITextField!
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    var currentConverter: ConverterProtocol = TemperaturConverter(max: 50, min: -80)
    let distanceConverter = DistanceConverter()
    
    private var precision: Int = 3
    
    func celsiusToFahrenheit(value: Double) -> Double {
        ((value * (9/5) + 32) * 1000).rounded() / 1000
    }
    
    enum convertMode {
        case temperature
        case distance
    }
    @IBAction func changeSecondTextBoxSymbol(_ sender: UIButton) {
        var text = secondTextBox.text ?? ""
        if text.first != "-" {
            text = "-" + text
        }
        else {
            text.removeFirst()
        }
        secondTextBox.text = text
        farengDidChanged(secondTextBox)
    }
    
    @IBAction func changeFirstTextBoxSymbol(_ sender: UIButton) {
        var text = firstTextBox.text ?? ""
        if text.first != "-" {
            text = "-" + text
        }
        else {
            text.removeFirst()
        }
        firstTextBox.text = text
        celcDidChange(firstTextBox)
    }
    
    
    private func checkValue(textBox: UITextField) {
        guard let min = currentConverter.min,
              let max = currentConverter.max else { return }
        
        if var value = Double(textBox.text ?? "") {
            if value <= min {
                textBox.text = String(Int(min))
                value = min
            }
            else if value >= max {
                textBox.text = String(Int(max))
                value = max
            }
        }
    }
    
    @IBAction func celcDidChange(_ sender: UITextField) {
        checkValue(textBox: sender)
        
        guard let value = Double(sender.text ?? ""), value != 0 else {
            sender.text = ""
            secondTextBox.text = ""
            return
        }
        
        secondTextBox.text = String(currentConverter.convertTo(value: value))
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        modeSegmentedControl.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .normal)
        title = "КОНВЕРТЕР"
        navigationController?.navigationBar.prefersLargeTitles = false

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "AccentColor")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 30, weight: .bold)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onModeChanged(_ sender: UISegmentedControl) {
        switch sender.titleForSegment(at: sender.selectedSegmentIndex) {
        case "Температура":
            firstLabel.text = "Цельсия"
            secondLabel.text = "Фаренгейты"
            currentConverter = TemperaturConverter(max: 50, min: -80)
            firstTextBox.text = ""
            secondTextBox.text = ""
        case "Расстояние":
            firstLabel.text = "Киллометры"
            secondLabel.text = "Мили"
            currentConverter =  DistanceConverter()
            firstTextBox.text = ""
            secondTextBox.text = ""
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
