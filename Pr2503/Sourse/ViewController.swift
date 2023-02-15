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
        button.addTarget(self, action: #selector(generatePassword), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonPaswordSearch: UIButton = {
        let button = UIButton()
        button.setTitle("Подобрать пароль", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.layer.cornerRadius = 25
        button.backgroundColor = .systemIndigo
        button.addTarget(self, action: #selector(searchPasword), for: .touchUpInside)
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
    
    @objc private func generatePassword() {
        let array = String.printable.map { String($0) }
//        let text = generateBruteForce("1234", fromArray: array)
        var text: String = ""
        for _ in 1...3 {
            text.append(array.randomElement() ?? "")
        }
        textField.isSecureTextEntry = true
        textField.text = text
    }
    
    @objc private func searchPasword() {
        if textField.text != "" {
            bruteForce(passwordToUnlock: textField.text ?? "")
        }
    }
    
    // MARK: - Funcions
    
    private func bruteForce(passwordToUnlock: String) {
        let allowedCharacters = String.printable.map { String($0) }

        var password = ""
        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: allowedCharacters)
            print(password)
        }
        label.text = password
        textField.isSecureTextEntry = false
    }
}
