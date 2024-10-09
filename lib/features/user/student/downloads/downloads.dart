import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Downloads extends StatefulWidget {
  const Downloads({Key? key}) : super(key: key);

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  List<DownloadCard> _downloadCards = [];

  @override
  void initState() {
    super.initState();
    _listFiles();
  }

  Future<void> _listFiles() async {
    Directory? appDirectory;

    try {
      appDirectory = await getExternalStorageDirectory();
    } catch (e) {
      print("Error getting external storage directory: $e");
    }

    if (appDirectory != null) {
      print("External storage directory: ${appDirectory.path}");

      final List<FileSystemEntity> files = appDirectory.listSync();

      print("Number of files in directory: ${files.length}");

      for (var file in files) {
        if (file is File) {
          print("File found: ${file.path}");
          FileType fileType = _getFileType(file.path.split('.').last);
          _downloadCards.add(
            DownloadCard(
              fileName: file.path.split('/').last,
              fileType: fileType,
              subject: 'File Subject', // Replace with actual subject
              time: 'File Time', // Replace with actual time
            ),
          );
        }
      }
    } else {
      print("External storage directory is null");
    }

    setState(() {});
  }


  FileType _getFileType(String extension) {
    switch (extension.toLowerCase()) {
      case 'mp4':
      case 'avi':
      case 'mov':
        return FileType.video;
      case 'pdf':
        return FileType.pdf;
      case 'doc':
      case 'docx':
        return FileType.doc;
      default:
        return FileType.doc; // Default to doc if the extension is not recognized
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downloads'),
      ),
      body: ListView(
        children: _downloadCards,
      ),
    );
  }
}

enum FileType {
  video,
  pdf,
  doc,
}

class DownloadCard extends StatelessWidget {
  final String fileName;
  final FileType fileType;
  final String subject;
  final String time;

  DownloadCard({
    Key? key,
    required this.fileName,
    required this.fileType,
    required this.subject,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color iconColor;

    // Set icon and color based on file type
    switch (fileType) {
      case FileType.video:
        iconData = Icons.play_circle_outline;
        iconColor = Colors.orange;
        break;
      case FileType.pdf:
        iconData = Icons.picture_as_pdf;
        iconColor = Colors.red;
        break;
      case FileType.doc:
        iconData = Icons.description;
        iconColor = Colors.blue;
        break;
      default:
        iconData = Icons.file_download;
        iconColor = Colors.black;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(iconData, size: 36, color: iconColor),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(fileName, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 8.0),
                Text(subject, style: TextStyle(fontSize: 14.0, color: Colors.grey)),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(time, style: TextStyle(fontSize: 14.0, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
