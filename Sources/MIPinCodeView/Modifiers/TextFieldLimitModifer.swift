//
//  TextFieldLimitModifer.swift
//  
//
//  Created by Muhammad Ibrar on 05/07/2024.
//

import SwiftUI

/// A view modifier that limits the input length of a `TextField`
///
/// This modifier ensures that the text entered into the `TextField` does not exceed a specified length.
/// It listens for changes in the bound text value and truncates it if it exceeds the maximum length.
///
/// - Parameters:
///   - value: A binding to the text value being entered into the `TextField`.
///   - length: The maximum allowed length for the text.
///
/// Example usage:
/// ```
/// TextField("Enter PIN", text: $pin)
///     .modifier(TextFieldLimitModifier(value: $pin, length: 4))
/// ```
struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                // Ensure the text length does not exceed the specified length
                value = String($0.prefix(length))
            }
    }
}
