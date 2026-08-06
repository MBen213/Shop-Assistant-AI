import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/entities/receipt.dart';
import 'pdf_receipt_service.dart';

class ReceiptShareService {
  ReceiptShareService();

  final PdfReceiptService _pdfService =
      PdfReceiptService();

  Future<void> share(
    Receipt receipt,
  ) async {
    final pdfBytes =
        await _pdfService.generate(receipt);

    final directory =
        await getTemporaryDirectory();

    final file = File(
      '${directory.path}/${receipt.id}.pdf',
    );

    await file.writeAsBytes(pdfBytes);

    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile(file.path),
        ],
        text:
            'Receipt ${receipt.id}',
        subject:
            'Sales Receipt',
      ),
    );
  }
}