import Testing
import Foundation

@testable import AzureStorageSwift

@Test
func testContainerInit() async throws {
    let url = URL(string: "https://test.blob.core.windows.net/mycontainer")!
    let container = try AZSCloudBlobContainer(url: url)
    
    #expect(container.name == "mycontainer")
    #expect(container.client != nil)
    #expect(container.storageUri != nil)
}

@Test
func testBlockBlobReference() async throws {
    let url = URL(string: "https://test.blob.core.windows.net/mycontainer")!
    let container = try AZSCloudBlobContainer(url: url)
    
    let blobName = "testBlob.txt"
    let blockBlob = container.blockBlobReference(fromName: blobName)
    
    #expect(blockBlob != nil)
    #expect(blockBlob?.blobName == blobName)
}

@Test
func testPageBlobReference() async throws {
    let url = URL(string: "https://test.blob.core.windows.net/mycontainer")!
    let container = try AZSCloudBlobContainer(url: url)
    
    let blobName = "testPageBlob.vhd"
    let pageBlob = container.pageBlobReference(fromName: blobName)
    
    #expect(pageBlob != nil)
    #expect(pageBlob?.blobName == blobName)
}


