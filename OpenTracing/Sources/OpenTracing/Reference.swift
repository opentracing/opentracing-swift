/// OpenTracing span reference
public struct Reference {

    /// Type of reference
    public let type: ReferenceType

    /// Span context that the reference points to
    public let context: SpanContext

    public static func child(of parent: SpanContext) -> Reference {
        return Reference(type: .childOf, context: parent)
    }

    public static func follows(from precedingContext: SpanContext) -> Reference {
        return Reference(type: .followsFrom, context: precedingContext)
    }
}

/// Struct representing the type of reference
public struct ReferenceType: RawRepresentable {

    /// Raw reference type string
    public let rawValue: String

    /// Initialize a reference type with the raw string
    ///
    /// - parameter rawValue: Raw string value of the reference type
    public init(rawValue: String) { self.rawValue = rawValue }

    /// Initialize a reference type with the raw string
    ///
    /// - parameter rawValue: Raw string value of the reference type
    public init(_ rawValue: String) { self.rawValue = rawValue }

    /// The CHILD_OF reference type, used to denote direct causal relationships
    public static let childOf = ReferenceType("CHILD_OF")

    /// The FOLLOWS_FROM reference type, currently used to denote all other non-causal relationships
    public static let followsFrom = ReferenceType("FOLLOWS_FROM")
}
