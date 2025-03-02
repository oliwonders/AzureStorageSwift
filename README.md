# AzureStorageSwift

A Swift Package for Azure Storage access on macOS & iOS, providing simple and efficient Blob container interactions.

> **Note**: This package is forked from the deprecated [Azure Storage iOS SDK](https://github.com/Azure/azure-storage-ios). While functional for basic operations, consider using the officially maintained [Azure SDK for iOS](https://github.com/Azure/azure-sdk-for-ios) for production applications.

## Features

- Basic Blob container operations (upload, download, delete)
- Support for both macOS and iOS platforms
- Simple integration via Swift Package Manager
- Lightweight alternative to the full Azure SDK

## Prerequisites

- An active [Azure subscription](https://azure.microsoft.com)
- Azure Storage Account and Blob Container
  - [Quick Start Guide: Create Storage Account and Container](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-portal)
- SAS (Shared Access Signature) Key for authentication
  - [Guide: Managing Storage Account Keys](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-keys-manage?tabs=azure-portal)

## Installation

### Swift Package Manager

1. Open your Xcode project
2. Navigate to **File → Add Package Dependencies**
3. Enter the repository URL:
   ```plaintext
   https://github.com/oliwonders/AzureStorageSwift.git
   ```
4. Click **Add Package**

## Basic Usage

```swift
    let sasUrl = "https://yourstorageaccount.blob.core.windows.net/containername?sv=2020-08-04&ss=b&srt=co&sp=rwdlacitfx&se=2023-04-30T17:31:42Z&st=2023-04-30T09:31:42Z&spr=https&sig=XXXXX"

    let container = try AZSCloudBlobContainer(url: URL(string: sasUrl))

    // List blobs in the container
    container.listBlobsSegmented(
        with: nil,
        prefix: nil,
        useFlatBlobListing: true,
        blobListingDetails: AZSBlobListingDetails(),
        maxResults: 50
    ) { (error, results) in
        if let error = error {
            print("Error listing blobs: \(error.localizedDescription)")
            return
        }

        guard let blobs = results?.blobs as? [AZSCloudBlob] else {
            print("No blobs found or unable to cast results")
            return
        }

        print("Found \(blobs.count) blobs:")
        for blob in blobs {
            print("- \(blob.blobName ?? "Unknown")")
        }
    }
```

> **Note for Command-Line Applications:** Azure Storage operations are asynchronous. In command-line tools, you may need to use a DispatchGroup or RunLoop to prevent the program from exiting before operations complete.


## Known Limitations

- Limited to basic Blob storage operations
- No support for advanced Azure Storage features
- May not receive regular security updates due to being based on deprecated SDK

## Support

- Report issues here [GitHub Issues](https://github.com/oliwonders/AzureStorageSwift/issues) page
- For production applications, consider migrating to the [official Azure SDK for iOS](https://github.com/Azure/azure-sdk-for-ios)

## Contributing

Contributions are welcome! Fork and create a PR.
