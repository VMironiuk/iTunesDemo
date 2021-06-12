import XCTest
import iTunes_Demo

class RemoteMediaLoaderTests: XCTestCase {

    func test_createRemoteMediaLoader_notNilRemoteMediaLoader() {
        let sut = makeSUT()
        XCTAssertNotNil(sut)
    }

    // MARK: - Helpers

    private func makeSUT() -> MediaLoader {
        RemoteMediaLoader()
    }
}
