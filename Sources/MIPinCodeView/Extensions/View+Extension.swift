//
//  View+Extension.swift
//  
//
//  Created by Muhammad Ibrar on 05/07/2024.
//

import SwiftUI

/// A view modifier that limits the input length of a `TextField`.
///
/// This modifier ensures that the text entered into the `TextField` does not exceed a specified length.
///
/// - Parameters:
///   - value: A binding to the text value being entered.
///   - length: The maximum allowed length for the text.
extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}
