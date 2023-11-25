import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({
    Key? key,
    required this.backgroundImageUrl,
    required this.descriptionText,
    required this.title,
    required this.releaseDate,
    required this.popularity,
  }) : super(key: key);

  final String backgroundImageUrl;
  final String descriptionText;
  final String title;
  final String releaseDate;
  final String popularity;

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  double _dy = 0.0;
  final double cardHeight = 480.0; 
  final double maxCardMovement = 50.0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
      ),
      body: Stack(
        children: [
          Image.network(
            widget.backgroundImageUrl,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: cardHeight,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  setState(() {
                    _dy += details.primaryDelta!;
                    _dy = _dy.clamp(
                        -maxCardMovement, 0.0); 
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: AnimatedContainer(
                    // color: Colors.black,
                    duration: Duration(milliseconds: 300),
                    height: cardHeight,
                    transform: Matrix4.translationValues(0, _dy, 0),
                    child: Card(
                      color: Colors.black54,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "${formatReleaseDate(widget.releaseDate)}",
                              // 'Release Date: ${widget.releaseDate}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            // SizedBox(height: 8),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '${widget.popularity.substring(0, 2)}%',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(width: 80),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "NA",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),

                                // Spacer(),
                              ],
                            ),
                            Text(
                              widget.descriptionText,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatReleaseDate(String releaseDate) {
    final dateTime = DateTime.tryParse(releaseDate);
    if (dateTime == null) {
      return "-";
    }
    return DateFormat("MMMM dd, yyyy").format(dateTime);
  }
}
