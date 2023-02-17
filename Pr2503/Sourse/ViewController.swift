import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    private let bruteForse = BruteForce()
    
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
        textField.placeholder = "Пароль"
        textField.font = UIFont.systemFont(ofSize: 25)
        textField.backgroundColor = .cyan
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var stopGenerate: UIButton = {
        let button = UIButton()
        button.setTitle("Стоп", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.layer.cornerRadius = 25
        button.backgroundColor = .systemIndigo
        button.addTarget(self, action: #selector(stopGeneratePassword), for: .touchUpInside)
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
        bruteForse.delegate = self
    }
    
    // MARK: - Setups
    
    private func setupHierarchy() {
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(stopGenerate)
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
        
        stopGenerate.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(80)
            make.height.equalTo(50)
            make.width.equalTo(80)
            make.centerX.equalTo(view)
        }
        
        buttonPaswordSearch.snp.makeConstraints { make in
            make.top.equalTo(stopGenerate.snp.bottom).offset(30)
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
    
    @objc private func stopGeneratePassword() {
        bruteForse.isStarted = false
    }
    
    @objc private func searchPasword() {
        if textField.text == "" {
            label.text = "Введите пароль"
        } else {
            let pasword = textField.text
            indicator.startAnimating()
            bruteForse.bruteForce(passwordToUnlock: pasword ?? "")
//            textField.isSecureTextEntry = false
//            indicator.stopAnimating()
        }
    }
}

protocol BruteForcerProtocol: AnyObject {
    func showPasswordLabel(text: String)
    func stopAnimating()
}

extension ViewController: BruteForcerProtocol {
    func showPasswordLabel(text: String) {
        label.text = text
    }
    
    func stopAnimating() {
        indicator.stopAnimating()
    }
}
