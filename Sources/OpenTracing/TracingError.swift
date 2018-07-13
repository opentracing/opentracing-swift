/// - TODO: more docs
public enum TracingError: Error {

    // unknown reader
    case unsupportedFormatReader(FormatReader)

    // unknown writer
    case unsupportedFormatWriter(FormatWriter)

    // spancontext is not a lightstep span
    case unsupportedSpanContext(SpanContext)

    // format reader cannot find all the info it needs
    case spanContextCorrupted

    // multiple parent references for a given span
    case multipleParentReferences([Reference])

    // unsupported reference type
    case unsupportedReferenceType(ReferenceType)
}
