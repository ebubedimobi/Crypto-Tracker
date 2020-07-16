//
//  ViewController.swift
//  ByteCoin
//
//  Created by Ebubechukwu Dimobi on 11.07.2020.
//  Copyright © 2020 blazeapps. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyLabel.text = coinManager.currencyArray[0]
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
    
    
}

//MARK: - UIPickerView(currency Picker) Delegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    //returns how many colums
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    //returns howm many rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return coinManager.currencyArray.count
    }
    
    //to fill up the picker view- row for row component for column
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return coinManager.currencyArray[row]
    }
    
    //to know when a row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedCurrency = coinManager.currencyArray[row]
        currencyLabel.text = selectedCurrency
        
        
        coinManager.getCoinName(for: selectedCurrency)
        
    }
    
    
    
}

//MARK: - CoinManager Delegate

extension ViewController: CoinManagerDelegate{
    func didUpdateCurrency(with coinModel: CoinModel) {
        
        DispatchQueue.main.async {
            
            self.bitCoinLabel.text = coinModel.rateToString
            self.currencyLabel.text = coinModel.currencyName
        }
        
    }
    
    func didFailWithError(with error: Error) {
        print("error")
    }
    
    
    
    
}


