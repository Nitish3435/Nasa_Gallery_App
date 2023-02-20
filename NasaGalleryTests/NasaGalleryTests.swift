//
//  NasaGalleryTests.swift
//  NasaGalleryTests
//
//  Created by Nitish Kumar on 18/02/23.
//

import XCTest
@testable import NasaGallery

final class NasaGalleryTests: XCTestCase {
    var sut: GalleryUseCase! // System under Test
    override func setUpWithError() throws {
        sut = GalleryUseCase(galleryRepository: GalleryRepositoryImplementation())
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    func testAPIStatus() {
        let expectation = XCTestExpectation(description: "Check API status")

        sut.checkApiStatus { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 200)
            case .failure(let error):
                XCTFail("Error checking API status: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
