import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var firstTextBox: UITextField!
    @IBOutlet weak var secondTextBox: UITextField!
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    var currentConverter: ConverterProtocol = TemperaturConverter(max: 50, min: -80, precision: 2)
    
    func celsiusToFahrenheit(value: Double) -> Double {
        ((value * (9/5) + 32) * 1000).rounded() / 1000
    }
    
    enum convertMode {
        case temperature
        case distance
    }
    
    func changeTextBoxSymbol(textBox: UITextField) {
        var text = textBox.text ?? ""
        if text.first != "-" {
            text = "-" + text
        }
        else {
            text.removeFirst()
        }
        textBox.text = text

    }
    
    @IBAction func changeFirstTextBoxSymbol(_ sender: UIButton) {
        changeTextBoxSymbol(textBox: firstTextBox)
        celcDidChange(firstTextBox)
    }
    
    @IBAction func changeSecondTextBoxSymbol(_ sender: UIButton) {
        changeTextBoxSymbol(textBox: secondTextBox)
        farengDidChanged(secondTextBox)
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
    
    @IBAction func onInfoButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Об авторах", message: "Дизайн by Васильев Д.Е.\n Разработано by Воробей А.И.\nПрезентовано by Белоусов С.А.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Невероятные парни!", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        checkValue(textBox: sender)
        
        guard let value = Double(sender.text ?? ""), value != 0 else {
            sender.text = ""
            firstTextBox.text = ""
            return
        }
        
        firstTextBox.text = String(currentConverter.convertFrom(value: value))

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
            currentConverter = TemperaturConverter(max: 50, min: -80, precision: 2)
            firstTextBox.text = ""
            secondTextBox.text = ""
        case "Расстояние":
            firstLabel.text = "Километры"
            secondLabel.text = "Мили"
            currentConverter =  DistanceConverter(precision: 2)
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
