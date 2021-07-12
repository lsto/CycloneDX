import struct Foundation.URL

public enum LicenseChoice {
    case license(License)
    case expression(String)
}

public struct License: Identifiable {
    public enum ID: Hashable {
        case other(String)
    }

    public var id: ID
    public var text: String?
    public var url: URL?
}
