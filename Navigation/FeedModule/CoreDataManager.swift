//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 4.10.24.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "PostModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchPosts() -> [Post] {
        let request = Post.fetchRequest()
        return (try? persistentContainer.viewContext.fetch(request)) ?? []
    }
    
    func addPost(author: String, text: String,image: String, likes: Int, views: Int) {
        let post = Post(context: persistentContainer.viewContext)
        post.author = author
        post.text = text
        post.image = image
        post.likes = Int64(likes)
        post.views = Int64(views)
        
        try? persistentContainer.viewContext.save()
    }
    
    func deletePost(post: Post) {
        let context = post.managedObjectContext
        context?.delete(post)
        try? context?.save()
    }
}
