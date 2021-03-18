//
//  AddRecordViewModel.swift
//  moneycheck
//
//  Created by Yurij Goose on 24.01.21.
//

import Foundation
import Firebase

class AddRecordViewModel: ObservableObject {
    
    @Published var showNumpad = true
    
    @Published var transactionType = 0 {
        didSet {
            if chosenAccount == Account.transfer {
                isAccountChosen = false
                chosenAccount = nil
            }
            isDestAccountChosen = false
            chosenDestAccount = nil
        }
    }
    
    @Published var currency = "EUR"
    
    @Published var isCategoryChosen = false
    @Published var isDestAccountChosen = false
    @Published var isAccountChosen = false
    
    @Published var showAccounts = false
    @Published var showDestAccounts = false
    @Published var showCategories = false
    @Published var showLabels = false
    
    @Published var chosenAccount: Account? = nil
    @Published var chosenDestAccount: Account? = nil
    @Published var chosenCategory: Category? = nil
    @Published var chosenDate: Date = Date()
    @Published var chosenLabels: [[Label]] = []
    
    @Published var showNoteField: Bool = false
    @Published var note: String = ""
    

    func isAllowed() -> Bool {
        if transactionType == 2 {
            if isAccountChosen && chosenAccount != nil && isDestAccountChosen && chosenDestAccount != nil && calcucationText != "0" {
                return true
            } else {
                return false
            }
        } else {
            if isCategoryChosen && chosenCategory != nil && isAccountChosen && chosenAccount != nil && calcucationText != "0" {
                return true
            } else {
                return false
            }
        }
    }
    
    func createTransaction() -> Transaction {

        let type: TransactionType = transactionType == 0 ? .spend : transactionType == 1 ? .income : .transfer

        return Transaction(id: UUID().uuidString,
                           amount: Double(calcucationText) ?? result,
                           type: type,
                           date: Timestamp(date: chosenDate),
                           categoryId: type != .transfer ? chosenCategory!.id : "",
                           accountId: chosenAccount!.id,
                           destAccountId: type == .transfer ? chosenDestAccount!.id : "",
                           labelIds: chosenLabels.map({ $0.map({ $0.id }) }).first ?? [],
                           currency: currency,
                           note: note)
    }
    
    // MARK: - Calculator
    
    @Published var calcucationText: String = "0"
    @Published var enteredValue: String = ""
    
    private let decimal: String = "."
    private let plus: Character = "+"
    private let minus: Character = "-"
    private let multiply: Character = "×"
    private let divide: Character = "÷"
    
    private var result: Double = 0
    private var lastResult: Double = 0
    private var lastSelectedOperation: NumpadOperation?
    
    
    let buttons: [[NumpadButton]] = [
        [
            NumpadButton(type: .number("7")),
            NumpadButton(type: .number("8")),
            NumpadButton(type: .number("9")),
        ],
        [
            NumpadButton(type: .number("4")),
            NumpadButton(type: .number("5")),
            NumpadButton(type: .number("6")),
        ],
        [
            NumpadButton(type: .number("1")),
            NumpadButton(type: .number("2")),
            NumpadButton(type: .number("3")),
        ],
        [
            NumpadButton(type: .number(".")),
            NumpadButton(type: .number("0")),
            NumpadButton(type: .delete("delete.left")),
        ]
    ]
    
    let toolBarButtons: [NumpadButton] = [
        NumpadButton(type: .operation(NumpadOperation.add.rawValue)),
        NumpadButton(type: .operation(NumpadOperation.sub.rawValue)),
        NumpadButton(type: .operation(NumpadOperation.mult.rawValue)),
        NumpadButton(type: .operation(NumpadOperation.div.rawValue))
    ]
    
    
    func buttonTapped(button: NumpadButton) {
        
        var currentValue: Double = 0
        
        
        switch button.type {
        
        case .number(let key):
            
            if enteredValue == "" {
                if key == decimal {
                    enteredValue.append("0" + self.decimal)
                } else {
                    enteredValue = key
                }
            } else {
                if currentValue.truncatingRemainder(dividingBy: 1) != 0 {
                    if key != decimal {
                        enteredValue.append(key)
                    }
                } else {
                    enteredValue.append(key)
                }
            }
            
            
            if let doubleValue = Double(enteredValue) {
                currentValue = doubleValue
                self.result = currentValue
            } else {
                
                let lastOperactionIndex = getLastOperationIndex()
                let indexAfterLastOperation = enteredValue.index(after: lastOperactionIndex!)
                let valueAfterLastOparation = enteredValue.suffix(from: indexAfterLastOperation)
                
                currentValue = Double(valueAfterLastOparation) ?? 0
                
                if let lastSelectedOperation = self.getLastOparation() {
                    switch lastSelectedOperation {
                    case .add:
                        self.result = lastResult + currentValue
                    case .div:
                        ()
                        self.result = lastResult / currentValue
                    case .mult:
                        ()
                        self.result = lastResult * currentValue
                    case .sub:
                        ()
                        self.result = lastResult - currentValue
                    }
                }
            }
            
        case .operation(let key):
            
            if let operation = NumpadOperation(rawValue: key), enteredValue != "" {
                
                self.lastResult = self.result
                
                switch operation {
                case .add:
                    if enteredValue.last != plus {
                        if enteredValue.last == minus || enteredValue.last == multiply || enteredValue.last == divide {
                            enteredValue = String(enteredValue.dropLast()) + String(plus)
                        } else {
                            enteredValue.append(plus)
                        }
                    }
                case .div:
                    if enteredValue.last != divide {
                        if enteredValue.last == minus || enteredValue.last == multiply || enteredValue.last == plus {
                            enteredValue = String(enteredValue.dropLast()) + String(divide)
                        } else {
                            enteredValue.append(divide)
                        }
                    }
                case .mult:
                    if enteredValue.last != multiply {
                        if enteredValue.last == minus || enteredValue.last == plus || enteredValue.last == divide {
                            enteredValue = String(enteredValue.dropLast()) + String(multiply)
                        } else {
                            enteredValue.append(multiply)
                        }
                    }
                case .sub:
                    if enteredValue.last != minus {
                        if enteredValue.last == plus || enteredValue.last == multiply || enteredValue.last == divide {
                            enteredValue = String(enteredValue.dropLast()) + String(minus)
                        } else {
                            enteredValue.append(minus)
                        }
                    }
                }
                
                currentValue = 0
                
            }
        case .delete:
            
            if Double(enteredValue) != nil {
                enteredValue = String(enteredValue.dropLast())
                currentValue = Double(enteredValue) ?? 0
                self.result = currentValue
            } else {
                
                currentValue = getCurrentValueIfOperation()
                
                if let lastSelectedOperation = getLastOparation(), currentValue != 0 {
                    
                    switch lastSelectedOperation {
                    case .add:
                        self.result -= currentValue
                        enteredValue = String(enteredValue.dropLast())
                        if getCurrentValueIfOperation() != 0 {
                            self.result += getCurrentValueIfOperation()
                        }
                    case .div:
                        self.result *= currentValue
                        enteredValue = String(enteredValue.dropLast())
                        if getCurrentValueIfOperation() != 0 {
                            self.result /= getCurrentValueIfOperation()
                        }
                    case .mult:
                        self.result /= currentValue
                        enteredValue = String(enteredValue.dropLast())
                        if getCurrentValueIfOperation() != 0 {
                            self.result *= getCurrentValueIfOperation()
                        }
                    case .sub:
                        self.result += currentValue
                        enteredValue = String(enteredValue.dropLast())
                        if getCurrentValueIfOperation() != 0 {
                            self.result -= getCurrentValueIfOperation()
                        }
                    }
                    
                    
                }
                
                
                self.lastResult = self.result
                
                if currentValue == 0 {
                    enteredValue = String(enteredValue.dropLast())
                }
                
            }
            
            if enteredValue == "" {
                self.result = 0
                self.lastResult = 0
            }
            
        }
        
        updateDisplayText(result)
        
        //        print("Entered value: \(enteredValue)")
        //        print("Last result: \(lastResult)")
        //        print("Current value: \(currentValue)")
        //        print("Result: \(result)")
        //        print("Last operation: \(getLastOparation())")
        //        print("-----------------------------------")
    }
    
    func getCurrentValueIfOperation() -> Double {
        
        let lastOperactionIndex = getLastOperationIndex()
        var valueAfterLastOparation: Substring = ""
        
        if enteredValue == "" {
            valueAfterLastOparation = enteredValue.suffix(from: lastOperactionIndex!)
        } else {
            let indexAfterLastOperation = enteredValue.index(after: lastOperactionIndex!)
            valueAfterLastOparation = enteredValue[indexAfterLastOperation...]
        }
        
        return Double(valueAfterLastOparation) ?? 0
    }
    
    func getLastOparation() -> NumpadOperation? {
        let lastOpIndex = getLastOperationIndex()
        
        switch lastOpIndex {
        case enteredValue.lastIndex(of: minus):
            return NumpadOperation.sub
        case enteredValue.lastIndex(of: plus):
            return NumpadOperation.add
        case enteredValue.lastIndex(of: divide):
            return NumpadOperation.div
        case enteredValue.lastIndex(of: multiply):
            return NumpadOperation.mult
        case .none:
            return nil
        case .some(_):
            return nil
        }
    }
    
    func getFirstOperationIndex() -> String.Index? {
        return [
            enteredValue.firstIndex(of: minus) ?? enteredValue.startIndex,
            enteredValue.firstIndex(of: plus) ?? enteredValue.startIndex,
            enteredValue.firstIndex(of: divide) ?? enteredValue.startIndex,
            enteredValue.firstIndex(of: multiply) ?? enteredValue.startIndex
        ].min()
    }
    
    func getLastOperationIndex() -> String.Index? {
        return [
            enteredValue.lastIndex(of: minus) ?? enteredValue.startIndex,
            enteredValue.lastIndex(of: plus) ?? enteredValue.startIndex,
            enteredValue.lastIndex(of: divide) ?? enteredValue.startIndex,
            enteredValue.lastIndex(of: multiply) ?? enteredValue.startIndex
        ].max()
    }
    
    func updateDisplayText(_ value: Double) {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            self.calcucationText = String(format: "%.0f", value)
        } else {
            self.calcucationText = String(format: "%.2f", value)
        }
    }
    
}


enum NumpadButtonType {
    case number(String)
    case operation(String)
    case delete(String)
    
    var title: String {
        switch self {
        case .number(let key), .operation(let key), .delete(let key):
            return key
        }
    }
}

enum NumpadOperation: String {
    case add = "plus"
    case sub = "minus"
    case mult = "multiply"
    case div = "divide"
}

struct NumpadButton {
    let type: NumpadButtonType
    
}
