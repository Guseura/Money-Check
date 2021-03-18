//
//  MCErrors.swift
//  MoneyCheck
//
//  Created by Yurij Goose on 02.02.21.
//

import Foundation

enum MCError {
    case AuthError
}

enum AuthError: LocalizedError {
    case allFieldsRequired
    case passwordsDoNotMatch
}

extension AuthError {
    public var errorDescription: String? {
        switch self {
        case .allFieldsRequired:
            return NSLocalizedString("ERROR_ALL_FIELDS_REQUIRED", comment: "")
        case .passwordsDoNotMatch:
            return NSLocalizedString("ERROR_PASSWORDS_DO_NOT_MATCH", comment: "")
        }
    }
}
