//
//  TabBarController.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 15.05.24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTimer()
    }
    
    private func createTimer() {
        
        var counter = 30
        
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true) { [weak self] timer in
                guard let self else { return }
                
                counter -= 1
                
                if counter <= 0 {
                    let alert = UIAlertController(title: "Справка", message: "Вы находитесь в приложении уже 10 минут. Рекомендуем сделать перерыв.", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: {action in print("Нужен перерыв")
                    }))
                    alert.addAction(UIAlertAction(title: "Не сейчас", style: .default, handler: {action in print("Продолжить в приложении")
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
