//
//  PickerView.swift
//  GitHubSearch
//
//  Created by mazzatech on 22/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import UIKit
import RxSwift

extension UITextField {
    
    func loadDropdown(data: [String], minValues: Int = 0) {
        self.inputView = DropdownPickerView(pickerData: data, dropdownField: self, minValues: minValues)
    }
    
}

class DropdownPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerData: [String]!
    var pickerTextField: UITextField!
    
    init(pickerData: [String], dropdownField: UITextField, minValues: Int){
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.pickerData = pickerData
        self.pickerTextField = dropdownField
        
        
        self.delegate = self
        self.dataSource = self
        
        
        DispatchQueue.main.async {
            if pickerData.count > minValues {
                self.pickerTextField.isEnabled = true
            } else if pickerData.count == minValues {
                self.pickerTextField.isEnabled = false
            } else {
                self.pickerTextField.text = ""
                self.pickerTextField.isEnabled = false
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickerData[row]
    }
}

