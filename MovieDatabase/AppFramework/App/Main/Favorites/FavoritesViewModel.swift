import Combine
import CoreData

public enum FavoritesSection: Hashable {
  case main
}

public struct FavoritesViewModel {
  public struct Input {
    public let refresh: AnyPublisher<Void, Never>
    public let delete: AnyPublisher<IndexPath, Never>

    public init(
      refresh: AnyPublisher<Void, Never>,
      delete: AnyPublisher<IndexPath, Never>
    ) {
      self.refresh = refresh
      self.delete = delete
    }
  }

  public struct Output {
    public let values: AnyPublisher<[FavoriteViewModel], Never>

    public init(
      values: AnyPublisher<[FavoriteViewModel], Never>
    ) {
      self.values = values
    }
  }

  public let transform: (Input) -> Output

  public init(transform: @escaping (Input) -> Output) {
    self.transform = transform
  }

  public static func `default`(repo: MOMovieRepo = .default(moc: Env.database.moc)) -> FavoritesViewModel {
    FavoritesViewModel { input in

      // We can improve this logic by watching the Notification with name NSManagedObjectContextDidSave
      // and only make changes when needed instead of always reloading all Movies
      let values = input.refresh
        .map { _ in
          Just<[FavoriteViewModel]>(
            repo.getAll()
              .map { movie in
                FavoriteViewModel(
                  id: movie.id,
                  title: movie.title,
                  overview: movie.overview
                )
              }
          )
          .combineLatest(
            input.delete.prepend(IndexPath(row: -1, section: -1))
          )
          .scan([FavoriteViewModel]()) { acc, curr -> [FavoriteViewModel] in
            guard acc.count > 0 else {
              return curr.0
            }

            guard curr.1.row > -1 else {
              return curr.0
            }

            var newValues = [FavoriteViewModel]()
            newValues.remove(at: curr.1.row)

            return newValues
          }
        }
        .switchToLatest()

      return Output(
        values: values.eraseToAnyPublisher()
      )
    }
  }
}