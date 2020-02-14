//
//  TransactionHeaderView.swift
//  SwiftUICombineGraphQLApollo
//
//  Created by Oleg Soloviev on 14.02.2020.
//  Copyright © 2020 Oleg Soloviev. All rights reserved.
//

import SwiftUI

struct TransactionHeaderView: View {
    
    var body: some View {
        HStack() {
            Text(String(viewModel.date))
                .foregroundColor(Color.gray)
            Spacer()
            Text(String(viewModel.amount))
                .fontWeight(.medium)
        }
        .padding(16)
    }
    
    init(viewModel: TransactionHeaderViewModel) {
        self.viewModel = viewModel
    }
    
    // Private
    private let viewModel: TransactionHeaderViewModel
}

#if DEBUG
struct TransactionHeaderView_Previews: PreviewProvider {
    typealias AsDaySectionWidget = AllDataQuery.Data.DailyTransactionsFeed.AsDaySectionWidget
    
    static var previews: some View {
        TransactionHeaderView(viewModel:
            TransactionHeaderViewModel(item:
                AsDaySectionWidget(date: "2019-11-19", amount:
                    AsDaySectionWidget.Amount(value: "-123.50", currencyCode: .gbp))))
    }
}
#endif
