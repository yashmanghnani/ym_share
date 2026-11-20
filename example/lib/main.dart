// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

// Keep compatibility with Flutter versions before material_ui was introduced.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ym_share/ym_share.dart';

import 'image_previews.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  @override
  DemoAppState createState() => DemoAppState();
}

class DemoAppState extends State<DemoApp> {
  String text = '';
  String subject = '';
  List<String> imagePaths = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share Plugin Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('Share Plugin Demo')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Share text:',
                    hintText: 'Enter some text and/or link to share',
                  ),
                  maxLines: 2,
                  onChanged: (String value) => setState(() {
                    text = value;
                  }),
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Share subject:',
                    hintText: 'Enter subject to share (optional)',
                  ),
                  maxLines: 2,
                  onChanged: (String value) => setState(() {
                    subject = value;
                  }),
                ),
                const Padding(padding: EdgeInsets.only(top: 12.0)),
                ImagePreviews(imagePaths, onDelete: _onDeleteImage),
                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('Add image'),
                  onTap: () async {
                    final imagePicker = ImagePicker();
                    final pickedFile = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        imagePaths.add(pickedFile.path);
                      });
                    }
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 12.0)),
                Builder(
                  builder: (BuildContext context) {
                    return ElevatedButton(
                      onPressed: text.isEmpty && imagePaths.isEmpty
                          ? null
                          : () => _onShare(context),
                      child: const Text('Share'),
                    );
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 12.0)),
                Builder(
                  builder: (BuildContext context) {
                    return ElevatedButton(
                      onPressed: () => _onShareWithEmptyOrigin(context),
                      child: const Text('Share With Empty Origin'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onDeleteImage(int position) {
    setState(() {
      imagePaths.removeAt(position);
    });
  }

  Future<void> _onShare(BuildContext context) async {
    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final RenderBox box = context.findRenderObject()! as RenderBox;

    if (imagePaths.isNotEmpty) {
      await Share.shareFiles(
        imagePaths,
        text: text,
        subject: subject,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      );
    } else {
      await Share.share(
        text,
        subject: subject,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      );
    }
  }

  Future<void> _onShareWithEmptyOrigin(BuildContext context) async {
    await Share.share('text');
  }
}
