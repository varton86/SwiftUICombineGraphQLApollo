//
//  Utilities.swift
//  SwiftUICombineGraphQLApollo
//
//  Created by Oleg Soloviev on 14.02.2020.
//  Copyright © 2020 Oleg Soloviev. All rights reserved.
//

import Foundation

let dayFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "dd"
  return formatter
}()

let monthFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "MMMM"
  return formatter
}()

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()


func dateReader(date: String) -> String {
    guard let date = dateFormatter.date(from: date) else { return "" }
    return "\(monthFormatter.string(from: date)), \(dayFormatter.string(from: date))"
}

func currencyReader(amount: String, currency: CurrencyCode) -> String {
    guard let currencySymbol = getSymbolForCurrencyCode(code: currency.rawValue), let doubleAmount = Double(amount) else { return amount }
    let sign = doubleAmount < 0 ? "-" : ""
    return "\(sign)\(currencySymbol)\(abs(doubleAmount))"
}

func getSymbolForCurrencyCode(code: String) -> String? {
    let result = Locale.availableIdentifiers.map { Locale(identifier: $0) }.first { $0.currencyCode == code }
    return result?.currencySymbol
}
