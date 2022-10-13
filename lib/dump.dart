import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class pdf extends StatefulWidget {
  late PDFDocument document;

  pdf(this.document); //const pdf({Key? key}) : super(key: key);

  @override
  _pdfState createState() => _pdfState(document);
}

class _pdfState extends State<pdf> {
  late PDFDocument document;

  _pdfState(this.document);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PDFViewer(
        document: document,
        zoomSteps: 1,
        //uncomment below line to preload all pages
        lazyLoad: false,
        //uncomment below line to scroll vertically
        scrollDirection: Axis.vertical,

        //uncomment below code to replace bottom navigation with your own
        navigationBuilder:
                          (context, page, totalPages, jumpToPage, animateToPage) {
                        return ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.first_page),
                              onPressed: () {
                                jumpToPage(page: 0);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                animateToPage(page: page! - 2);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                animateToPage(page: page);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.last_page),
                              onPressed: () {
                                jumpToPage(page: totalPages! - 1);
                              },
                            ),
                          ],
                        );
                      },
      ),
    );
  }
}
