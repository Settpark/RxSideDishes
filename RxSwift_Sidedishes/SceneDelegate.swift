//
//  SceneDelegate.swift
//  RxSwiftSidedishes
//
//  Created by 박정하 on 2021/07/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        #if RELEASE
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        let repository = BanchanRepository(apiService: APIService(urlSessionManager: URLSession.shared, endPoint: EndPoint.init()))
        let mainUsecase = BanchanMainpageUsecase(repository: repository)
        let coordinator = SceneCoordinator(window: self.window!)
        let mainBanchanListViewmodel = BanchanListViewModel.init(sceneCoordinator: coordinator, useCase: mainUsecase)
        let listScene = Scene.MainList(mainBanchanListViewmodel)
        
        coordinator.transition(to: listScene, using: .root, animated: true)
        #elseif DEBUG
        
        #endif
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

