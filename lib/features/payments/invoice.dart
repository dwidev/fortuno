import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/theme/default_size.dart';
import '../order/domain/entities/order.dart';

class InvoiceService {
  static Future<void> showPdf(Order order) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build:
            (context) => [
              _buildHeader(),
              pw.SizedBox(height: PdfPageFormat.cm * 3),
              _buildTitle(),
              pw.SizedBox(height: PdfPageFormat.cm * 0.2),
              _buildInvoice(order),
              pw.SizedBox(height: PdfPageFormat.cm * 0.2),
              pw.Divider(color: PdfColors.grey100, height: 0.5),
              pw.SizedBox(height: PdfPageFormat.cm * 0.3),
              _buildTotal(order),
            ],
        footer:
            (context) => pw.Column(
              children: [
                pw.Text(
                  "Generate by FortunoPOS app",
                  style: pw.TextStyle(
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
      ),
    );

    final file = await saveInvoice(name: "invoice", pdf: pdf);

    OpenFile.open(file.path);
  }

  static Future<File> saveInvoice({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static pw.Widget _buildHeader() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'INVOICE',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
        ),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "RMB/INV/0001/21/02/2025",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.normal),
                ),
                pw.SizedBox(height: 1 * PdfPageFormat.mm),
              ],
            ),
            pw.Container(
              width: 150,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    "RM Barokah Catering",
                    style: pw.TextStyle(fontSize: 10),
                  ),
                  pw.Text(
                    "Ciputih gugah sari, Gg Masjid Albarokah",
                    textAlign: pw.TextAlign.end,
                    style: pw.TextStyle(fontSize: 10),
                  ),
                  pw.Text(
                    "Dramaga, Bogor 16690, ID",
                    textAlign: pw.TextAlign.end,
                    style: pw.TextStyle(fontSize: 10),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    "085868890741",
                    textAlign: pw.TextAlign.end,
                    style: pw.TextStyle(fontSize: 10),
                  ),
                  pw.Text(
                    "cateringrmbarokah@gmail.com",
                    textAlign: pw.TextAlign.end,
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildTitle() {
    return pw.Container(
      color: PdfColors.grey100,
      padding: pw.EdgeInsets.symmetric(vertical: kSizeSS, horizontal: kSizeSS),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Issued To',
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
              pw.Text(
                "Pesanan Nasi Box - SMK Adi sanggoro",
                style: pw.TextStyle(fontSize: 8),
              ),
              pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                "Invoice date : Mar, 20 2025",
                style: pw.TextStyle(fontSize: 8),
              ),
              pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
              pw.Text(
                "Due Date: Mar, 201 2025",
                style: pw.TextStyle(fontSize: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Table _buildInvoice(Order order) {
    final headers = ['Product', 'Quantity', 'Price', 'Amount'];
    final data =
        order.items.map((item) {
          final total = 10 * item.quantity;

          return [
            "item.description",
            '${item.quantity}',
            '\$ ${1000}',
            '\$ ${total.toStringAsFixed(2)}',
          ];
        }).toList();

    return pw.TableHelper.fromTextArray(
      headers: headers,
      data: data,
      border: pw.TableBorder(
        horizontalInside: pw.BorderSide(color: PdfColors.grey200, width: 0.5),
      ),
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8),
      cellStyle: pw.TextStyle(fontSize: 8),
      headerDecoration: pw.BoxDecoration(color: PdfColors.grey100),
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.centerRight,
      },
    );
  }

  static pw.Widget _buildTotal(Order order) {
    // final netTotal = order.items
    //     .map((item) => 10 * item.quantity)
    //     .reduce((item1, item2) => item1 + item2);
    // final vatPercent = order.items.first;
    // final vat = netTotal * 0;
    // final total = netTotal + vat;

    return pw.Container(
      alignment: pw.Alignment.centerRight,
      child: pw.Column(
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(color: PdfColors.grey50),
                padding: pw.EdgeInsets.all(kSizeS),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Payment Method : ",
                      style: pw.TextStyle(fontSize: 8),
                    ),
                    pw.SizedBox(height: PdfPageFormat.cm * 0.3),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Account Number",
                              style: pw.TextStyle(fontSize: 8),
                            ),
                            pw.SizedBox(height: 3),
                            pw.Text(
                              "Account Name",
                              style: pw.TextStyle(fontSize: 8),
                            ),
                            pw.SizedBox(height: 3),
                            pw.Text(
                              "Bank name",
                              style: pw.TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                        pw.SizedBox(width: PdfPageFormat.cm * 2),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "6820705279",
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 3),
                            pw.Text(
                              "Fahmi Dwi Syahputra",
                              style: pw.TextStyle(fontSize: 8),
                            ),
                            pw.SizedBox(height: 3),
                            pw.Text(
                              "Bank Central Asia (BCA)",
                              style: pw.TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              pw.Spacer(),
              pw.Expanded(
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Subtotal",
                              style: pw.TextStyle(fontSize: 8),
                            ),
                            pw.SizedBox(height: PdfPageFormat.cm * 0.3),
                            pw.Text("Ongkir", style: pw.TextStyle(fontSize: 8)),
                            pw.SizedBox(height: PdfPageFormat.cm * 0.3),
                            pw.Text("Total", style: pw.TextStyle(fontSize: 8)),
                          ],
                        ),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              "Rp. 1.000.000",
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(fontSize: 8),
                            ),
                            pw.SizedBox(height: PdfPageFormat.cm * 0.3),
                            pw.Text(
                              "Rp. 30.000",
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(fontSize: 8),
                            ),
                            pw.SizedBox(height: PdfPageFormat.cm * 0.3),
                            pw.Text(
                              "Rp. 1.030.000",
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                      ],
                    ),
                    pw.SizedBox(height: PdfPageFormat.cm * 0.5),
                    pw.Divider(
                      height: PdfPageFormat.cm * 0.5,
                      color: PdfColors.grey200,
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Paid down payment",
                              style: pw.TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Rp. 500.000",
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                      ],
                    ),
                    pw.SizedBox(height: PdfPageFormat.cm * 0.5),
                    pw.Divider(
                      height: PdfPageFormat.cm * 0.5,
                      color: PdfColors.grey200,
                    ),
                  ],
                ),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Spacer(),
              pw.Row(
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Total Payment",
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ],
                  ),
                  pw.SizedBox(width: PdfPageFormat.cm * 0.5),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Rp. 830.000",
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
