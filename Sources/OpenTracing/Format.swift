import Foundation

/// Format and carrier for extract(). Marker protocol.
public protocol FormatReader {}

/// Format and carrier for inject(). Marker protocol.
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
