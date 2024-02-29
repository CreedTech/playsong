import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_theme.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
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
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image.asset(
                'assets/images/playsong_logo.png',
                width: 64,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                'Transaction  History',
                style: GoogleFonts.hind(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.close,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, top: 24, right: 16, bottom: 24),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/icons/account_banner.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff724400),
                        Color(0xffD0A200),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Playsong Wallet',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.hind(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                '#12,000.00',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.hind(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 27,
                            height: 27,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(1000),
                            ),
                            child: Image.asset(
                              'assets/icons/exchange.png',
                              width: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                // add_funds
                                 onTap: () {
                                  Navigator.of(context).pushNamed('/add_funds');
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 27,
                                      height: 27,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(1000),
                                      ),
                                      child: Image.asset(
                                        'assets/icons/add.png',
                                        width: 14,
                                      ),
                                    ),
                                    Text(
                                      'Add',
                                      style: GoogleFonts.hind(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 27,
                                    height: 27,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(1000),
                                    ),
                                    child: Image.asset(
                                      'assets/icons/send.png',
                                      width: 14,
                                    ),
                                  ),
                                  Text(
                                    'Send',
                                    style: GoogleFonts.hind(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/withdraw');
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 27,
                                      height: 27,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                      ),
                                      child: Image.asset(
                                        'assets/icons/withdraw.png',
                                        width: 14,
                                      ),
                                    ),
                                    Text(
                                      'Withdraw',
                                      style: GoogleFonts.hind(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 27,
                            height: 27,
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(1000),
                            ),
                            child: Image.asset(
                              'assets/icons/notifications.png',
                              width: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  14,
                  16,
                  5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Transaction History',
                      style: GoogleFonts.hind(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/transaction_history');
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 3.0,
                          vertical: 1.0,
                        ),
                        color: colorButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 4),
                          child: Text(
                            'SEE ALL',
                            style: GoogleFonts.hind(
                              color: Theme.of(context).primaryColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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

class TransactionStatusView extends StatefulWidget {
  final List transactions;
  const TransactionStatusView({super.key, required this.transactions});

  @override
  State<TransactionStatusView> createState() => _TransactionStatusViewState();
}

class _TransactionStatusViewState extends State<TransactionStatusView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 32,
      ),
      child: widget.transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "You have no transaction history",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: widget.transactions.length,
              // shrinkWrap: true,
              itemBuilder: (context, index) {
                final transaction = widget.transactions[index];
                // print(transaction);
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: transaction['status'] == "Credit"
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(200),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    transaction['description'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  width: 180,
                                  child: Text(
                                    transaction['date'],
                                    style: TextStyle(
                                      color: const Color(0xffC3C3C3),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              transaction['amount'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
