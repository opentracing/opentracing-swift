import Foundation

/// "Format", "Carrier", "Extract", "Inject", and "Text Map" are opentracing-specific concepts. See:
/// https://github.com/opentracing/specification/blob/master/specification.md#inject-a-spancontext-into-a-carrier
/// https://github.com/opentracing/specification/blob/master/specification.md#extract-a-spancontext-from-a-carrier
/// https://github.com/opentracing/specification/blob/master/specification.md#note-required-formats-for-injection-and-extraction

/// Format and carrier for extract().
/// A FormatReader is used to extract a SpanContext from a carrier.
/// The type of the child protocol is the format descriptor.
/// The carrier is specified by the protocol's return type for the getter, usually `getAll()`.
///
/// Marker protocol.
public protocol FormatReader {}

/// Format and carrier for inject().
/// A FormatWriter is used to inject a SpanContext into a carrier.
/// The type of the child protocol is the format descriptor.
/// The carrier is specified by the protocol's parameter type for the setter, usually `setAll()`
///
/// Marker protocol.
public protocol FormatWriter {}

/// Read interface for a textmap
public protocol TextMapReader: FormatReader {

    /// Return the text map as a [String: String]
    ///
    /// - returns: textmap as a [String: String] representation
    func getAll() -> [String: String]
}

/// Write interface for a textmap
public protocol TextMapWriter: FormatWriter {

    /// Set all values from a [String: String]
    ///
    /// - parameter textMap: dictionary containing key-value pairs to set into the text map
    func setAll(textMap: [String: String])
}

/// Read interface for HTTP headers
public protocol HTTPHeadersReader: TextMapReader {}

/// Write interface for HTTP headers
public protocol HTTPHeadersWriter: TextMapWriter {}

/// Read interface for a custom carrier
public protocol CustomFormatReader {

    /// Extract a span context from the custom carrier
    ///
    /// - returns: extracted span context from the custom carrier, or nil on failure
    func extract() -> SpanContext?
}

/// Write interface for a custom carrier
public protocol CustomFormatWriter {

    /// Inject a span context into the custom carrier
    ///
    /// - parameter spanContext: context to inject into the custom carrier
    func inject(spanContext: SpanContext)
}
