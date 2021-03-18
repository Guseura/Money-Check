//
//  StatusViewModel.swift
//  moneycheck
//
//  Created by Yurij Goose on 21.01.21.
//

import Foundation
import SwiftUI

class StatusViewModel: ObservableObject {
    
    @Published private(set) var error: String? = nil
    @Published private(set) var success: String? = nil
    @Published private(set) var loading: Bool = false
    
    public func setError(to error: Error?) {
        withAnimation {
            self.showError = error != nil
            self.showLoading = false
            self.error = error?.localizedDescription
        }
        if error != nil {
            hapticFeedback(.error)
        }
    }
    
    public func setSuccess(to success: String?) {
        withAnimation {
            self.showSuccess = success != nil
            self.showLoading = false
            self.success = success
        }
        if success != nil {
            hapticFeedback(.success)
        }
    }
    
    public func setLoading(to loading: Bool) {
        withAnimation {
            self.showLoading = loading
            self.loading = loading
        }
    }
    
    @Published var showError: Bool = false {
        didSet {
            if showError == false {
                self.error = nil
            }
        }
    }
    
    @Published var showSuccess: Bool = false {
        didSet {
            if showSuccess == false {
                self.success = nil
            }
        }
    }
    
    @Published var showLoading: Bool = false {
        didSet {
            loading = showLoading
        }
    }
    
}
