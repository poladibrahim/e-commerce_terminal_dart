import 'package:commerce_flutter/service/quotesService.dart';
import 'package:flutter/material.dart';

import '../model/quoteModel.dart';
import '../model/userModel.dart';

class QuotePage extends StatefulWidget {
  final User user;
  const QuotePage({required this.user});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  bool isLoading = true;
  int selectedButtonIndex = 0;
  List<Quote> quotes = [];
  QuotesService quotesService = QuotesService();

  @override
  void initState() {
    super.initState();
    loadData(0);
  }

  loadData(int skip) {
    quotesService.getLimitQuotes(skip).then((value) {
      setState(() {
        if (value != null) {
          quotes = value;
        }
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("quotes")),
      body: Visibility(
        visible: !isLoading,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: quotes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Text("${quotes[index].id}"),
                        title: Column(
                          children: [
                            Text(
                              "${quotes[index].author}",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text("${quotes[index].quote}"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20), // Add desired spacing between ListTiles
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    loadData(0);
                    setState(() {
                      selectedButtonIndex = 0; // Update the selected button index
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedButtonIndex == 0 ? Colors.black : null,
                  ),
                  child: const Text('1'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    loadData(25);
                    setState(() {
                      selectedButtonIndex = 1; // Update the selected button index
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedButtonIndex == 1 ? Colors.black : null,
                  ),
                  child: const Text('2'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    loadData(50);
                    setState(() {
                      selectedButtonIndex = 2; // Update the selected button index
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedButtonIndex == 2 ? Colors.black : null,
                  ),
                  child: const Text('3'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    loadData(75);
                    setState(() {
                      selectedButtonIndex = 3; // Update the selected button index
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedButtonIndex == 3 ? Colors.black : null,
                  ),
                  child: const Text('4'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
