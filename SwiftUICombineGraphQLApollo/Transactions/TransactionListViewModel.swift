//
//  TransactionListViewModel.swift
//  SwiftUICombineGraphQLApollo
//
//  Created by Oleg Soloviev on 14.02.2020.
//  Copyright © 2020 Oleg Soloviev. All rights reserved.
//

import SwiftUI
import Combine

class TransactionListViewModel: ObservableObject {
    
    @Published var dataSource = [DailyTransactionsFeedItem]()
    
    init(transactionFetcher: TransactionFetchable) {
        self.transactionFetcher = transactionFetcher
    }
    
    func refresh() {
        transactionFetcher
            .fetchTransactions()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.dataSource = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] transactions in
                    guard let self = self else { return }
                    self.dataSource = transactions
            })
            .store(in: &disposables)
    }
    
    // Private
    private let transactionFetcher: TransactionFetchable
    private var disposables = Set<AnyCancellable>()
}
