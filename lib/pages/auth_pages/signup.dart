import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Flex(
              mainAxisSize: MainAxisSize.min,
              direction: Axis.vertical,
              children: [
                Container(
                  height: 150,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.translate_sharp,
                      size: 85,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              "Create Account",
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              label: Text("Email"),
                              enabled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: Colors.blue[900]!, width: 2)
                              ),
                    
                            ),
                            obscureText: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}