//
//  TransactionRowView.swift
//  SwiftUICombineGraphQLApollo
//
//  Created by Oleg Soloviev on 14.02.2020.
//  Copyright © 2020 Oleg Soloviev. All rights reserved.
//

import SwiftUI

struct TransactionRowView: View {
    
    var body: some View {
        HStack() {
            ZStack {
                if viewModel.type == .cashback {
                    Constants.cashbackColor
                        .frame(width: 64, height: 64)
                        .cornerRadius(26.0)
                } else {
                    Constants.regularColor
                        .frame(width: 64, height: 64)
                        .cornerRadius(26.0)
                }
                Image(viewModel.type == .cashback ? Constants.cashback : viewModel.image)
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            Text(String(viewModel.title))
                .fontWeight(.light)
                .padding(.leading, 16)
            Spacer()
            Text(String(viewModel.amount))
                .fontWeight(.light)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(viewModel.type == .cashback ? Constants.cashbackColor : Color.white)
        .cornerRadius(12.0)
    }
    
    init(viewModel: TransactionRowViewModel) {
        self.viewModel = viewModel
    }
    
    // Private
    private let viewModel: TransactionRowViewModel
    private enum Constants {
        static let cashback = "cashback"
        static let cashbackColor = Color(red: 239.0/255.0, green: 250.0/255.0, blue: 230.0/255.0)
        static let regularColor = Color(red: 234.0/255.0, green: 240.0/255.0, blue: 246.0/255.0)
    }
}

#if DEBUG
struct TransactionRowView_Previews: PreviewProvider {
    typealias AsTransactionWidget = AllDataQuery.Data.DailyTransactionsFeed.AsTransactionWidget
    
    static var previews: some View {
        TransactionRowView(viewModel:
            TransactionRowViewModel(item:
                AsTransactionWidget(transaction:
                    AsTransactionWidget.Transaction(id: "1", title: "Nando's", amount:
                        AsTransactionWidget.Transaction.Amount(value: "-25.20", currencyCode: .gbp), type: .regular))))
    }
}
#endif
