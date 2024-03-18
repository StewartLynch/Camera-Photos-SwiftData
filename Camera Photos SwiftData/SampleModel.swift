//
// Created for Camera Photos SwiftData
// by  Stewart Lynch on 2024-03-18
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch


import UIKit
import SwiftData

@Model
class SampleModel {
    var name: String
    @Attribute(.externalStorage)
    var data: Data?
    var image: UIImage? {
        if let data {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
    
    init(name: String, data: Data? = nil) {
        self.name = name
        self.data = data
    }
}

extension SampleModel {
    
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(
            for: SampleModel.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        var samples: [SampleModel] {
            [
                .init(name: "Sample 1"),
                .init(name: "Sample 2"),
                .init(name: "Sample 3")
            ]
        }
        samples.forEach {
            container.mainContext.insert($0)
        }
        return container
    }
}
