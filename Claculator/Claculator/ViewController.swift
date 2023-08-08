import UIKit

class ViewController: UIViewController {
    
    var label: UILabel!
    var result: Double?
    var currentValue: Double?
    var operatorSign: String?
    let maxLength = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label = UILabel(frame: CGRect(x: 8, y: 150, width:
                        view.bounds.width-16, height: 100))
        view.addSubview(label)
        
        label.text = "0"
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 60)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self,
                                                        action: #selector(handleSwipeLeft(_:)))
        swipeLeftGesture.direction = .left
        label.addGestureRecognizer(swipeLeftGesture)
        label.isUserInteractionEnabled = true
        
        zero.layer.cornerRadius = zero.frame.size.height / 2
        zero.clipsToBounds = true
        one.layer.cornerRadius = one.frame.size.height / 2
        one.clipsToBounds = true
        two.layer.cornerRadius = two.frame.size.height / 2
        two.clipsToBounds = true
        three.layer.cornerRadius = three.frame.size.height / 2
        three.clipsToBounds = true
        four.layer.cornerRadius = four.frame.size.height / 2
        four.clipsToBounds = true
        five.layer.cornerRadius = five.frame.size.height / 2
        five.clipsToBounds = true
        six.layer.cornerRadius = six.frame.size.height / 2
        six.clipsToBounds = true
        seven.layer.cornerRadius = seven.frame.size.height / 2
        seven.clipsToBounds = true
        eight.layer.cornerRadius = eight.frame.size.height / 2
        eight.clipsToBounds = true
        nine.layer.cornerRadius = nine.frame.size.height / 2
        nine.clipsToBounds = true
        ac.layer.cornerRadius = ac.frame.size.height / 2
        ac.clipsToBounds = true
        plusminus.layer.cornerRadius = plusminus.frame.size.height / 2
        plusminus.clipsToBounds = true
        percent.layer.cornerRadius = percent.frame.size.height / 2
        percent.clipsToBounds = true
        divide.layer.cornerRadius = divide.frame.size.height / 2
        divide.clipsToBounds = true
        muliply.layer.cornerRadius = muliply.frame.size.height / 2
        muliply.clipsToBounds = true
        minus.layer.cornerRadius = minus.frame.size.height / 2
        minus.clipsToBounds = true
        plus.layer.cornerRadius = plus.frame.size.height / 2
        plus.clipsToBounds = true
        equal.layer.cornerRadius = equal.frame.size.height / 2
        equal.clipsToBounds = true
        point.layer.cornerRadius = point.frame.size.height / 2
        point.clipsToBounds = true
        
        
        
    }
    
    @objc func handleSwipeLeft(_ gesture: UISwipeGestureRecognizer) {
        guard var text = label.text, !text.isEmpty else {
            return
        }
        if text.count == 2 && text.hasPrefix("-") {
            if !text.hasPrefix("-0") {
                text = "-0"
            } else {
                text = "0"
            }
        } else {
            text.removeLast()
            if text.isEmpty {
                text = "0"
            }
        }
        label.text = text
    }
    
    
    @IBAction func numberButtonTap(_ sender: UIButton) {
        guard var text = label.text else {
            label.text = ""
            return
        }
        if text.count < maxLength {
            if text == "0" && !text.contains(".") {
                text = ""
            } else if  text == "-0" {
                text = "-"
            }
            text.append(String(sender.tag))
            label.text = text
            currentValue = Double(label.text!)
        }
    }
    
    @IBAction func zeroButtonTap(_ sender: UIButton) {
        guard var text = label.text else {
            label.text = ""
            return
        }
        if text == "" || text == "0" {
            text = "0"
        } else if text == "-0" {
            text = "-0"
        } else if text.hasPrefix("0.") || text.hasPrefix("-0.") {
            text.append("0")
        } else {
            text += "0"
        }
        label.text = text
        currentValue = Double(text)
    }
    
    @IBAction func pointButtonTap(_ sender: UIButton) {
        guard var text = label.text else {
            label.text = ""
            return
        }
        if text.count == 0 {
            text.append("0.")
            label.text = text
            currentValue = Double(label.text!)
        } else {
            if !text.contains("."){
                text.append(".")
                label.text = text
                currentValue = Double(label.text!)
            }
        }
    }
    
    //Clears the current entry
    @IBAction func actionButtonTap(_ sender: UIButton) {
        currentValue = nil
        label.text = "0"
        result = nil
    }
    
    //Changes the sign
    @IBAction func toggleButtonTap(_ sender: UIButton) {
        guard var text = label.text else { return }
        
        if text.isEmpty {
            text = "0"
        } else if text == "0"{
            text = "-0"
        } else if text == "-0" {
            text = "0"
        } else if let result = self.result {
            self.result = -result
            text = String(self.result!)
        } else if let currentValue = self.currentValue {
            self.currentValue = -currentValue
            text = String(self.currentValue!)
        }
        if text.hasSuffix(".0") {
            text.removeLast(2)
        }
        label.text = text
    }
    
    
    //Calculates a percentage of the displayed number
    @IBAction func percentageButtonTap(_ sender: UIButton) {
        if let result = self.result {
            self.result = result / 100
            label.text = String(self.result!)
        } else if let currentValue = self.currentValue {
            self.currentValue = currentValue / 100
            label.text = String(self.currentValue!)
        }
    }
    
    @IBAction func divisionButtonTap(_ sender: UIButton) {
        result = Double(label.text!)
        self.operatorSign = "/"
        label.text = "0"
    }
    
    @IBAction func multiplicationButtonTap(_ sender: UIButton) {
        result = Double(label.text!)
        self.operatorSign = "x"
        label.text = "0"
    }
    
    
    @IBAction func substractionButtonTap(_ sender: UIButton) {
        result = Double(label.text!)
        self.operatorSign = "-"
        label.text = "0"
    }
    
    @IBAction func additionButtonTap(_ sender: UIButton) {
        result = Double(label.text!)
        self.operatorSign = "+"
        label.text = "0"
    }
    
    @IBAction func equalButtonTap(_ sender: UIButton) {
        guard let currentValue = currentValue, var text = label.text else { return }
        
        switch operatorSign {
        case "+":
            result! += currentValue
            text = String(result!)
        case "-":
            result! -= currentValue
            text = String(result!)
        case "x":
            result! *= currentValue
            text = String(result!)
        case "/":
            if currentValue != 0 {
                result! /= currentValue
                text = String(result!)
            }
            else {
                text = "Error"
            }
        default:
            break
        }
        label.text = text
        
        if label.text!.hasSuffix(".0") {
            label.text!.removeLast(2)
        }
    }
    
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    @IBOutlet weak var ac: UIButton!
    @IBOutlet weak var plusminus: UIButton!
    @IBOutlet weak var percent: UIButton!
    @IBOutlet weak var divide: UIButton!
    @IBOutlet weak var muliply: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var equal: UIButton!
    @IBOutlet weak var point: UIButton!
}
