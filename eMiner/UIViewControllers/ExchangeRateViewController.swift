//
//  ExchangeRateViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/14/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Material
import RxSwift
import RxCocoa

class ExchangeRateViewController: BlueNavigationBarViewController {
    
    @IBOutlet weak var fromContainerView: UIView!
    @IBOutlet weak var toContainerView: UIView!
    @IBOutlet weak var fromCurrencySymbolContainerView: UIView!
    private var didPerformedFirstSegueFromStoryboard = false
    
    var fromSymbol = "BTC"
    var toSymbol = "USD"
    
    var openFromCurrencySegue: String { return "openFromCurrencySegue"}
    var openToCurrencySegue:String { return "openToCurrencySegue" }
    
    @IBOutlet weak var toCurrencySymbolContainerView: UIView!
    @IBOutlet weak var separatorView: UIView!
    
    @IBOutlet weak var amountNumberTextField: UITextField!
    var disposeBag = DisposeBag()
    var amount: Double {
        get { return Double(amountNumberTextField.text!) ?? 0.0 }
        set { amountNumberTextField.text = "\(newValue)"}
    }
    @IBOutlet weak var resultTextLabel: UILabel!
    
    var result: Double {
        get { return Double(resultTextLabel.text!) ?? 0.0 }
        set { resultTextLabel.text = "\(newValue)" }
    }
    
    @IBOutlet weak var fromCurrencyLabel: UILabel!
    @IBOutlet weak var toCurrencyLabel: UILabel!
    var currencies: [CurrencyModel] { return RemoteFactory.remoteFactory.remoteCurrencies.currencies }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setContainerColor()
        loadCurrencies()
        
        result = SingletonExchangeRate.sharedInstance.price
        amountNumberTextField.delegate = self
        
        SingletonExchangeRate.sharedInstance.fromCurrencyDidChangeHandler = {
            self.fromSymbol = $0
            _ = self.getFromIndex(fromSymbol: $0)
            self.fromCurrencyLabel.text = self.fromSymbol + " ▼"
        }
        SingletonExchangeRate.sharedInstance.toCurrencyDidChangeHandler = {
            self.toSymbol = $0
            self.toCurrencyLabel.text = self.toSymbol + " ▼"
            _ = self.getToIndex(toSymbol: $0)
        }
        
        fromCurrencyLabel.text = fromSymbol + " ▼"
        toCurrencyLabel.text = toSymbol + " ▼"
        
        
        
        amountNumberTextField
            .addTarget(self,
                       action: #selector(ExchangeRateViewController.valueDidChange),
                       for: .editingChanged)
        
        
    }
    private func loadCurrencies()
    {
        self.view.isUserInteractionEnabled = false
        
        if (RemoteFactory.remoteFactory.remoteCurrencies.currencies.count == 0)
        {
            startActivityIndicator()
            _ = RemoteFactory
                .remoteFactory
                .remoteCurrencies
                .loadCurrencies()
                .subscribe(onNext:
                    { _ in
                        _ = self.getFromIndex(fromSymbol: self.fromSymbol)
                        _ = self.getToIndex(toSymbol: self.toSymbol)
                        self.view.isUserInteractionEnabled = false
                        self.checkPrice() {
                            self.stopActivityIndicator()
                            self.amountNumberTextField.becomeFirstResponder()

                        }
                        
                } ,
                           onError: { self.showAlert(title: "Something went wrong",
                                                     message: $0.localizedDescription,
                                                     button: "OK") {
                                                        
                                                        self.delayFor(second: 5) { self.loadCurrencies()  }
                            }
                },
                           onCompleted: { self.view.isUserInteractionEnabled = true })
            
        }
        else
        {
            checkPrice() {self.stopActivityIndicator() }
            self.view.isUserInteractionEnabled = true
        }
        
        
    }
    func checkPrice(then: (()->())? = nil)
    {
        if (SingletonExchangeRate.sharedInstance.price == 0)
        {
            self.startActivityIndicator()
            RemoteFactory
                .remoteFactory
                .remoteCurrencyCalculator
                .convert(from: fromSymbol, to: toSymbol)
                .subscribe(onNext:
                    { SingletonExchangeRate.sharedInstance.price = $0
                        then?()
                } )
                .addDisposableTo(disposeBag)
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        if (RemoteFactory.remoteFactory.remoteCurrencies.currencies.count > 0)
        {
            self.amountNumberTextField.becomeFirstResponder()
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?)
    {
        
        if (segue.identifier == openToCurrencySegue ||
            segue.identifier == openFromCurrencySegue)
        {
            let navigationController = segue.destination as? UINavigationController
            
            let viewController = navigationController?.viewControllers.first as? ExchangeRateCurrencyPickerViewController
            
            viewController?.didDismissViewControllerHandler = {
                self.amountNumberTextField.becomeFirstResponder()
                self.calculate()
            }
            self.didPerformedFirstSegueFromStoryboard = false
            
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (didPerformedFirstSegueFromStoryboard == false)
        {
            didPerformedFirstSegueFromStoryboard = true
            performSegue(withIdentifier: identifier, sender: self)
            return false
        }
        else { return true }
    }
    
    func valueDidChange(textField: UITextField)
    {
        calculate()
    }
    
    func calculate()
    {
        let price = SingletonExchangeRate.sharedInstance.price
        
        let result = price * amount
        
        self.result = result
        
    }
    
    @IBAction func pressedFromCurrency(_ sender: UIButton)
    {
        SingletonExchangeRate
            .sharedInstance
            .currencyExchangeRateCaller = .from
    }
    
    @IBAction func pressedToCurrency(_ sender: UIButton)
    {
        SingletonExchangeRate
            .sharedInstance
            .currencyExchangeRateCaller  = .to
    }
    func getFromIndex(fromSymbol: String) -> Int
    {
        let fromIndex = RemoteFactory.remoteFactory.remoteCurrencies.isAtIndex(symbol: fromSymbol)
        
        return fromIndex
    }
    
    func getToIndex(toSymbol: String) -> Int
    {
        let toIndex = RemoteFactory.remoteFactory.remoteCurrencies.isAtIndex(symbol: toSymbol)
        
        
        return toIndex
    }
    
    func setContainerColor()
    {
        separatorView.backgroundColor = Color.blue.darken4
        
        fromContainerView.backgroundColor = Color.blue.darken1
        fromCurrencySymbolContainerView.backgroundColor = Color.blue.base
        
        toContainerView.backgroundColor = Color.blue.base
        toCurrencySymbolContainerView.backgroundColor = Color.blue.lighten1
        
    }
}

extension ExchangeRateViewController : UITextFieldDelegate
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
    }
    
    
}
