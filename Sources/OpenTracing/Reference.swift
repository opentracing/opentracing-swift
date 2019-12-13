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

/// Enum representing the type of reference
public enum ReferenceType: String {

    /// The CHILD_OF reference type, used to denote direct causal relationships
    case childOf = "CHILD_OF"

    /// The FOLLOWS_FROM reference type, currently used to denote all other non-causal relationships
    case followsFrom = "FOLLOWS_FROM"
}
