import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key, this.pdfUrl});
  final pdfUrl;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: AppBar(
      //   title: const Text('Syncfusion Flutter PDF Viewer'),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(
      //         Icons.bookmark,
      //         color: Colors.white,
      //         semanticLabel: 'Bookmark',
      //       ),
      //       onPressed: () {
      //         _pdfViewerKey.currentState?.openBookmarkView();
      //       },
      //     ),
      //   ],
      // ),
      body: Container(
        child: SfPdfViewer.network(
          widget.pdfUrl,
          // key: _pdfViewerKey,
        ),
      ),
    );
  }
}
