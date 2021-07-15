public struct Checksum: Hashable {
    public var algorithm: String
    public var value: String

    public init(algorithm: String, value: String) {
        self.algorithm = algorithm
        self.value = value
    }
}

extension Checksum: Encodable {
    private enum CodingKeys: String, CodingKey {
        case algorithm
        case value = "checksumValue"
    }
}
