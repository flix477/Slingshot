import SwiftUI

#if canImport(AppKit)
public protocol ViewRepresentable: NSViewRepresentable {
    func makeView(context: Context) -> NSViewType
    func updateView(_ view: NSViewType, context: Context)
}

public extension ViewRepresentable {
    func makeNSView(context: Context) -> NSViewType {
        makeView(context: context)
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        updateView(nsView, context: context)
    }
}
#else
public protocol ViewRepresentable: UIViewRepresentable {
    func makeView(context: Context) -> UIViewType
    func updateView(_ view: UIViewType, context: Context)
}

public extension ViewRepresentable {
    func makeUIView(context: Context) -> UIViewType {
        makeView(context: context)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        updateView(uiView, context: context)
    }
}
#endif
