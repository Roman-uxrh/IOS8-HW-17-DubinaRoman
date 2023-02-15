import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var label: UILabel = {
        let labelLogin = UILabel()
        labelLogin.text = "Подобранный пароль"
        labelLogin.textColor = .black
        labelLogin.font = UIFont.boldSystemFont(ofSize: 25)
        labelLogin.textAlignment = .center
        return labelLogin
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.textAlignment = .center
        textField.placeholder = "Сгенерированный пароль"
        textField.font = UIFont.systemFont(ofSize: 25)
        textField.backgroundColor = .cyan
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private lazy var buttonPasword: UIButton = {
        let button = UIButton()
        button.setTitle("Сгенерировать пароль", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.layer.cornerRadius = 25
        button.backgroundColor = .systemIndigo
        return button
    }()
    
    private lazy var buttonPaswordSearch: UIButton = {
        let button = UIButton()
        button.setTitle("Подобрать пароль", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.layer.cornerRadius = 25
        button.backgroundColor = .systemIndigo
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
//        self.bruteForce(passwordToUnlock: "1!gr")
    }
    
    // MARK: - Setups
    
    private func setupHierarchy() {
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(buttonPasword)
        view.addSubview(buttonPaswordSearch)
    }
    
    private func setupLayout() {
        
        label.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(140)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(40)
            make.height.equalTo(50)
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(-40)
        }
        
        buttonPasword.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(80)
            make.height.equalTo(50)
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(-40)
        }
        
        buttonPaswordSearch.snp.makeConstraints { make in
            make.top.equalTo(buttonPasword.snp.bottom).offset(30)
            make.height.equalTo(50)
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(-40)
        }
    }
    
    // MARK: - Actions
    
    // MARK: - Funcions
    
    func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

        var password: String = ""
        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
            print(password)
        }
        print(password)
    }
}



extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }



    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

func indexOf(character: Character, _ array: [String]) -> Int {
    return array.firstIndex(of: String(character))!
}

func characterAt(index: Int, _ array: [String]) -> Character {
    return index < array.count ? Character(array[index])
                               : Character("")
}

func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
    var str: String = string

    if str.count <= 0 {
        str.append(characterAt(index: 0, array))
    }
    else {
        str.replace(at: str.count - 1,
                    with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

        if indexOf(character: str.last!, array) == 0 {
            str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
        }
    }

    return str
}

