//
//  Subscription.swift
//  SwiftUICombineGraphQLApollo
//
//  Created by Oleg Soloviev on 14.02.2020.
//  Copyright © 2020 Oleg Soloviev. All rights reserved.
//

import Foundation
import Combine
import Apollo

final class GraphQLQuerySubscription<GraphQuery: GraphQLQuery, SubscriberType: Subscriber>: Subscription where SubscriberType.Input == GraphQLResult<GraphQuery.Data>, SubscriberType.Failure == Error {
    
    private let subscriber: SubscriberType
    private var cancellable: Apollo.Cancellable?
    
    init(client: ApolloClient, query: GraphQuery, subscriber: SubscriberType) {
        self.subscriber = subscriber
        self.cancellable = client.fetch(query: query,
                                        resultHandler: self.handle)
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func request(_ demand: Subscribers.Demand) { }
    
    func cancel() {
        cancellable?.cancel()
        cancellable = nil
    }
    
    func handle(result: Result<GraphQLResult<GraphQuery.Data>, Error>) {
        switch result {
        case .success(let resultSet):
            _ = subscriber.receive(resultSet)
        case .failure(let error):
            subscriber.receive(completion: .failure(error))
        }
        subscriber.receive(completion: .finished)
    }
}
