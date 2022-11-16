//
//  LeBonCoinTestTests.swift
//  LeBonCoinTestTests
//
//  Created by dorian cheignon on 10/11/2022.
//

import XCTest
@testable import LeBonCoinTest
final class LeBonCoinTestTests: XCTestCase {

    override class func setUp() {
        super.setUp()
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreationCategory() throws {
        let category = Category.mock()
        XCTAssertEqual(category.id, 1)
        XCTAssertEqual(category.name, "Voiture")
    }
    
    func testCreationClassifiedAd() throws {
        let object = ClassifiedAd.mock()
        assert((object.id as Any) is Int)
        assert((object.title as Any) is String)
        assert((object.category_id as Any) is Int)
        assert((object.creation_date as Any) is String)
        assert((object.desc as Any) is String)
        assert((object.is_urgent as Any) is Bool)
        assert((object.images_url as Any) is ImagesURL)
        assert((object.price as Any) is Float)
        assert((object.siret as Any) is String)

    }
    
    func testCallApi() throws {
        let api = ApiMock()
        api.getCategory { category, error in
            assert(error == nil)
            assert(category!.count > 0 )
        }
        api.getListing { objects, error in
            assert(error == nil)
            assert(objects!.count > 0 )
        }
        let object = ClassifiedAd.mock()
        let expectation = XCTestExpectation(description: "Download Image from URL")
        api.getImageFrom(url: object.images_url.small) { image in
            assert((image as Any) is UIImage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
