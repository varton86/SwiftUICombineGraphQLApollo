//
//  TransactionFetcher.swift
//  SwiftUICombineGraphQLApollo
//
//  Created by Oleg Soloviev on 14.02.2020.
//  Copyright © 2020 Oleg Soloviev. All rights reserved.
//

import Foundation
import Combine
import Apollo

enum TransactionError: Error {
    
    case loading(description: String)
}

protocol TransactionFetchable {
    
    typealias DailyTransactionsFeed = AllDataQuery.Data.DailyTransactionsFeed
    
    func fetchTransactions() -> AnyPublisher<[DailyTransactionsFeedItem], TransactionError>
}

class TransactionFetcher {
    
    init(client: ApolloClient = ApolloClient(url: URL(string: "http://localhost:4000")!)) {
        self.client = client
    }
    
    // Private
    private let client: ApolloClient
}

// MARK: - TransactionFetchable
extension TransactionFetcher: TransactionFetchable {
    
    func fetchTransactions() -> AnyPublisher<[DailyTransactionsFeedItem], TransactionError> {
        return client.fetchPublisher(query: AllDataQuery())
            .mapError { error in .loading(description: error.localizedDescription) }
            .map { [weak self] response in
                guard let dailyTransactionsFeed = response.data?.dailyTransactionsFeed?.compactMap({$0}) else { return [] }
                return self?.decode(for: dailyTransactionsFeed) ?? []
        }
        .eraseToAnyPublisher()
    }
    
    // Private
    private func decode(for data: [DailyTransactionsFeed]) -> [DailyTransactionsFeedItem] {
        var items = [DailyTransactionsFeedItem]()
        for item in data {
            if let asDaySectionWidget = item.asDaySectionWidget {
                items.append(DailyTransactionsFeedItem(day: TransactionHeaderViewModel(item: asDaySectionWidget), transactions: []) )
            }
            if let asTransactionWidget = item.asTransactionWidget, !items.isEmpty {
                items[items.count - 1].transactions.append(TransactionRowViewModel(item: asTransactionWidget))
            }
        }
        return items
    }
}
