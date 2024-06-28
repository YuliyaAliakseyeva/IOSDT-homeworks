//
//  Service.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 8.05.24.
//

import Foundation

class Service {
    private let posts: [PostForProfile] = [PostForProfile(author: "Movie NEWS", description: "Искусственный интеллект сгенерировал сразу два трейлера Гарри Поттера и проклятого дитя", image: "HarryPotter", likes: 345, views: 564),
        PostForProfile(author: "Твой персональный стилист", description: "Модные цвета осень-зима 2023-2024 включают в себя палитру из 15 цветов из которых 10 –составляют основную цветовую гамму, а 5 – классических.", image: "Colors23-24", likes: 645, views: 398),
        PostForProfile(author: "Vetka-Kvetka", description: "ПИОНЫ. За свою необычную красоту пион называют величественным, царственным, божественным цветком. Пион - цветок роскоши, используемый для оформления цветников и выращиваемый на срезку. Мощное прекрасное растение, обладающее не только великолепными цветами, но и красивой зеленью с ажурной листвой. О происхождении этого растения есть две разных античных легенды. Первая связана с именем врача Пеана, ученика самого Асклепия. Он искал способ облегчить мучения рожениц — и нашел растение, чей чудодейственный сок снимает боль, расслабляет и успокаивает. У женщин это снадобье пользовалось такой популярностью, что Асклепий приревновал к своему ученику и захотел его убить. Но Зевс посчитал это несправедливым и превратил врачевателя в цветок с такими же целебными свойствами, как и найденный им корень. Вторая легенда повествует о нимфе Пионе, в которую влюбился Аполлон. Нимфу смущали ухаживания красавчика Аполлона, поэтому она попросила защиты у Афродиты. Та превратила ее в цветущий куст и избавила от надоедливого ухажера — а само растение с тех пор символизирует застенчивость. Ведь когда мы смущаемся, наши щеки выглядят как два розовых пиона.", image: "Flowers", likes: 245, views: 266),
    PostForProfile(author: "Идеи для дома. Все, что Вы хотели бы знать о дизайне", description: "Метлахская плитка в интерьерею. Рассказыаем, где и когда появилась метлахская плитка, чем она хороша и как правильно применять ее в интерьере. Бесплатный вебинар 19.02.2024 в 17:30 МСК", image: "Interior", likes: 189, views: 264)
    ]
    
    func fetchPosts(completion: @escaping (Result<[PostForProfile], Error>) -> Void) {
        // Имитирует запрос данных из сети (делая паузу в 3 секунды)
        DispatchQueue.global().asyncAfter(deadline: .now() + 3, execute: {
            // Главное
            completion(.success(self.posts))
        })
    }
    
}
