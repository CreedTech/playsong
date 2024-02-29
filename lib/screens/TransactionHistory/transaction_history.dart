import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_theme.dart';
import '../Wallet/wallet_page.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  static List<Tab> tabs = <Tab>[
    Tab(
      child: SizedBox(
        width: 60,
        height: 29,
        child: Center(
          child: Text(
            "All",
            textAlign: TextAlign.center,
            style: GoogleFonts.hind(
              // color: colorBlack,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
    Tab(
      child: SizedBox(
        width: 60,
        height: 29,
        child: Center(
          child: Text(
            "Credits",
            textAlign: TextAlign.center,
            style: GoogleFonts.hind(
              // color: colorWhite,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
    Tab(
      child: SizedBox(
        width: 60,
        height: 29,
        child: Center(
          child: Text(
            "Debits",
            textAlign: TextAlign.center,
            style: GoogleFonts.hind(
              // color: colorWhite,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
  ];

  List transactions = [
    {
      "amount": "#2,000.00",
      "status": "Credit",
      "description": "Credit from Omotola Jones, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#2,000.00",
      "status": "Debit",
      "description": "Buy Debit from Drey song, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#500.00",
      "status": "Debit",
      "description": "Buy Debit from Drey song, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#2,000.00",
      "status": "Credit",
      "description": "Credit from Omotola Jones, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#2,000.00",
      "status": "Credit",
      "description": "Credit from Omotola Jones, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#500.00",
      "status": "Debit",
      "description": "Buy Debit from Drey song, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#500.00",
      "status": "Debit",
      "description": "Buy Debit from Drey song, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#500.00",
      "status": "Debit",
      "description": "Buy Debit from Drey song, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#500.00",
      "status": "Debit",
      "description": "Buy Debit from Drey song, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#500.00",
      "status": "Debit",
      "description": "Buy Debit from Drey song, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#2,000.00",
      "status": "Credit",
      "description": "Credit from Omotola Jones, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#2,000.00",
      "status": "Credit",
      "description": "Credit from Omotola Jones, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#2,000.00",
      "status": "Credit",
      "description": "Credit from Omotola Jones, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#2,000.00",
      "status": "Credit",
      "description": "Credit from Omotola Jones, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#2,000.00",
      "status": "Credit",
      "description": "Credit from Omotola Jones, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#2,000.00",
      "status": "Credit",
      "description": "Credit from Omotola Jones, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#2,000.00",
      "status": "Credit",
      "description": "Credit from Omotola Jones, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#2,000.00",
      "status": "Credit",
      "description": "Credit from Omotola Jones, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#2,000.00",
      "status": "Credit",
      "description": "Credit from Omotola Jones, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#2,000.00",
      "status": "Credit",
      "description": "Credit from Omotola Jones, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#500.00",
      "status": "Debit",
      "description": "Buy Debit from Drey song, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#500.00",
      "status": "Debit",
      "description": "Buy Debit from Drey song, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
    {
      "amount": "#2,000.00",
      "status": "Credit",
      "description": "Credit from Omotola Jones, Transaction ID 126739",
      "date": "Sun, 12 Nov 2024 17:10:10 GMT"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
          title: Text(
            'Transaction  History',
            style: GoogleFonts.hind(
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: 200,
                  child: TabBar(
                    indicatorPadding: const EdgeInsets.symmetric(
                      vertical: 6,
                    ),
                    indicator: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(100.0), // Border radius
                      color: colorPrimary,
                    ),
                    padding: EdgeInsets.zero,
                    labelStyle: GoogleFonts.hind(
                      color: colorBlack,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    labelPadding: EdgeInsets.zero,
                    unselectedLabelColor: Colors.white,
                    unselectedLabelStyle: GoogleFonts.hind(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: tabs,
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    TransactionStatusView(transactions: transactions),
                    TransactionStatusView(
                        transactions: getTransactionsByStatus('Credit')),
                    TransactionStatusView(
                        transactions: getTransactionsByStatus('Debit')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List getTransactionsByStatus(String status) {
    return transactions
        .where((transaction) => transaction['status'] == status)
        .toList();
  }
}
