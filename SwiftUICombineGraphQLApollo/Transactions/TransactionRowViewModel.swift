//
//  TransactionRowViewModel.swift
//  SwiftUICombineGraphQLApollo
//
//  Created by Oleg Soloviev on 14.02.2020.
//  Copyright © 2020 Oleg Soloviev. All rights reserved.
//

import SwiftUI

struct TransactionRowViewModel: Identifiable {
    
    var id: String {
        return item.transaction.id
    }
    
    var type: TransactionType {
        return item.transaction.type
    }
    
    var title: String {
        return item.transaction.title
    }
    
    var amount: String {
        return currencyReader(amount: item.transaction.amount.value, currency: item.transaction.amount.currencyCode)
    }
    
    var image: String {
        return item.image?.iconName ?? "placeholder"
    }
    
    init(item: AllDataQuery.Data.DailyTransactionsFeed.AsTransactionWidget) {
        self.item = item
    }
    
    // Private
    private let item: AllDataQuery.Data.DailyTransactionsFeed.AsTransactionWidget
}
