//
//  TabBarController.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 15.05.24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private var timer: Timer?
    
    var networkManager: NetworkService
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTimer()
        
        networkManager.request {  result in
            switch result {
            case .success(let name):
                print(name ?? "")
            case .failure(let error):
                print("Ошибка - \(error.localizedDescription)")
                print(error.description)
            }
        }
    }
    
    private func createTimer() {
        
        var counter = 30
        
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true) { [weak self] timer in
                guard let self else { return }
                
                counter -= 1
                
                if counter <= 0 {
                    let alert = UIAlertController(title: NSLocalizedString("Help", comment: ""), message: NSLocalizedString("Comment", comment: ""), preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: {action in print("Нужен перерыв")
                    }))
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Not now", comment: ""), style: .default, handler: {action in print("Продолжить в приложении")
                    }))
                    
                    alert.modalTransitionStyle = .flipHorizontal
                    alert.modalPresentationStyle = .pageSheet
                    
                    present(alert, animated: true)
                    
                    self.timer?.invalidate()
                    self.timer = nil
                }
            }
    }
    
    
}
