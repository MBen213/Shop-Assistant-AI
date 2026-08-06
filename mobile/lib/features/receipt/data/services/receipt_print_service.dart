import 'package:printing/printing.dart';

import '../../domain/entities/receipt.dart';
import 'pdf_receipt_service.dart';

class ReceiptPrintService {
  ReceiptPrintService();

  final PdfReceiptService _pdfService =
      PdfReceiptService();

  Future<void> print(
    Receipt receipt,
  ) async {
    final pdfBytes =
        await _pdfService.generate(receipt);

    await Printing.layoutPdf(
      onLayout: (_) async => pdfBytes,
    );
  }
}