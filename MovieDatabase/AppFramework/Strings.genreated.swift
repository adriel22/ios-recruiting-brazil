// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Screen {
    internal enum Favorites {
      /// Favorites
      internal static let title = L10n.tr("Localizable", "screen.favorites.title")
      /// Unfavorite
      internal static let unfavorite = L10n.tr("Localizable", "screen.favorites.unfavorite")
    }

    internal enum MovieDetails {
      /// Movie
      internal static let title = L10n.tr("Localizable", "screen.movie_details.title")
    }

    internal enum Movies {
      /// Movies
      internal static let title = L10n.tr("Localizable", "screen.movies.title")
    }
  }
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private enum BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
      return Bundle.module
    #else
      return Bundle(for: BundleToken.self)
    #endif
  }()
}

// swiftlint:enable convenience_type