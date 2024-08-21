import 'package:annawithah/widgets/globals.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'package:animations/animations.dart';

class uploadPage extends StatefulWidget {
  const uploadPage({super.key});

  @override
  _uploadPageState createState() => _uploadPageState();
}

class _uploadPageState extends State<uploadPage>
    with SingleTickerProviderStateMixin {
  String? _fileName;
  String? _fileExtension;
  int? _fileSize;
  bool _isLoading = false;

  dynamic _fileBytes;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _uploadDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.any);

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _fileName = result.files.first.name;
          _fileExtension = result.files.first.extension;
          _fileSize = result.files.first.size;
          _animationController.forward();
          _fileBytes = result.files.first.bytes;
          
        });

        // final fileBytes = result.files.first.bytes;

        if (_fileBytes == null || _fileExtension == null) {
          print("File picking failed");
          return;
        }

        print('File Name: $_fileName');
        print('File Extension: $_fileExtension');
        print('File Size: $_fileSize bytes');

        final mimeType = getMimeType(_fileExtension!);
        final metaData = SettableMetadata(contentType: mimeType);

        print(_fileBytes);
      } else {
        print("User canceled");
      }
    } catch (e) {
      print("got this error in uploadDocument function $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload'),
        backgroundColor: Colors.green.shade100,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
                    onPressed: _uploadDocument,
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Upload File'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade300,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _animationController,
              child: _fileName != null
                  ? OpenContainer(
                      closedElevation: 0,
                      openElevation: 0,
                      transitionType: ContainerTransitionType.fadeThrough,
                      closedBuilder: (context, action) => Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'File Name: $_fileName',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'File Extension: $_fileExtension',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'File Size: $_fileSize bytes',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      openBuilder: (context, action) => FileDetailsScreen(
                        fileName: _fileName!,
                        fileExtension: _fileExtension!,
                        fileSize: _fileSize!,
                        fileBytes: _fileBytes!,
                      ),
                    )
                  : const Text('No file selected'),
            ),
          ],
        ),
      ),
    );
  }
}

class FileDetailsScreen extends StatelessWidget {
  final String fileName;
  final String fileExtension;
  final int fileSize;
  final dynamic fileBytes;

  const FileDetailsScreen({
    required this.fileName,
    required this.fileExtension,
    required this.fileSize,
    required this.fileBytes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Details'),
        backgroundColor: Colors.green.shade300,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'File Name: $fileName',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'File Extension: $fileExtension',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'File Size: $fileSize bytes',
                style: const TextStyle(fontSize: 20),
              ),

              
            ],
          ),
        ),
      ),
    );
  }
}

