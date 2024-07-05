//
//  MIPinCodeView.swift
//
//
//  Created by Muhammad Ibrar on 05/07/2024.
//

import SwiftUI

/// Enum representing the style of the PIN code view.
public enum PinStyle {
    case boxed
    case circle
    case underlined
}

/// A SwiftUI view for displaying and interacting with a PIN code input field.
///
/// This view allows users to input a PIN with customizable styles and settings.
///
/// - Parameters:
///   - pin: A binding to the PIN string that is entered by the user.
///   - length: The length of the PIN code. Default is 4.
///   - isSecure: A boolean value indicating whether the PIN should be displayed as secure dots. Default is true.
///   - style: The style of the PIN code display. Options include boxed, circle, or underlined. Default is boxed.
///   - backgroundColor: The background color of each PIN character view. Default is gray.
///   - textColor: The color of the text or dots representing each PIN character. Default is black.
///   - pinCharacter: The pinCharacter of each PIN character view. Default is •
///   - cornerRadius: The corner radius for the boxed style. Default is 8.
///   - spacing: The spacing between the pin value. Default is 10.
///   - width: The width of each PIN character view. Default is 40.
///   - height: The height of each PIN character view. Default is 40.
public struct MIPinCodeView: View {
    @Binding var pin: String
    var length: Int
    var isSecure: Bool
    var style: PinStyle
    var backgroundColor: Color
    var textColor: Color
    var cornerRadius: CGFloat
    var spacing: CGFloat
    var pinCharacter: String
    var width: CGFloat
    var height: CGFloat
    
    public init(pin: Binding<String>,
                length: Int = 4,
                isSecure: Bool = true,
                style: PinStyle = .boxed,
                backgroundColor: Color = .gray,
                textColor: Color = .black,
                pinCharacter: String = "•",
                cornerRadius: CGFloat = 8,
                spacing: CGFloat = 10.0,
                width: CGFloat = 40,
                height: CGFloat = 40) {
        self._pin = pin
        self.length = length
        self.isSecure = isSecure
        self.style = style
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.pinCharacter = pinCharacter
        self.cornerRadius = cornerRadius
        self.spacing = spacing
        self.width = width
        self.height = height
    }
    
    public var body: some View {
        VStack {
            HStack(spacing: spacing) {
                ForEach(0..<length, id: \.self) { index in
                    pinCharacterView(at: index)
                        .frame(width: width, height: height)
                        .background(Color.clear)
                }
            }
            .padding()
            .overlay(
//                TextField("", text: $pin)
//                    .foregroundColor(.clear) // Hide the text field's text color
//                    .accentColor(.clear) // Hide the cursor color
//                    .limitInputLength(value: $pin, length: length) // Limit input length
                
                MITextField(text: $pin)
                    .foregroundColor(.clear) // Hide the text field's text color
                    .accentColor(.clear) // Hide the cursor color
                    .limitInputLength(value: $pin, length: length) // Limit input length
                
            )
        }
    }
    
    /// Creates a view for a single PIN character based on the selected style.
    ///
    /// - Parameter index: The index of the character in the PIN.
    /// - Returns: A view displaying a single PIN character with the appropriate style.
    private func pinCharacterView(at index: Int) -> some View {
        ZStack {
            if style == .boxed {
                Rectangle()
                    .fill(backgroundColor)
                    .cornerRadius(cornerRadius)
            } else if style == .circle {
                Circle()
                    .fill(backgroundColor)
            } else if style == .underlined {
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(backgroundColor)
                        .frame(height: 2)
    
                }
            }
            
            Text(character(at: index))
                .foregroundColor(textColor)
                .font(.system(size: self.height * 2/3))
        }
        
    }
    
    /// Retrieves the character at a specific index in the PIN.
    ///
    /// - Parameter index: The index of the character in the PIN.
    /// - Returns: A string representing the character at the given index.
    private func character(at index: Int) -> String {
        guard index < pin.count else { return "" }
        let startIndex = pin.index(pin.startIndex, offsetBy: index)
        let character = pin[startIndex]
        return isSecure ? self.pinCharacter : String(character)
    }
}

