import SwiftUI
import LambdaspireAbstractions
import LambdaspireDependencyResolution
import LambdaspireSwiftUIFoundations

func getStaticPreviewContainer() -> Container {
    
    let b: ContainerBuilder = .init()
    
    return b.build()
}

fileprivate let staticPreviewContainer = getStaticPreviewContainer()

extension View {
    func withStaticPreviewContainer() -> some View {
        resolving(from: staticPreviewContainer)
    }
    
    func previewContainer(
        builder: @escaping (ContainerBuilder) -> Void,
        after: @escaping (Container) -> Void = { _ in }) -> some View {
            modifier(PreviewContainerModifier(builder: builder, after: after))
        }
}

fileprivate struct PreviewContainerModifier : ViewModifier {
    
    @State private var container: Container
    
    init(
        builder: @escaping (ContainerBuilder) -> Void,
        after: @escaping (Container) -> Void) {
            let b: ContainerBuilder = .init()
            builder(b)
            let c = b.build()
            after(c)
            _container = .init(initialValue: c)
        }
    
    func body(content: Content) -> some View {
        content.resolving(from: container)
    }
}