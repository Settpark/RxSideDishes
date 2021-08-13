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
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        let stroage = BanchanStorage(apiService: APIService(apiMaker: APIMaker(path: ApiServiceUseCase.main.rawValue)))
        let coordinator = SceneCoordinator(window: self.window!)
        let banchanListViewModel = BanchanListViewModel.init(sceneCoordinator: coordinator, storage: stroage)
        let listScene = Scene.MainList(banchanListViewModel)
        
        coordinator.transition(to: listScene, using: .root, animated: true)
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

