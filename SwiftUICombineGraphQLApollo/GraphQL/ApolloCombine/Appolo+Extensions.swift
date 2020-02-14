//
//  Appolo+Extensions.swift
//  SwiftUICombineGraphQLApollo
//
//  Created by Oleg Soloviev on 14.02.2020.
//  Copyright © 2020 Oleg Soloviev. All rights reserved.
//

import Apollo

extension ApolloClient {

    func fetchPublisher<Query: GraphQLQuery>(query: Query) -> GraphQLQueryPublisher<Query> {
        return GraphQLQueryPublisher(client: self, query: query)
    }
}
