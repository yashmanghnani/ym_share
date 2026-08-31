# ym_share

---

[![pub package](https://img.shields.io/pub/v/ym_share.svg)](https://pub.dev/packages/ym_share)

A Flutter plugin to share text, URLs, and files from your Flutter app via the
platform's native share dialog.

Wraps the ACTION_SEND Intent on Android and UIActivityViewController
on iOS.

## Usage

Add `ym_share` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  ym_share: ^1.0.0
```

## Example

Import the library.

``` dart
import 'package:ym_share/share.dart';
```

Then invoke the static `share` method anywhere in your Dart code.

``` dart
Share.share('Check out my website https://example.com');
```

The `share` method also takes an optional `subject` that will be used when
sharing to email.

``` dart
Share.share(
  'Check out my website https://example.com',
  subject: 'Look what I made!',
);
```

To share one or multiple files invoke the static `shareFiles` method anywhere in your Dart code. Optionally you can also pass in `text` and `subject`.
``` dart
Share.shareFiles(
  ['${directory.path}/image.jpg'],
  text: 'Great picture',
);
Share.shareFiles([
  '${directory.path}/image1.jpg',
  '${directory.path}/image2.jpg',
]);
```

## Platform requirements

* Flutter 3.29.3 or newer
* Dart 3.8.0 or newer
* Android API 24 or newer
* iOS 15 or newer

The Android example uses AGP 9.1, Gradle 9.3.1, and Java 17. The iOS example
uses CocoaPods with an iOS 15 deployment target.

## API

* `Share.share(String text, {String? subject, Rect? sharePositionOrigin})`
  shares text or a URL.
* `Share.shareFiles(List<String> paths, {List<String>? mimeTypes,
  String? subject, String? text, Rect? sharePositionOrigin})` shares one or
  more local files.

`sharePositionOrigin` is used by iPadOS to anchor the popover and has no effect
on Android or non-iPad iOS devices.

## License

BSD 3-Clause. See [LICENSE](LICENSE).
