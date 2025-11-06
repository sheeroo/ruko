import Flutter
import Photos
import UIKit

class PhotoUtils: NSObject {

    static let shared = PhotoUtils()

    private override init() {
        super.init()
    }

    func setupMethodChannel(with binaryMessenger: FlutterBinaryMessenger) {
        let channel = FlutterMethodChannel(
            name: "photo_utils",
            binaryMessenger: binaryMessenger
        )

        channel.setMethodCallHandler { [weak self] call, result in
            guard let self = self else { return }
            self.handleMethodCall(call, result: result)
        }
    }

    private func handleMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard call.method == "isDeletable" else {
            DispatchQueue.main.async {
                result(FlutterMethodNotImplemented)
            }
            return
        }

        guard
            let args = call.arguments as? [String: Any],
            let localIds = args["ids"] as? [String],
            !localIds.isEmpty
        else {
            DispatchQueue.main.async {
                result(
                    FlutterError(
                        code: "INVALID_ARGUMENTS",
                        message: "Expected non-empty 'ids' array",
                        details: nil
                    )
                )
            }
            return
        }
        checkDeletableAssets(localIds: localIds, result: result)
    }

    private func checkDeletableAssets(localIds: [String], result: @escaping FlutterResult) {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)

        guard status == .authorized || status == .limited else {
            DispatchQueue.main.async {
                result(
                    FlutterError(
                        code: "PERMISSION_DENIED",
                        message: "Photo library access not granted",
                        details: nil
                    )
                )
            }
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            let assets = PHAsset.fetchAssets(
                withLocalIdentifiers: localIds,
                options: nil
            )

            var deletableAssetIds: [String] = []

            assets.enumerateObjects { asset, _, _ in
                if asset.canPerform(.delete) {
                    deletableAssetIds.append(asset.localIdentifier)
                }
            }

            DispatchQueue.main.async {
                result(deletableAssetIds)
            }
        }
    }
}
