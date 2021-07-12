public struct Dependency {
    public var reference: String

    public var dependsOn: [Dependency]

    public init(reference: String, 
                dependsOn: [Dependency] = []) 
    {
        self.reference = reference
        self.dependsOn = dependsOn
    }
}
