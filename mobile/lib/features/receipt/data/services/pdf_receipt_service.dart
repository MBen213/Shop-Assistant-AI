import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../domain/entities/receipt.dart';

class PdfReceiptService {
  Future<Uint8List> generate(
    Receipt receipt,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),
        build: (context) => [
          _buildHeader(receipt),

          pw.SizedBox(height: 20),

          _buildItemsTable(receipt),

          pw.SizedBox(height: 20),

          _buildTotal(receipt),

          pw.SizedBox(height: 30),

          _buildFooter(),
        ],
      ),
    );

    return pdf.save();
  }

  //==========================================================
  // HEADER
  //==========================================================

  pw.Widget _buildHeader(
    Receipt receipt,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(
          "SHOP ASSISTANT AI",
          style: pw.TextStyle(
            fontSize: 24,
            fontWeight: pw.FontWeight.bold,
          ),
        ),

        pw.SizedBox(height: 8),

        pw.Text(
          "Sales Receipt",
          style: const pw.TextStyle(
            fontSize: 16,
          ),
        ),

        pw.Divider(),

        pw.Row(
          mainAxisAlignment:
              pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              "Receipt ID",
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            pw.Text(receipt.id),
          ],
        ),

        pw.SizedBox(height: 6),

        pw.Row(
          mainAxisAlignment:
              pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              "Date",
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            pw.Text(
              receipt.createdAt.toString(),
            ),
          ],
        ),
      ],
    );
  }

  //==========================================================
  // PRODUCTS TABLE
  //==========================================================

  pw.Widget _buildItemsTable(
    Receipt receipt,
  ) {
    return pw.TableHelper.fromTextArray(
      border: pw.TableBorder.all(),

      headers: const [
        "Product",
        "Qty",
        "Price",
        "Subtotal",
      ],

      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
      ),

      data: receipt.items.map((item) {
        return [
          item.productName,
          item.quantity.toString(),
          item.price.toStringAsFixed(2),
          item.subtotal.toStringAsFixed(2),
        ];
      }).toList(),
    );
  }

  //==========================================================
  // TOTAL
  //==========================================================

  pw.Widget _buildTotal(
    Receipt receipt,
  ) {
    return pw.Align(
      alignment: pw.Alignment.centerRight,
      child: pw.Text(
        "TOTAL : ${receipt.total.toStringAsFixed(2)} DA",
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  //==========================================================
  // FOOTER
  //==========================================================

  pw.Widget _buildFooter() {
    return pw.Column(
      children: [
        pw.Divider(),

        pw.SizedBox(height: 8),

        pw.Text(
          "Thank you for your purchase",
          style: const pw.TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}