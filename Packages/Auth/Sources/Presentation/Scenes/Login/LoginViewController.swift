//
//  LoginViewController.swift
//  
//
//  Created by Aung Bo Bo on 12/05/2024.
//

import Core
import SnapKit
import UIKit

final public class LoginViewController: BaseViewController {
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    
    private let viewModel: LoginViewModel
    private let router: AuthRouter
    
    public init(viewModel: LoginViewModel, router: AuthRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        bind()
    }
    
    private func configureHierarchy() {
        configureView()
        configureNavigationItem()
        configureLoginTextField()
        configurePasswordTextField()
        configureLoginButton()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigationItem() {
        navigationItem.title = viewModel.title
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    private func configureLoginTextField() {
        view.addSubview(loginTextField)
        loginTextField.delegate = self
        loginTextField.placeholder = "Username or Email"
        loginTextField.borderStyle = .roundedRect
        loginTextField.keyboardType = .emailAddress
        loginTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func configurePasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.delegate = self
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        updateLoginButton()
    }
    
    private func configureLoginButton() {
        view.addSubview(loginButton)
        loginButton.configuration = UIButton.Configuration.filled()
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonPressed(_:)), for: .touchUpInside)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    @objc private func loginButtonPressed(_ button: UIButton) {
        login()
    }
    
    private func bind() {
        viewModel.state
            .sink { [weak self] state in
                self?.render(state: state)
            }
            .store(in: &viewModel.cancellables)
    }
    
    private func render(state: LoginViewModel.State) {
        switch state {
        case .idle:
            clearContentUnavailableConfiguration()
            loginTextField.becomeFirstResponder()
            updateLoginButton()
        case .loading:
            showLoading()
        case let .failed(error):
            clearContentUnavailableConfiguration()
            showErrorAlert(error: error)
        case .succeeded:
            clearContentUnavailableConfiguration()
            router.routeToQotd()
        }
    }
    
    private func updateLoginButton() {
        loginButton.isEnabled = viewModel.isValid(login: loginTextField.text, password: passwordTextField.text)
    }
    
    private func login() {
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        Task {
            await viewModel.login(login: login, password: password)
        }
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            login()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
}
