//
//  TransactionHeaderViewModel.swift
//  SwiftUICombineGraphQLApollo
//
//  Created by Oleg Soloviev on 14.02.2020.
//  Copyright © 2020 Oleg Soloviev. All rights reserved.
//

import SwiftUI

struct TransactionHeaderViewModel {
    
    var date: String {
        return dateReader(date: item.date)
    }
    
    var amount: String {
        return currencyReader(amount: item.amount.value, currency: item.amount.currencyCode)
    }
    
    init(item: AllDataQuery.Data.DailyTransactionsFeed.AsDaySectionWidget) {
        self.item = item
    }
    
    // Private
    private let item: AllDataQuery.Data.DailyTransactionsFeed.AsDaySectionWidget
}
