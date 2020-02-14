//
//  TransactionListView.swift
//  SwiftUICombineGraphQLApollo
//
//  Created by Oleg Soloviev on 14.02.2020.
//  Copyright © 2020 Oleg Soloviev. All rights reserved.
//

import SwiftUI

struct TransactionListView: View {
    
    @ObservedObject var viewModel: TransactionListViewModel
    
    var body: some View {
        List {
            if viewModel.dataSource.isEmpty {
                emptySection
            } else {
                transactionSection
            }
        }
        .onAppear(perform: viewModel.refresh)
    }
    
    init(viewModel: TransactionListViewModel) {
        self.viewModel = viewModel
        
        UITableView.appearance().separatorStyle = .none
    }
}

private extension TransactionListView {
    
    var transactionSection: some View {
        ForEach(viewModel.dataSource) { section in
            VStack(alignment: .leading) {
                TransactionHeaderView(viewModel: section.day)
                ForEach(section.transactions) { transaction in
                    TransactionRowView(viewModel: transaction)
                }
            }
            ExDivider()
        }
    }
    
    var emptySection: some View {
        Section {
            Text("No Data")
                .foregroundColor(.gray)
        }
    }
}

struct ExDivider: View {
    let color: Color = .blue
    let opacity: Double = 0.05
    let height: CGFloat = 9
    
    var body: some View {
        Rectangle()
            .fill(color)
            .opacity(opacity)
            .frame(height: height)
            .listRowInsets(EdgeInsets())
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(viewModel: TransactionListViewModel(transactionFetcher: TransactionFetcher()))
    }
}
#endif
