//
//  CurrencyPickerViewController.swift
//  ExchangeRate
//
//  Created by John Greenwood on 09.04.2021.
//

import UIKit

class CurrencyPickerViewController: UIViewController {
    
    var blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var baseView = UIView()
    var titleLabel = UILabel()
    var tableView = UITableView()
    var divider = UIView()
    var okButton = UIButton(type: .system)
    var cancelButton = UIButton(type: .system)
    
    var currencies: [RatesResponse.Rate] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var selectedCurrency: RatesResponse.Rate?
    
    var selectionComplete: ((RatesResponse.Rate?) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func addSubviews() {
        view.addSubview(blurEffectView)
        view.addSubview(baseView)
        baseView.addSubview(titleLabel)
        baseView.addSubview(tableView)
        baseView.addSubview(okButton)
        baseView.addSubview(cancelButton)
        baseView.addSubview(divider)
    }
    
    func configureViews() {
        view.backgroundColor = .clear
        
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.8
        
        baseView.frame = CGRect(x: 0, y: 0,
                                width: 280 * DimensionsManager.horisontalMultiplier,
                                height: 344 * DimensionsManager.verticalMultiplier)
        baseView.backgroundColor = .systemBackground
        baseView.layer.cornerRadius = 14
        baseView.layer.masksToBounds = false
        baseView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.22)
        baseView.layer.shadowOpacity = 1
        baseView.layer.shadowOffset = CGSize(width: 0, height: 24)
        baseView.layer.shadowRadius = 24
        baseView.center = view.center
        
        let horisontalPadding = 24 * DimensionsManager.horisontalMultiplier
        titleLabel.frame = CGRect(x: horisontalPadding,
                                  y: 21 * DimensionsManager.verticalMultiplier,
                                  width: baseView.frame.size.width - horisontalPadding * 2,
                                  height: 28)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.87)
        titleLabel.text = "Choose a currency"
        
        setupButton(okButton, title: "OK")
        okButton.addTarget(self, action: #selector(okTapped), for: .touchUpInside)
        okButton.center = CGPoint(x: baseView.frame.size.width - (35 * DimensionsManager.horisontalMultiplier) - okButton.frame.size.width / 2,
                                  y: baseView.frame.size.height - (17 * DimensionsManager.verticalMultiplier) - okButton.frame.size.height / 2)
        
        
        setupButton(cancelButton, title: "CANCEL")
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        cancelButton.center = CGPoint(x: okButton.frame.minX - (43 * DimensionsManager.horisontalMultiplier) - cancelButton.frame.size.width / 2,
                                      y: okButton.center.y)
        
        divider.frame = CGRect(x: 0,
                               y: cancelButton.frame.minY - (17 * DimensionsManager.verticalMultiplier),
                               width: baseView.frame.size.width, height: 1)
        divider.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
        
        tableView.frame = CGRect(x: horisontalPadding,
                                 y: titleLabel.frame.maxY + (18 * DimensionsManager.verticalMultiplier),
                                 width: baseView.frame.size.width - horisontalPadding,
                                 height: divider.frame.minY - titleLabel.frame.maxY - (18 * DimensionsManager.verticalMultiplier))
        tableView.contentInset = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.accentColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.sizeToFit()
    }
    
    @objc func okTapped() {
        dismiss(animated: true) { [weak self] in
            self?.selectionComplete?(self?.selectedCurrency)
        }
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true) {
            //
        }
    }
}

// MARK: TableView delegate and datasource

extension CurrencyPickerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CurrencyCell()
        cell.selectedBackgroundView = UIView()
        cell.textLabel?.text = currencies[indexPath.row].currency
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedPath = tableView.indexPathForSelectedRow {
            let cell = tableView.cellForRow(at: selectedPath) as? CurrencyCell
            cell?.isSelected = false
            tableView.deselectRow(at: selectedPath, animated: true)
        }
        
        let cell = tableView.cellForRow(at: indexPath) as? CurrencyCell
        cell?.isSelected = true
        
        selectedCurrency = currencies[indexPath.row]
        
        return indexPath
    }
}
