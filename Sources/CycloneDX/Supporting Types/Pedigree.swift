/// Component pedigree is a way to document complex supply chain scenarios where components are created, distributed, modified, redistributed, combined with other components, etc. Pedigree supports viewing this complex chain from the beginning, the end, or anywhere in the middle. It also provides a way to document variants where the exact relation may not be known.
public struct Pedigree {
    public var ancestors: [Component]
    public var descendants: [Component]
    public var variants: [Component]
    public var commits: [Commit]
    public var patches: [Patch]
    public var notes: String?
}
