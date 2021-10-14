//
//  RxSwift_SidedishesTests.swift
//  RxSwift_SidedishesTests
//
//  Created by 박정하 on 2021/08/17.
//

import XCTest
import RxSwift

@testable import RxSwift_Sidedishes

final class SessionManagerStub: URLSessionProtocol {
    
    var request: URLRequest?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.request = request
        return MockSessionDataTask.init()
    }
}

class MockSessionDataTask: URLSessionDataTask {
    override init() {
        
    }
    
    override func resume() {
        
    }
}

class RxSwift_SidedishesTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
    
    }

    func testExample() throws {
    
    }

    func test올바른_네트워크_리퀘스트를_만들었는가() {
        //given
        let sessionManager = SessionManagerStub()
        let service = APIService.init(urlSessionManager: sessionManager, apiMaker: APIMaker())
        //when
        service.fetchDataWithSession(usecase: .main, onComplete: { _ in })
        //then
        let request = sessionManager.request
        let testURL = EndPoint().createValidURL(path: )
        XCTAssertEqual(request, service.createRequest(url: testURL))
    }
    
    func test뷰_모델의_로직은_올바른가() {
        //given
        let apiService = APIService.init(urlSessionManager: URLSession.shared, apiMaker: EndpointStub.init())
        let coordinator = SceneCoordinator.init(window: UIWindow.init())
        let repo = BanchanRepository.init(apiService: apiService)
        let viewModel = BanchanListViewModel.init(sceneCoordinator: coordinator, storage: repo)
        
        let decodedData = DecodedData.init(decoder: JSONDecoder())
        let result: [BanchanSection] = decodedData.testData()
        let promise = expectation(description: "성공!")
        
        //when
        viewModel.banchanList
            .subscribe() { emitter in
                XCTAssertEqual(emitter.element, result)
                promise.fulfill()
            }.disposed(by: rx.disposeBag)
        
        wait(for: [promise], timeout: 5)
        //then
    }
    
    func testPerformanceExample() throws {
        measure {
            
        }
    }

}
