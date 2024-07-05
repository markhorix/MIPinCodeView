//
//  MITextField.swift
//
//
//  Created by Muhammad Ibrar on 06/07/2024.
//

import UIKit
import SwiftUI

/// A custom UITextField subclass that disables text selection actions.
final class _MITextField: UITextField {
    /// Override canPerformAction to disable text selection actions.
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
}

/// A SwiftUI wrapper for the custom UITextField that disables text selection
struct MITextField: UIViewRepresentable {
    /// The text to be displayed and edited in the text field.
    @Binding var text: String
    /// The type of keyboard to be displayed when the text field is active.
    var keyBoardType: UIKeyboardType
    
    /// The flag to set the textField secure
    var isSecure: Bool
    
    /// A Coordinator class to act as the delegate for the UITextField.
    class Coordinator: NSObject, UITextFieldDelegate {
        // The parent MITextField instance.
        var parent: MITextField
        
        /// Initializes a new Coordinator with a parent MITextField instance.
        /// - Parameter parent: The parent MITextField instance.
        init(parent: MITextField) {
            self.parent = parent
        }
        
        /// UITextFieldDelegate method to handle text changes.
        /// - Parameters:
        ///   - textField: The UITextField whose text is changing.
        ///   - range: The range of characters to be replaced.
        ///   - string: The replacement string.
        /// - Returns: A Boolean value indicating whether the text should change.
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let newString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
            parent.text = newString
            return false
        }
        
        /// UITextFieldDelegate method to handle the start of text editing.
        /// - Parameter textField: The UITextField that is about to be edited.
        /// - Returns: A Boolean value indicating whether editing should begin.
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            // Disable selection handles
            if let selectedRange = textField.selectedTextRange {
                textField.replace(selectedRange, withText: "")
            }
            return true
        }
    }
    
    /// Creates a new Coordinator instance.
    /// - Returns: A new Coordinator instance.
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    /// Creates a new _MITextField instance.
    /// - Parameter context: The context for creating the UITextField.
    /// - Returns: A new _MITextField instance.
    func makeUIView(context: Context) -> _MITextField {
        let textField = _MITextField()
        textField.isUserInteractionEnabled = true // Allow input
        textField.delegate = context.coordinator
        textField.text = text
        textField.textColor = .clear
        textField.tintColor = .clear
        textField.keyboardType = keyBoardType
        textField.isSecureTextEntry = isSecure
        return textField
    }
    
    /// Updates the _MITextField instance with new data.
    /// - Parameters:
    ///   - uiView: The _MITextField instance to be updated.
    ///   - context: The context for updating the UITextField.
    func updateUIView(_ uiView: _MITextField, context: Context) {
        uiView.text = text
    }
}


extension MITextField.Coordinator {
    /// Method to handle changes in text selection.
    /// - Parameter textField: The UITextField whose selection changed.
    @objc func textFieldDidChangeSelection(_ textField: UITextField) {
        // Disable text selection programmatically
        if let selectedRange = textField.selectedTextRange, selectedRange.isEmpty == false {
            textField.selectedTextRange = nil
        }
    }
}
