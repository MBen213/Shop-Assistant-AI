import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../../domain/entities/receipt.dart';
import 'pdf_receipt_service.dart';

class ReceiptExportService {
  ReceiptExportService();

  final PdfReceiptService _pdfService = PdfReceiptService();

  /// يحفظ الفاتورة في مجلد التطبيق ويعيد ملف الـ PDF
  Future<File> export(
    Receipt receipt,
  ) async {
    // إنشاء بيانات الـ PDF
    final pdfBytes = await _pdfService.generate(receipt);

    // مجلد Documents الخاص بالتطبيق
    final Directory documents =
        await getApplicationDocumentsDirectory();

    // إنشاء مجلد Receipts إذا لم يكن موجوداً
    final Directory receiptsDirectory = Directory(
      '${documents.path}/Receipts',
    );

    if (!await receiptsDirectory.exists()) {
      await receiptsDirectory.create(
        recursive: true,
      );
    }

    // اسم الملف
    final File file = File(
      '${receiptsDirectory.path}/${receipt.id}.pdf',
    );

    // حفظ الملف
    await file.writeAsBytes(
      pdfBytes,
      flush: true,
    );

    return file;
  }
}