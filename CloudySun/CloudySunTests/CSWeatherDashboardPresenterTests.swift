//
//  CSWeatherDashboardPresenterTests.swift
//  CloudySunTests
//
//  Created by Andrés Guzmán on 9/11/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import XCTest
@testable import CloudySun

class CSWeatherDashboardPresenterTests: XCTestCase {

    var sut: CSWeatherDashboardPresenter!
    var mockedService: MockedWeatherService!
    var mockedRepository: MockedRepository!
    var mockedDashboardView: MockedDashboardView!
    
    override func setUp() {
        super.setUp()
        mockedService = MockedWeatherService()
        mockedRepository = MockedRepository()
        mockedDashboardView = MockedDashboardView()
        sut = CSWeatherDashboardPresenter(repository: mockedRepository, service: mockedService)
        sut.view = mockedDashboardView
    }

    override func tearDown() {
        sut = nil
        mockedRepository = nil
        mockedService = nil
        mockedDashboardView = nil
        super.tearDown()
    }
    
    func testLoadWeatherDataSucceeds_ViewUpdatesSuccesfully() {
        // When
        sut.loadWeatherData()
        let expectedViewInvocations: [MockedDashboardView.Invocation] = [.initialization, .loadingView, .updateUI, .loadingView]
        let expectedServiceInvocations: [MockedWeatherService.Invocation] = [.initialization, .getForecast]
        let expectedRepoInvocations: [MockedRepository.Invocation] = [.initialization, .saveCacheData]
        
        // Then
        XCTAssertEqual(expectedViewInvocations, mockedDashboardView.invocations, "Invocations should match")
        XCTAssertEqual(expectedServiceInvocations, mockedService.invocations, "Invocations should match")
        XCTAssertEqual(expectedRepoInvocations, mockedRepository.invocations, "Invocations should match")
    }
    
    func testLoadWeatherDataFails_FailureFlowTriggered() {
        // Given
        mockedService.serviceResponse = .failure
        mockedRepository.mockedResponse = .failure
        
        // When
        sut.loadWeatherData()
        let expectedViewInvocations: [MockedDashboardView.Invocation] = [.initialization, .loadingView, .loadingView]
        let expectedServiceInvocations: [MockedWeatherService.Invocation] = [.initialization, .getForecast]
        let expectedRepoInvocations: [MockedRepository.Invocation] = [.initialization, .listForecast]
        
        // Then
        XCTAssertEqual(expectedViewInvocations, mockedDashboardView.invocations, "Invocations should match")
        XCTAssertEqual(expectedServiceInvocations, mockedService.invocations, "Invocations should match")
        XCTAssertEqual(expectedRepoInvocations, mockedRepository.invocations, "Invocations should match")
    }
    
    func testSaveDataFails_UseCaseFails() {
        // Given
        mockedRepository.saveStatus = .failure
        
        // When
        sut.loadWeatherData()
        let expectedViewInvocations: [MockedDashboardView.Invocation] = [.initialization, .loadingView, .loadingView]
        let expectedServiceInvocations: [MockedWeatherService.Invocation] = [.initialization, .getForecast]
        let expectedRepoInvocations: [MockedRepository.Invocation] = [.initialization, .saveCacheData]
        
        // Then
        XCTAssertEqual(expectedViewInvocations, mockedDashboardView.invocations, "Invocations should match")
        XCTAssertEqual(expectedServiceInvocations, mockedService.invocations, "Invocations should match")
        XCTAssertEqual(expectedRepoInvocations, mockedRepository.invocations, "Invocations should match")
    }
    
    func testGetCacheDataSucceeds_ViewUpdatesOk() {
        // Given
        mockedService.serviceResponse = .failure
        mockedRepository.mockedResponse = .success(weatherInfo: Mocks.mockedWeather)
        
        // When
        sut.loadWeatherData()
        let expectedViewInvocations: [MockedDashboardView.Invocation] = [.initialization, .loadingView, .updateUI, .loadingView]
        let expectedServiceInvocations: [MockedWeatherService.Invocation] = [.initialization, .getForecast]
        let expectedRepoInvocations: [MockedRepository.Invocation] = [.initialization, .listForecast]
        
        // Then
        XCTAssertEqual(expectedViewInvocations, mockedDashboardView.invocations, "Invocations should match")
        XCTAssertEqual(expectedServiceInvocations, mockedService.invocations, "Invocations should match")
        XCTAssertEqual(expectedRepoInvocations, mockedRepository.invocations, "Invocations should match")
    }
    
    func testCacheResponseIsNil_UseCaseFails() {
        // Given
        mockedService.serviceResponse = .failure
        mockedRepository.mockedResponse = nil
        
        // When
        sut.loadWeatherData()
        let expectedViewInvocations: [MockedDashboardView.Invocation] = [.initialization, .loadingView, .loadingView]
        let expectedServiceInvocations: [MockedWeatherService.Invocation] = [.initialization, .getForecast]
        let expectedRepoInvocations: [MockedRepository.Invocation] = [.initialization, .listForecast]
        
        // Then
        XCTAssertEqual(expectedViewInvocations, mockedDashboardView.invocations, "Invocations should match")
        XCTAssertEqual(expectedServiceInvocations, mockedService.invocations, "Invocations should match")
        XCTAssertEqual(expectedRepoInvocations, mockedRepository.invocations, "Invocations should match")
    }
    
}
