//
//  MockedDashboardView.swift
//  CloudySunTests
//
//  Created by Andrés Guzmán on 9/11/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation
@testable import CloudySun

final class MockedDashboardView: DashboardView {
    
    enum Invocation: Int {
        case initialization
        case updateUI
        case loadingView
    }
    
    var invocations: [Invocation] = []
    var isLoading: Bool = false
    
    init() {
        invocations.append(.initialization)
    }
    
    func updateUI(with weatherInfo: CSWeather) {
        invocations.append(.updateUI)
    }
    
    func loadingView(_ isLoading: Bool) {
        invocations.append(.loadingView)
        self.isLoading = isLoading
    }
}
