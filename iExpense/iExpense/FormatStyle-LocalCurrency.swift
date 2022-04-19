//
//  FormatStyle-LocalCurrency.swift
//  iExpense
//
//  Created by David Evans on 19/4/2022.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
}
