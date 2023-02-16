import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var bruteForse = BruteForce()
    
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
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .black
        indicator.style = .large
        return indicator
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setups
    
    private func setupHierarchy() {
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(buttonPasword)
        view.addSubview(buttonPaswordSearch)
        view.addSubview(indicator)
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
        
        indicator.snp.makeConstraints { make in
            make.height.width.equalTo(60)
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.centerX.equalTo(view)
        }
    }
    
    // MARK: - Actions
    
    @objc private func generatePassword() {
        let array = String.printable.map { String($0) }
        var text: String = ""
        for _ in 1...3 {
            text.append(array.randomElement() ?? "")
        }
        textField.isSecureTextEntry = true
        textField.text = text
    }
    
    @objc private func searchPasword() {
        if textField.text != "" {
            indicator.startAnimating()
            let text = bruteForse.bruteForce(passwordToUnlock: textField.text ?? "")
            label.text = text
            textField.isSecureTextEntry = false
        }
    }
}
