import struct TSCBasic.AbsolutePath

#if canImport(UniformTypeIdentifiers)
import UniformTypeIdentifiers
#endif

extension AbsolutePath {
    var preferredMIMEType: String? {
        #if canImport(UniformTypeIdentifiers)
        guard #available(macOS 11.0, *),
              let `extension` = `extension`
        else { return nil }

        return UTType(filenameExtension: `extension`)?.preferredMIMEType
        #else
        return nil
        #endif
    }
}
