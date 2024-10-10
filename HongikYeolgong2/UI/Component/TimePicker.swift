//
//  Picker.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/8/24.
//

import SwiftUI
import Combine

struct TimePicker: UIViewRepresentable {
    @Binding var selected: Int
    let data: [Int]
    
    func makeUIView(context: Context) -> UIPickerView {
        let picker = UIPickerView()
        picker.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIView(_ uiView: UIPickerView, context: UIViewRepresentableContext<TimePicker>) {        
        uiView.selectRow(selected, inComponent: 0, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        return TimePicker.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        var parent: TimePicker        
        
        init(parent: TimePicker) {
            self.parent = parent
        }
        
        // row개수
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return parent.data.count
        }
        
        // picker 개수
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            // 숫자위에 상자 제거
            pickerView.subviews[1].alpha = 0
            
            // label을 감싸는 view
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 42.adjustToScreenWidth, height: 35.adjustToScreenHeight))            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
         
            label.text = String(format: "%02d", parent.data[row])
            
            label.textColor = UIColor(.white)
            label.textAlignment = .center
            label.font = UIFont(name: "SUITE-Bold", size: 24)
            
            view.addSubview(label)
            
            return view
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.parent.selected = parent.data[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 43.adjustToScreenHeight
        }
    }
}
