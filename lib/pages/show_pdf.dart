import 'package:firesore_flutter/models/collection-model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';




class ShowPdf extends StatefulWidget {
  var name;
  var link;
   ShowPdf(this.name, this.link, {Key? key}) : super(key: key);

  @override
  State<ShowPdf> createState() => _ShowPdfState(name, link);
}

class _ShowPdfState extends State<ShowPdf> {
  _ShowPdfState(this.name, this.link);
  var name;
  var link;
  @override
  Widget build(BuildContext context) {

    PdfViewerController _pdfViewerController;
    _pdfViewerController = PdfViewerController();
    return Scaffold(
        appBar: AppBar(
          title:  Text(name.toString()),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerController.previousPage();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerController.nextPage();
              },
            )
          ],
        ),

        body: SfPdfViewer.network(link.toString())
    );
  }
}


// class ShowPdf extends StatelessWidget {
//   const ShowPdf({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }
