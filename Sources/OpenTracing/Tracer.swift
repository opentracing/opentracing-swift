import Foundation

/// Tracer is the starting point for all OpenTracing instrumentation. Use it
/// to create OTSpans, inject/extract them between processes, and so on.
/// 
/// Tracer is thread-safe.
public protocol Tracer {

    /// Start a new span with the given operation name. Since there is no parent
    /// specified, the returned span will be a trace root.
    ///
    /// - parameter operationName: the operation name for the newly-started span
    /// - parameter references:    an optional list of Reference instances to record causal relationships
    /// - parameter tags:          a set of tag keys and values per OTSpan#setTag:value:, or nil to start with
    ///                            an empty tag map
    /// - parameter startTime:     an explicitly specified start timestamp for the OTSpan, or nil to use the
    ///                            current walltime
    /// - returns:                 a valid Span instance; it is the caller's responsibility to call finish()
    func startSpan(operationName: String, references: [Reference]?, tags: [String: Any]?,
                   startTime: Date?) -> Span

    /// Transfer the span information into the carrier of the given format.
    ///
    /// For example:
    ///
    ///     let httpHeaders: [String: String] = ...
    ///     OpenTracing.Tracer.shared().inject(spanContext: span, format: OpenTracing.Format.TextMap,
    ///                                        carrier: httpHeaders)
    ///
    /// - SeeAlso: [propagation](http://opentracing.io/propagation/)
    ///
    /// - parameter spanContext: the OTSpanContext instance to inject
    /// - parameter writer:      the desired inject carrier format and corresponding carrier. Format is
    ///                          specified via the type, and the carrier is the backing store being written
    ///                          to.
    func inject(spanContext: SpanContext, writer: FormatWriter)

    /// Extract a SpanContext previously (and remotely) injected into the carrier of the given format.
    /// 
    /// For example:
    ///     let headerMap: [String: String] = req.headers // or similar
    ///     OpenTracing.SpanContext ctx =
    ///         OpenTracing.Tracer.shared().extract(format: OpenTracing.Format.TextMap, carrier: headerMap)
    ///     OpenTracing.Span span =
    ///         OpenTracing.Tracer.shared().startSpan(operationName: "methodName", childOf: ctx)
    ///
    /// - SeeAlso: [propagation](http://opentracing.io/propagation/)
    /// 
    /// - parameter reader:  the desired extract carrier format and corresponding carrier. Format is
    ///                      specified via the type, and the carrier is the backing store being read from.
    /// @returns a newly-created OTSpanContext that belongs to the trace previously
    ///        injected into the carrier (presumably in a remote process)
    /// 
    func extract(reader: FormatReader) -> SpanContext?
}

/// - TODO: headerdoc
public extension Tracer {
    func startSpan(operationName: String, childOf parent: SpanContext?, tags: [String: Any]? = nil,
                   startTime: Date? = nil) -> Span
    {
        let references = parent.map { [Reference.child(of: $0)] }
        return self.startSpan(operationName: operationName, references: references, tags: tags,
                                  startTime: startTime)
    }
}
