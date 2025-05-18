import Foundation
import AZSClient          // Azure Storage iOS SDK
//import os.log

// MARK: -– Block-blob helpers
public extension AZSCloudBlockBlob {

    /// Async wrapper for `uploadFromFile(withPath:completionHandler:)`
    func uploadFromFile(from localURL: URL) async throws {
        try await withCheckedThrowingContinuation { cont in
            // The SDK method is objc; capture self strongly on purpose.
            self.uploadFromFile(withPath: localURL.path) { error in
                if let error { cont.resume(throwing: error) }
                else         { cont.resume() }
            }
        }
    }

    /// Async wrapper for `downloadToFile(withPath:completionHandler:)`
    func downloadToFile(to localURL: URL) async throws {
        try await withCheckedThrowingContinuation { cont in
            self.downloadToFile(withPath: localURL.path) { error in
                if let error { cont.resume(throwing: error) }
                else         { cont.resume() }
            }
        }
    }

    /// Async delete
    func delete() async throws {
        try await withCheckedThrowingContinuation { cont in
            self.delete { error, _ in
                if let error { cont.resume(throwing: error) }
                else         { cont.resume() }
            }
        }
    }
}

// MARK: -– Container helpers
public extension AZSCloudBlobContainer {

    /// Creates the container if it doesn't exist and returns `true`
    /// if it was actually created.
    func createContainerIfNotExists(
        accessType: AZSContainerPublicAccessType = .container
    ) async throws -> Bool {
        try await withCheckedThrowingContinuation { cont in
            self.createContainerIfNotExists(with: accessType) { error, created in
                if let error { cont.resume(throwing: error) }
                else         { cont.resume(returning: created) }
            }
        }
    }

    /// Lists blobs (flat) and returns the first segment.
    func listBlobs(
        prefix: String? = nil,
        maxResults: Int32 = 500
    ) async throws -> AZSBlobResultSegment {
        try await withCheckedThrowingContinuation { cont in
            self.listBlobsSegmented(
                with: nil,
                prefix: prefix,
                useFlatBlobListing: true,
                blobListingDetails: [],
                maxResults: maxResults
            ) { error, segment in
                if let error { cont.resume(throwing: error) }
                else if let segment { cont.resume(returning: segment) }
                else { cont.resume(throwing: NSError(
                        domain: "AZSClient",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey:
                                   "No segment and no error returned"])
                )}
            }
        }
    }

    /// Convenience: returns a *new* block-blob reference wrapped in async helpers.
    func blockBlobReference(named name: String) throws -> AZSCloudBlockBlob {
        guard let blob = self.blockBlobReference(fromName: name) else {
            throw NSError(domain: "AZSClient",
                          code: -1,
                          userInfo: [NSLocalizedDescriptionKey:
                                     "Could not create blob reference"])
        }
        return blob
    }
}
