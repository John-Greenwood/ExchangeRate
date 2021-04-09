//
//  MainViewController.swift
//  ExchangeRate
//
//  Created by John Greenwood on 09.04.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var blurView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
    var activityIndicatorView = UIActivityIndicatorView(style: .large)
    var sendTextField = BottomBorderedTextField()
    var getTextField = BottomBorderedTextField()
    var swapButton = UIButton(type: .system)
    var sendCurrencyButton = ChevronButton(type: .system)
    var getCurrencyButton = ChevronButton(type: .system)
    
    var swapping = false
    
    var firstRate = RatesResponse.Rate(currency: "LOL", rate: 1) {
        didSet {
            configCurrencyButton(sendCurrencyButton, title: firstRate.currency)
            calculate()
        }
    }
    
    var secondRate = RatesResponse.Rate(currency: "KEK", rate: 1) {
        didSet {
            configCurrencyButton(getCurrencyButton, title: secondRate.currency)
            calculate()
        }
    }
    
    var model = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureNavbar()
        addSubviews()
        configureViews()
        addKeyboardHideGesture()
        
        model.currencyRates.bind { [weak self] (rates) in
            guard let rates = rates else { return }
            
            UIView.animate(withDuration: 0.2) {
                self?.blurView.removeFromSuperview()
                self?.activityIndicatorView.stopAnimating()
            }
            
            if rates.count == 0 {
                let ac = UIAlertController(title: "Ошибка", message: "При загрузке данных произошла ошибка, проверьте свое интернет соединение", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self?.present(ac, animated: true, completion: nil)
                
                return
            }
            
            self?.firstRate = rates.first!
            self?.secondRate = rates.last!
        }
    }
    
    // MARK: Appearence
    
    func addSubviews() {
        view.addSubview(sendCurrencyButton)
        view.addSubview(sendTextField)
        view.addSubview(swapButton)
        view.addSubview(getTextField)
        view.addSubview(getCurrencyButton)
        
        view.addSubview(blurView)
        view.addSubview(activityIndicatorView)
    }
    
    func configureViews() {
        view.backgroundColor = .systemBackground
        
        // loader
        blurView.frame = view.bounds
        activityIndicatorView.center = view.center
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        
        
        let horisontalPadding = 36 * DimensionsManager.horisontalMultiplier
        
        // Send
        configCurrencyButton(sendCurrencyButton, title: "RUB")
        sendCurrencyButton.addTarget(self, action: #selector(openDialog(_:)), for: .touchUpInside)
        sendCurrencyButton.center.x = view.frame.size.width - horisontalPadding - sendCurrencyButton.frame.size.width / 2
        
        let fieldsWidth = view.frame.size.width - horisontalPadding * 2 - sendCurrencyButton.frame.size.width - 33
        
        sendTextField.frame = CGRect(x: horisontalPadding,
                                     y: navbarMaxY + (40 * DimensionsManager.verticalMultiplier),
                                     width: fieldsWidth, height: 69)
        sendTextField.titleLabel.text = "You send"
        sendTextField.textField.addTarget(self, action: #selector(sendTextDidTyped), for: .editingChanged)
        sendTextField.textField.delegate = self
        sendTextField.textField.text = "0.00"
        
        sendCurrencyButton.center.y = sendTextField.center.y
        
        // Swapper
        swapButton.frame = CGRect(x: 0, y: sendTextField.frame.maxY + 14,
                                  width: 32, height: 32)
        swapButton.center.x = view.frame.size.width / 2
        swapButton.setImage(.swap, for: .normal)
        swapButton.addTarget(self, action: #selector(swap), for: .touchUpInside)
        
        
        // Get
        getTextField.frame = CGRect(x: horisontalPadding,
                                    y: swapButton.frame.maxY + 14,
                                    width: fieldsWidth, height: 69)
        getTextField.titleLabel.text = "They get"
        getTextField.textField.delegate = self
        getTextField.textField.text = "0.00"
        getTextField.isUserInteractionEnabled = false
        
        configCurrencyButton(getCurrencyButton, title: "EUR")
        getCurrencyButton.addTarget(self, action: #selector(openDialog(_:)), for: .touchUpInside)
        getCurrencyButton.center = CGPoint(x: view.frame.size.width - horisontalPadding - getCurrencyButton.frame.size.width / 2, y: getTextField.center.y)
    }
    
    func configCurrencyButton(_ button: ChevronButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.accentColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.sizeToFit()
    }
    
    func configureNavbar() {
        title = "Currency converter"
        
        // Navbar buttons
        let hamburgerButton = UIBarButtonItem(image: .hamburgerMenu,
                                              style: .plain,
                                              target: self,
                                              action: #selector(showHamburgerMenu))
        hamburgerButton.tintColor = .white
        navigationItem.leftBarButtonItem = hamburgerButton
    }
    
    // MARK: Actions
    
    func calculate() {
        guard !swapping else { return }
        getTextField.textField.text = String(format: "%.2f", (Double(sendTextField.textField.text ?? "0") ?? 0) / firstRate.rate * secondRate.rate)
    }
    
    @objc func sendTextDidTyped() {
        guard Double(sendTextField.textField.text ?? "") != nil else { return }
        calculate()
    }
    
    @objc func showHamburgerMenu() {
        //
    }
    
    @objc func openDialog(_ sender: UIButton) {
        let controller = CurrencyPickerViewController()
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.currencies = model.currencyRates.value ?? []
        controller.selectionComplete = { [weak self] currencyRate in
            guard let currencyRate = currencyRate else { return }
            
            if sender == self?.sendCurrencyButton {
                self?.firstRate = currencyRate
            } else {
                self?.secondRate = currencyRate
            }
        }
        present(controller, animated: true, completion: nil)
    }
    
    @objc func swap() {
        swapping = true
        (firstRate, secondRate) = (secondRate, firstRate)
        (sendTextField.textField.text, getTextField.textField.text) = (getTextField.textField.text, sendTextField.textField.text)
        swapping = false
    }
}

// MARK: TextFields

extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = String(format: "%.2f", Double(textField.text ?? "0") ?? 0)
    }
}
