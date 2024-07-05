//
//  File.swift
//
//
//  Created by Muhammad Ibrar on 06/07/2024.
//

import UIKit
import SwiftUI

final class _MITextField: UITextField {
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
}

struct MITextField: UIViewRepresentable {
    @Binding var text: String
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: MITextField
        
        init(parent: MITextField) {
            self.parent = parent
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let newString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
            parent.text = newString
            return false
        }
        
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            // Disable selection handles
            if let selectedRange = textField.selectedTextRange {
                textField.replace(selectedRange, withText: "")
            }
            return true
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> _MITextField {
        let textField = _MITextField()
        textField.isUserInteractionEnabled = true // Allow input
        textField.delegate = context.coordinator
        textField.text = text
        textField.textColor = .clear
        textField.tintColor = .clear
        return textField
    }
    
    func updateUIView(_ uiView: _MITextField, context: Context) {
        uiView.text = text
    }
}


extension MITextField.Coordinator {
    @objc func textFieldDidChangeSelection(_ textField: UITextField) {
        // Disable text selection programmatically
        if let selectedRange = textField.selectedTextRange, selectedRange.isEmpty == false {
            textField.selectedTextRange = nil
        }
    }
}
