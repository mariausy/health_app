import 'package:flutter/material.dart' show AlertDialog, BuildContext, Card, EdgeInsets, Navigator, Padding, Text, TextButton, TextStyle, showDialog;
import 'dart:math';
import 'package:flutter/material.dart';
 
 // A list of quotes
  final List<String> quotes = [
    "The best way to predict the future is to create it.",
    "You only live once, but if you do it right, once is enough.",
    "To live is the rarest thing in the world. Most people exist, that is all.",
    "Think like a proton, always positiv",
    "Life is like riding a bicycle. To keep your balance you must keep moving. - Elbert Einstein", 
    "If you can change your mind, you can change your life. -William James", 
    "Nothing is impossible, the word itself says ‘I’m possible. -Audrey Hepborne", 
    "Choose to be optimistic, it feels better. - Dalai Lama", 
    "You can, you should, and if you’re brave enough to start, you will. -Stephen King", 
    "Happiness is not by chance, but by choice. -Jim Rohn", 
    "The bad news is time flies. The good news is you're the pilot.-Michael Altshuler",
    "I have not failed. I've just found 10,000 ways that won't work. -Thomas A. Edison", 
    "Don't count the days, make the days count. - Muhammad Ali"
  ];

    // Creating a function to show the dialog
  void showQuoteDialog(BuildContext context) {
    final random = Random();
    final quote = quotes[random.nextInt(quotes.length)];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                quote,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void showCard(BuildContext context, String title, String content) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Card(
        margin: EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                content,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}



