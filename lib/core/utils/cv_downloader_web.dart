import 'dart:html' as html;

Future<void> downloadCv() async {
  final anchor =
      html.AnchorElement(
          href: Uri.base.resolve('assets/assets/cv/mycv.docx').toString(),
        )
        ..download = 'mycv.docx'
        ..style.display = 'none';

  html.document.body?.children.add(anchor);
  anchor.click();
  anchor.remove();
}
