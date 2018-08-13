public struct Global {
    private init() {}

    public static var sharedTracer: Tracer = NoopTracer()
}
