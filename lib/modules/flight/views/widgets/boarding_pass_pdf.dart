import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../models/flight_details_model.dart';

/// Generates and saves a printable airline-style boarding pass PDF
Future<void> saveBoardingPassPdf(
    FlightDetailsResponse details,
    ) async {
  final pdf = pw.Document();

  final flight = details.data?.flightDetails;
  final booking = details.data?.bookingInfo;
  final passengers = details.data?.passengers ?? [];
  final departure = flight?.departure;
  final arrival = flight?.arrival;

  if (flight == null ||
      booking == null ||
      departure == null ||
      arrival == null) {
    throw Exception('Flight details are incomplete');
  }

  pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          build: (context) {
            return pw.Stack(
              children: [
            /// Main Ticket
            pw.Container(
            decoration: pw.BoxDecoration(
              color: PdfColors.white,
              borderRadius: pw.BorderRadius.circular(24),
              border: pw.Border.all(
                color: PdfColors.grey300,
                width: 1.5,
              ),
            ),
            child: pw.Column(
            crossAxisAlignment:
            pw.CrossAxisAlignment.start,
            children: [
            /// ==========================
            /// HEADER
            /// ==========================
            pw.Container(
            width: double.infinity,
            padding:
            const pw.EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
            ),
            decoration: pw.BoxDecoration(
            color: PdfColors.blue800,
            borderRadius:
            const pw.BorderRadius.only(
            topLeft: pw.Radius.circular(24),
            topRight: pw.Radius.circular(24),
            ),
            ),
            child: pw.Column(
            children: [
            pw.Text(
            'BOARDING PASS',
            style: pw.TextStyle(
            color: PdfColors.white,
            fontSize: 24,
            fontWeight:
            pw.FontWeight.bold,
            letterSpacing: 2,
            ),
            ),
            pw.SizedBox(height: 6),
            pw.Text(
            flight.airlineName,
            style: const pw.TextStyle(
            color: PdfColors.white,
            fontSize: 13,
            ),
            ),
            ],
            ),
            ),

            pw.Padding(
            padding:
            const pw.EdgeInsets.all(24),
            child: pw.Column(
            children: [
            /// ==========================
            /// ROUTE SECTION
            /// ==========================
            pw.Row(
            mainAxisAlignment:
            pw.MainAxisAlignment
                .spaceBetween,
            children: [
            /// Departure
            pw.Column(
            children: [
            pw.Text(
            departure
                .airportCode,
            style:
            pw.TextStyle(
            fontSize: 34,
            fontWeight:
            pw.FontWeight
                .bold,
            ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
            departure.city,
            style:
            const pw.TextStyle(
            fontSize: 12,
            color: PdfColors
                .grey,
            ),
            ),
            ],
            ),

            /// Plane + Line
            pw.Expanded(
            child: pw.Padding(
            padding:
            const pw.EdgeInsets
                .symmetric(
            horizontal: 16,
            ),
            child: pw.Row(
            children: [
            pw.Expanded(
            child:
            pw.Container(
            height: 1,
            color:
            PdfColors
                .grey400,
            ),
            ),
            pw.Padding(
            padding:
            const pw
                .EdgeInsets
                .symmetric(
            horizontal: 8,
            ),
            child: pw.Text(
            '>',
            style:
            const pw
                .TextStyle(
            fontSize: 18,
            ),
            ),
            ),
            pw.Expanded(
            child:
            pw.Container(
            height: 1,
            color:
            PdfColors
                .grey400,
            ),
            ),
            ],
            ),
            ),
            ),

            /// Arrival
            pw.Column(
            children: [
            pw.Text(
            arrival.airportCode,
            style:
            pw.TextStyle(
            fontSize: 34,
            fontWeight:
            pw.FontWeight
                .bold,
            ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
            arrival.city,
            style:
            const pw.TextStyle(
            fontSize: 12,
            color: PdfColors
                .grey,
            ),
            ),
            ],
            ),
            ],
            ),

            pw.SizedBox(height: 30),

            /// ==========================
            /// PERFORATION
            /// ==========================
            _ticketDivider(),

            pw.SizedBox(height: 30),

            /// ==========================
            /// FLIGHT DETAILS
            /// ==========================
            pw.Row(
            children: [
            pw.Expanded(
            child: _info(
            'FLIGHT',
            flight.flightNumber,
            ),
            ),
            pw.SizedBox(width: 20),
            pw.Expanded(
            child: _info(
            'DATE',
            booking.bookingDate,
            ),
            ),
            ],
            ),

            pw.SizedBox(height: 22),

            pw.Row(
            children: [
            pw.Expanded(
            child: _info(
            'DEPARTURE',
            departure.time,
            ),
            ),
            pw.SizedBox(width: 20),
            pw.Expanded(
            child: _info(
            'ARRIVAL',
            arrival.time,
            ),
            ),
            ],
            ),

            pw.SizedBox(height: 22),

            pw.Row(
            children: [
            pw.Expanded(
            child: _info(
            'TERMINAL',
            flight.terminal,
            ),
            ),
            pw.SizedBox(width: 20),
            pw.Expanded(
            child: _info(
            'GATE',
            flight.gate,
            ),
            ),
            pw.SizedBox(width: 20),
            pw.Expanded(
            child: _info(
            'CLASS',
            flight.classType,
            ),
            ),
            ],
            ),

            pw.SizedBox(height: 22),

            pw.Row(
            children: [
            pw.Expanded(
            child: _info(
            'AIRCRAFT',
            flight.aircraftType,
            ),
            ),
            pw.SizedBox(width: 20),
            pw.Expanded(
            child: _info(
            'DURATION',
            flight.duration,
            ),
            ),
            ],
            ),

            pw.SizedBox(height: 32),

            /// ==========================
            /// PASSENGERS TITLE
            /// ==========================
            pw.Align(
            alignment:
            pw.Alignment.centerLeft,
            child: pw.Text(
            'PASSENGERS (${passengers.length})',
            style: pw.TextStyle(
            fontSize: 14,
            fontWeight:
            pw.FontWeight.bold,
            color:
            PdfColors.grey700,
            ),
            ),
            ),

            pw.SizedBox(height: 16),

            /// Passenger cards will be added
            /// in Part 2
              ...passengers.map(
                    (p) => pw.Padding(
                  padding:
                  const pw.EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: pw.Container(
                    width: double.infinity,
                    padding:
                    const pw.EdgeInsets.all(
                      14,
                    ),
                    decoration:
                    pw.BoxDecoration(
                      color: PdfColors.grey100,
                      borderRadius:
                      pw.BorderRadius
                          .circular(12),
                      border: pw.Border.all(
                        color:
                        PdfColors.grey300,
                      ),
                    ),
                    child: pw.Row(
                      mainAxisAlignment:
                      pw.MainAxisAlignment
                          .spaceBetween,
                      children: [
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment:
                            pw.CrossAxisAlignment
                                .start,
                            children: [
                              pw.Text(
                                '${p.title} ${p.name}',
                                style:
                                pw.TextStyle(
                                  fontSize: 13,
                                  fontWeight:
                                  pw.FontWeight
                                      .bold,
                                ),
                              ),
                              pw.SizedBox(
                                height: 4,
                              ),
                              pw.Text(
                                'Passenger ${p.passengerNumber}',
                                style:
                                const pw.TextStyle(
                                  fontSize: 10,
                                  color:
                                  PdfColors
                                      .grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.Column(
                          children: [
                             pw.Text(
                              'SEAT',
                              style:
                              pw.TextStyle(
                                fontSize: 10,
                                color:
                                PdfColors
                                    .grey,
                              ),
                            ),
                            pw.SizedBox(
                              height: 4,
                            ),
                            pw.Text(
                              p.seat,
                              style:
                              pw.TextStyle(
                                fontSize: 18,
                                fontWeight:
                                pw.FontWeight
                                    .bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              pw.SizedBox(height: 22),

              /// ==========================
              /// BOOKING REFERENCE
              /// ==========================
              pw.Text(
                'BOOKING REFERENCE',
                style: pw.TextStyle(
                  fontSize: 11,
                  color: PdfColors.grey,
                  fontWeight:
                  pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 6),

              pw.Text(
                booking.bookingReference,
                style: pw.TextStyle(
                  fontSize: 18,
                  letterSpacing: 2,
                  fontWeight:
                  pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 24),

              /// ==========================
              /// BARCODE
              /// ==========================
              if (booking.barcode.isNotEmpty)
                pw.Center(
                  child: pw.SvgImage(
                    svg: booking.barcode,
                    width: 260,
                    height: 80,
                  ),
                ),

              pw.SizedBox(height: 14),

              pw.Center(
                child: pw.Text(
                  booking.bookingReference,
                  style: pw.TextStyle(
                    fontSize: 16,
                    letterSpacing: 3,
                    fontWeight:
                    pw.FontWeight.bold,
                  ),
                ),
              ),

              pw.SizedBox(height: 14),

              pw.Text(
                'Total Passengers: ${booking.totalPassengers}',
                style:
                const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey,
                ),
              ),
            ],
            ),
            ),
            ],
            ),
            ),

                /// ==========================
                /// LEFT TICKET CUTOUT
                /// ==========================
                pw.Positioned(
                  left: -18,
                  top: 260,
                  child: pw.Container(
                    width: 36,
                    height: 36,
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.white,
                      shape: pw.BoxShape.circle,
                    ),
                  ),
                ),

                /// ==========================
                /// RIGHT TICKET CUTOUT
                /// ==========================
                pw.Positioned(
                  right: -18,
                  top: 260,
                  child: pw.Container(
                    width: 36,
                    height: 36,
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.white,
                      shape: pw.BoxShape.circle,
                    ),
                  ),
                ),
              ],
            );
          },
      ),
  );

  final bytes = await pdf.save();



  final directory =
  await getApplicationDocumentsDirectory();

  final file = File(
    '${directory.path}/boarding_pass_${booking.bookingReference}.pdf',
  );

  await file.writeAsBytes(bytes);

  await OpenFilex.open(file.path);
}

/// ==========================
/// INFO ITEM
/// ==========================
pw.Widget _info(
    String title,
    String value,
    ) {
  return pw.Column(
    crossAxisAlignment:
    pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        title,
        style: const pw.TextStyle(
          fontSize: 10,
          color: PdfColors.grey,
        ),
      ),
      pw.SizedBox(height: 6),
      pw.Text(
        value,
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight:
          pw.FontWeight.bold,
        ),
      ),
    ],
  );
}

/// ==========================
/// DOTTED TICKET DIVIDER
/// ==========================
pw.Widget _ticketDivider() {
  return pw.Row(
    children: List.generate(
      42,
          (index) => pw.Expanded(
        child: pw.Container(
          margin:
          const pw.EdgeInsets.symmetric(
            horizontal: 1,
          ),
          height: 1,
          color: PdfColors.grey400,
        ),
      ),
    ),
  );
}