//
//  ExchangeRateCurrencyPickerViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/15/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import PickerView
import SnapKit
import RxSwift


class ExchangeRateCurrencyPickerViewController: BlueNavigationBarViewController
{
    
    
    var currencies: [CurrencyModel]
    { return RemoteFactory.remoteFactory.remoteCurrencies.currencies }
    
    var currencyExchangeRateCaller: CurrencyExchangeRateCaller
    { return SingletonExchangeRate.sharedInstance.currencyExchangeRateCaller }
    
    var didDismissViewControllerHandler: (()->())?
    var selectedFrom: String = SingletonExchangeRate.sharedInstance.fromCurrency
    var selectedTo: String = SingletonExchangeRate.sharedInstance.toCurrency
    var pickerView = PickerView()
    
    var dataSource = CurrencyPickerDataSource()
    var delegate = ExchangeRatePickerViewDelegate()
    var isAddedConstraints = false
    var disposeBag = DisposeBag()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initialPickerView()
        self.view.addSubview(pickerView)
    }
    
    override func updateViewConstraints()
    {
        if (isAddedConstraints == false)
        {
            pickerView.snp.makeConstraints(){
                $0.height.equalTo(self.view)
                $0.width.equalTo(self.view).multipliedBy(0.8)
                $0.center.equalTo(self.view)
            }
            
            isAddedConstraints = true
        }
        super.updateViewConstraints()
    }
    @IBAction func dissmissViewController(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func initialPickerView()
    {
        delegate.fromCurrencyDidChange = {
            self.selectedFrom = $0
        }
        delegate.toCurrencyDidChange = {
            self.selectedTo = $0
        }
        
        pickerView.delegate = delegate
        pickerView.dataSource = dataSource
        pickerView.scrollingStyle = .default
        pickerView.selectionStyle  = .defaultIndicator
        pickerView.backgroundColor = Colors.grayBackground
        var currentCurrency = ""
        
        if (currencyExchangeRateCaller == .from)
        {
            currentCurrency = SingletonExchangeRate.sharedInstance.fromCurrency
        }
        if (currencyExchangeRateCaller == .to)
        {
            currentCurrency = SingletonExchangeRate.sharedInstance.toCurrency
        }
        
        pickerView.currentSelectedRow = RemoteFactory.remoteFactory.remoteCurrencies.isAtIndex(symbol: currentCurrency)
    }
    
    @IBAction func submitButtonPressed(_ sender: UIBarButtonItem)
    {
        startActivityIndicator()
       
        print("from :", selectedFrom)
        print("to : ",selectedTo)
        if (selectedFrom != "")
        {
            SingletonExchangeRate
                .sharedInstance
                .fromCurrency = selectedFrom
        }

        if (selectedTo != ""){
        SingletonExchangeRate
            .sharedInstance
            .toCurrency = selectedTo }
        
        setPrice()

    }
    func setPrice(completion: (()->())? = nil )
    {
        RemoteFactory
            .remoteFactory
            .remoteCurrencyCalculator
            .convert(
                from: SingletonExchangeRate.sharedInstance.fromCurrency,
                to: SingletonExchangeRate.sharedInstance.toCurrency)
            .subscribe(onNext: {
                
                SingletonExchangeRate.sharedInstance.price = $0
                
                self.stopActivityIndicator()
                self.dismiss(animated: true, completion: nil)
                self.didDismissViewControllerHandler?()
                
            },
                       onError: { self.showAlert(title: "Something went wrong",
                                                 message: $0.localizedDescription,
                                                 button: "OK") }).addDisposableTo(disposeBag)
    }
}

enum CurrencyExchangeRateCaller {
    case from
    case to
    case none
}
