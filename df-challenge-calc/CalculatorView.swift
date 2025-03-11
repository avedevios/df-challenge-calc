import SwiftUI

class CalculatorWrapper: ObservableObject {
    private let calculator = CalculatorObjC()

    func inputNumber(_ number: Double) {
        calculator.inputNumber(number)
    }

    func setOperation(_ operation: String) {
        calculator.setOperation(operation)
    }

    func calculate() -> Double {
        return calculator.calculate()
    }
    
    func calculateTrigonometric() -> Double {
        return calculator.calculateTrigonometric()
    }

    func clear() {
        calculator.clear()
    }
}

struct CalculatorView: View {
    @StateObject private var calculatorProcessor = CalculatorWrapper()
    
    @State private var display = "0"
    @State private var operationDisplay = ""
    @State private var firstNumber: Double? = nil
    @State private var operation: String? = nil
    @State private var isTypingNumber = false
    @State private var operationCompleted = false
    @State private var showOperationDisplay = false
    @State private var pointUsed = false
    @State private var operationUsed = false
    
    let buttons: [[String]] = [
        ["sin", "cos", "tan", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["C", "0", ".", "="]
    ]
    
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea(edges: .all)
            GeometryReader { geometry in
                let isLandscape = geometry.size.width > geometry.size.height
                let buttonHeight = isLandscape ? geometry.size.height / 10 - 10 : 80
                let buttonWidth = isLandscape ? geometry.size.width / 4 - 10 : 80
                let displayTextSize: CGFloat = isLandscape ? 40 : 60
                let buttonFont = isLandscape ? Font.title : Font.largeTitle

                VStack(spacing: 10) {
                    Spacer()
                    if showOperationDisplay {
                        Text(operationDisplay)
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding([.leading, .trailing])
                            .foregroundColor(.gray)
                    }
                    Text(display)
                        .font(.system(size: displayTextSize))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                        .foregroundColor(.white)
                    
                    ForEach(buttons, id: \.[0]) { row in
                        HStack(spacing: 10) {
                            ForEach(row, id: \.self) { button in
                                Button(action: {
                                    self.buttonTapped(button)
                                }) {
                                    Text(button)
                                        .font(buttonFont)
                                        .frame(width: buttonWidth, height: buttonHeight)
                                        .foregroundColor(.white)
                                        .background(self.buttonColor(button: button))
                                        .cornerRadius(buttonHeight / 2)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    func buttonColor(button: String) -> Color {
        if ["+", "-", "×", "÷", "="].contains(button) {
            return Color.orange
        } else if ["sin", "cos", "tan"].contains(button) {
            return Color.gray.opacity(0.5)
        } else {
            return Color.gray.opacity(0.2)
        }
    }
    
    func formatResult(_ value: Double) -> String {
        let formatted = String(format: "%g", value)
        return formatted
    }
    
    func buttonTapped(_ button: String) {
        if operationCompleted && button != "=" && button != "C" {
            display = ""
            operationDisplay = ""
            
            showOperationDisplay = false
            operationCompleted = false
        }
        
        switch button {
        case "0"..."9":
            if isTypingNumber {
                display += button
                operationDisplay += button
            } else {
                if operation != nil {
                    display += button
                    operationDisplay += button
                } else {
                    display = button
                    operationDisplay = operationDisplay.isEmpty ? button : operationDisplay + button
                }
                isTypingNumber = true
            }
        case ".":
            if !pointUsed {
                display += button
                operationDisplay += button
                
                pointUsed = true
            }
        case "+", "-", "×", "÷":
            if !isTypingNumber || operationUsed { return }
           
            firstNumber = Double(display)
            operation = button
            display = display + " " + button + " "
            operationDisplay = display
            
            isTypingNumber = false
            showOperationDisplay = false
            pointUsed = false
            operationUsed = true
            
        case "sin", "cos", "tan":
            if let number = Double(display) {
                var result: Double = 0
                switch button {
                case "sin": result = sin(number)
                case "cos": result = cos(number)
                case "tan": result = tan(number)
                default: break
                }
                display = formatResult(result)
                operationDisplay = button + "(" + formatResult(number) + ")"
                
                operationCompleted = true
                showOperationDisplay = true
            }
        case "=":
            if let firstNumber = firstNumber, let operation = operation, let secondNumber = Double(display.split(separator: " ").last ?? "") {
                
                var result: Double = 0
                calculatorProcessor.inputNumber(firstNumber)
                calculatorProcessor.setOperation(operation)
                calculatorProcessor.inputNumber(secondNumber)
                result = calculatorProcessor.calculate()
                calculatorProcessor.clear()
 
                display = secondNumber != 0 ? formatResult(result) : "Error"
                
                operationCompleted = true
                showOperationDisplay = true
                pointUsed = false
                operationUsed = false
                
            }
            isTypingNumber = false
        case "C":
            display = "0"
            operationDisplay = ""
            firstNumber = nil
            operation = nil
            
            isTypingNumber = false
            operationCompleted = false
            showOperationDisplay = false
            pointUsed = false
            operationUsed = false
        default: break
        }
    }
}

struct ContentView: View {
    var body: some View {
        CalculatorView()
    }
}

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#Preview {
    CalculatorView()
}
