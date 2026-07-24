import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../data/models/lesson.dart';
import '../../data/models/lesson_extensions.dart';
import '../widgets/bookmark_button.dart';

import '../../data/models/lesson_extensions.dart';

class PdfViewerScreen extends StatefulWidget {
  final Lesson lesson;
  final int? lessonNumber;
  const PdfViewerScreen({super.key, required this.lesson, this.lessonNumber});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final PdfViewerController _controller = PdfViewerController();
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    final title = widget.lessonNumber != null
        ? 'Bài ${widget.lessonNumber}: ${widget.lesson.displayTitle}'
        : widget.lesson.displayTitle;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          BookmarkButton(lessonId: widget.lesson.id),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: _hasError
          ? const Center(child: Text('Không thể tải file PDF'))
          : _buildViewer(),
    );
  }

  Widget _buildViewer() {
    final path = widget.lesson.contentPath;
    if (path.startsWith('http')) {
      return SfPdfViewer.network(
        path,
        controller: _controller,
        onDocumentLoadFailed: (details) => setState(() => _hasError = true),
      );
    }
    return SfPdfViewer.asset(
      path,
      controller: _controller,
      onDocumentLoadFailed: (details) => setState(() => _hasError = true),
    );
  }
}
