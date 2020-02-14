//
//  Models.swift
//  SwiftUICombineGraphQLApollo
//
//  Created by Oleg Soloviev on 14.02.2020.
//  Copyright © 2020 Oleg Soloviev. All rights reserved.
//

import Foundation

struct DailyTransactionsFeedItem: Identifiable  {
    
    let id = UUID()
    let day: TransactionHeaderViewModel
    var transactions: [TransactionRowViewModel]
}
