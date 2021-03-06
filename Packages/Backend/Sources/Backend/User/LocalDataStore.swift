import Foundation
import SwiftUI

public class LocalDataStore: ObservableObject, PersistentDataStore {
    @Published public private(set) var favorites: [SubredditSmall] = [] {
        didSet {
            persistData(data: SavedData(favorites: favorites))
        }
    }
    
    let persistedDataFilename = "redditOsData"
    typealias DataType = SavedData
    struct SavedData: Codable {
        let favorites: [SubredditSmall]
    }
    
    public init() {
        self.favorites = restorePersistedData()?.favorites ?? []
    }
    
    // MARK: - Favorites management
    public func add(favorite: SubredditSmall) {
        if !favorites.contains(favorite) {
            favorites.append(favorite)
        }
    }
    
    public func remove(favorite: SubredditSmall) {
        favorites.removeAll(where: { $0 == favorite })
    }
    
    public func remove(favoriteNamed: String) {
        favorites.removeAll(where: { $0.name == favoriteNamed })
    }
}
