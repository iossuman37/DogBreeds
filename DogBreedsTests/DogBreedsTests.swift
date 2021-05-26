//
//  DogBreedsTests.swift
//  DogBreedsTests
//
//  Created by Suman Kumar Konakalla on 5/26/21.
//

import XCTest
@testable import DogBreeds

class DogBreedsTests: XCTestCase {

    var breedViewModel : BreedViewModel?
    var expectationForTest : XCTestExpectation?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       
        breedViewModel = BreedViewModel(delegate: self)
       
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBreedList() throws {
        breedViewModel?.fetchBreedsList()
        self.expectationForTest = self.expectation(description: "Fetch Breeds")
        waitForExpectations(timeout: 5, handler: nil)
    }

   
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension DogBreedsTests : DataRequestModelDelegate {
    func onFetchCompleted() {
        XCTAssertTrue((breedViewModel?.breedsCount ?? 0) > 0)
        self.expectationForTest?.fulfill()
    }
    
    func onFetchFailed(with reason: String) {
        XCTAssertTrue(reason.count == 0)
    }
}
