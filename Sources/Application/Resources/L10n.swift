// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
enum L10n {
  /// Não encontramos dados para exibir.
  case noDataToShow
  /// Senadores
  case senators
  /// Enfrentamos um problema ao buscar dados para exibir.
  case somethingIsWrong
}
// swiftlint:enable type_body_length

extension L10n: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case .noDataToShow:
        return L10n.tr(key: "no_data_to_show")
      case .senators:
        return L10n.tr(key: "senators")
      case .somethingIsWrong:
        return L10n.tr(key: "something_is_wrong")
    }
  }

  private static func tr(key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

func tr(_ key: L10n) -> String {
  return key.string
}

private final class BundleToken {}

