//
//  SceneDelegate.swift
//  SwiftUICombineGraphQLApollo
//
//  Created by Oleg Soloviev on 14.02.2020.
//  Copyright © 2020 Oleg Soloviev. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }

        let fetcher = TransactionFetcher()
        let viewModel = TransactionListViewModel(transactionFetcher: fetcher)
        let transactionListView = TransactionListView(viewModel: viewModel)

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: transactionListView)
        self.window = window
        window.makeKeyAndVisible()
    }

}
