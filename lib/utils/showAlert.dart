import 'package:flutter/material.dart';

void showAlert(context, title, description) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Oke", style: TextStyle(color: Colors.white)),
              )
            ],
            backgroundColor: Color.fromARGB(255, 69, 89, 217),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            title: Text(title),
            content: Container(
              child: Text(description),
            ),
          ));
}
