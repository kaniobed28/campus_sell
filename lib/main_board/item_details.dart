import 'package:flutter/material.dart';
import 'dart:async'; // Import Timer class

class ItemDetailsWidget extends StatefulWidget {
  @override
  _ItemDetailsWidgetState createState() => _ItemDetailsWidgetState();
}

class _ItemDetailsWidgetState extends State<ItemDetailsWidget> {
  late int _currentIndex;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _colors.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  final List<Color> _colors = [
    Colors.cyan,
    Colors.yellow,
    Colors.orange,
  ];

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Item Details'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 1),
              height: screen_height * 0.4,
              decoration: BoxDecoration(
                color: _colors[_currentIndex],
              ),
            ),
            SizedBox(height: 20), // Spacer
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  _buildInfoContainer('Info 1'),
                  _buildInfoContainer('Info 2'),
                  _buildInfoContainer('Info 3'),
                  _buildInfoContainer('Info 4'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoContainer(String text) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}


