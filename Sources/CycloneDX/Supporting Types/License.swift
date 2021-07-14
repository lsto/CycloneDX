import struct Foundation.URL

public enum LicenseChoice: Hashable, Encodable {
    public func encode(to encoder: Encoder) throws {
        fatalError("TODO")
    }

    case license(License)
    case expression(String)
}

public struct License: Identifiable, Hashable, Encodable {
    public enum ID: Hashable, Encodable {
        case other(String)

        public func encode(to encoder: Encoder) throws {
            fatalError("TODO")
        }
    }

    public var id: ID
    public var text: String?
    public var url: URL?
}
