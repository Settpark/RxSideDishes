//
//  RxSwift_SidedishesTests.swift
//  RxSwift_SidedishesTests
//
//  Created by 박정하 on 2021/08/17.
//

import XCTest
import RxTest
import RxSwift
@testable import Alamofire

@testable import RxSwift_Sidedishes

final class SessionManagerStub: URLSessionProtocol {
    
    var request: URLRequest?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.request = request
        return MockSessionDataTask.init()
    }
}

//final class URLSessionStub: URLSessionProtocol {
//
//    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        let file = try! Bundle.main.path(forResource: "test", ofType: "json")
//        let data = try! Data(contentsOf: file!)
//        completionHandler(data, nil, nil)
//        return MockSessionDataTask.init()
//    }
//
//}

final class ApiServiceStub: APIServiceType {
    func fetchDataWithSession(apiMaker: APIMakerType, onComplete: @escaping (Result<Banchans, Error>) -> Void) {
        
    }
    
    func fetchDataWithRx(apiMaker: APIMakerType) -> Observable<[Banchan]> {
        <#code#>
    }
    


    func fetchDataWithSession(apiMaker: APIMaker, onComplete: @escaping (Result<Banchans, Error>) -> Void) {
        let request = try! URLRequest(url: URL(string: "URL")!)
        self.urlSessionStub.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()
            let result = try! decoder.decode(Banchans.self, from: data!)
            onComplete(.success(result))
        }
    }

    func fetchDataWithRx(apiMaker: APIMaker) -> Observable<[Banchan]> {
        return Observable.create { [weak self] emmiter in
            self?.fetchDataWithSession(apiMaker: apiMaker) { result in
                switch result {
                case .success(let data):
                    emmiter.onNext(data.body)
                    emmiter.onCompleted()
                case .failure(let error):
                    emmiter.onError(error)
                }
            }
            return Disposables.create()
        }
    }


    let urlSessionStub: URLSessionProtocol

    init(urlSessionStub: URLSessionProtocol) {
        self.urlSessionStub = urlSessionStub
    }
}

class MockSessionDataTask: URLSessionDataTask {
    override init() {
        
    }
    
    override func resume() {
        
    }
}

final class repositoryStub: BanchanStorageType {
    
    var apiService: APIServiceType
    
    init(apiService: APIServiceType) {
        self.apiService = apiService
    }
    
    func banchanList(usecase: BanchanUsecase) -> Observable<[Banchan]> {
        return apiService.fetchDataWithRx(apiMaker: APIMaker(path: usecase))
    }
    
    func orderBanchan() -> Observable<Banchan> {
        return Observable.just(Banchan.empty)
    }
    
    func fetchLocalData(completion: @escaping (Result<Banchans, Error>) -> Void) {
        
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
        let service = APIService.init(urlSessionManager: sessionManager)
        //when
        service.fetchDataWithSession(apiMaker: APIMaker.init(path: .main)) { _ in }
        //then
        let request = sessionManager.request
        let testtarget = APIMaker.init(path: .main)
        XCTAssertEqual(request, testtarget.createRequest(url: testtarget.components.url!))
    }
    
    func test뷰_모델의_로직은_올바른가() {
        //given
        let apiService = APIService.init(urlSessionManager: URLSession.shared)
        let coordinator = SceneCoordinator.init(window: UIWindow.init())
        let repo = BanchanStorage.init(apiService: apiService)
        let viewModel = BanchanListViewModel.init(sceneCoordinator: coordinator, storage: repo)
        
        let jsonData = Bundle.main.path(forResource: "main", ofType: "json", inDirectory: "/Model/Test")
        print(jsonData)
        
        var result: [BanchanSection] = []
        
        //when
        viewModel.banchanList
            .subscribe() { data in
                result = data
            }.disposed(by: rx.disposeBag)
        
        //then
    }
    
    func testPerformanceExample() throws {
        measure {
            
        }
    }

}
