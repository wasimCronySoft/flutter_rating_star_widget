import 'package:flutter/material.dart';
import 'package:flutter_rating_star_widget/painter/star_border_painter.dart';
import 'package:flutter_rating_star_widget/clipper/star_clipper.dart';

// RatingStarWidget is a StatefulWidget to handle interactive star rating with a title description.
class RatingStarWidget extends StatefulWidget {
  final int maxRating; // Maximum number of stars to show
  final double initialRating; // Initial rating value
  final ValueChanged<double>?
      onRatingSelected; // Callback when the user selects a rating
  final List<String>? titleList;
  const RatingStarWidget({
    super.key,
    this.maxRating = 5,
    this.initialRating = 0.0,
    this.onRatingSelected,
    this.titleList,
  });

  @override
  State<RatingStarWidget> createState() => _RatingStarWidgetState();
}

// State class for RatingStarWidget
class _RatingStarWidgetState extends State<RatingStarWidget> {
  late double _currentRating; // Current selected rating value

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating; // Set the initial rating
  }

  // Handles logic when a star is clicked
  void _handleRatingUpdate(int index) {
    if (widget.onRatingSelected != null) {
      setState(() {
        // If clicking the same star resets it; otherwise set the new star rating
        if (_currentRating == index + 1.0) {
          _currentRating = 0.0;
        } else {
          _currentRating = index + 1.0;
        }
      });

      // Notify parent widget about rating change via callback
      widget.onRatingSelected!(_currentRating);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine responsive space and star size based on the device type
    double space = 10;

    double starSize = 40;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.maxRating,
            (index) => InkWell(
              onTap: () => _handleRatingUpdate(index), // Handle star tap
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: space),
                child: Column(
                  children: [
                    // Create a clickable star with a rating logic
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipPath(
                          clipper: StarClipper(), // Clip the star shape
                          child: Container(
                            width: starSize,
                            height: starSize,
                            color: index < _currentRating
                                ? Colors
                                    .amber.shade600 // Highlight selected stars
                                : Colors.transparent,
                          ),
                        ),
                        CustomPaint(
                          size: Size(starSize, starSize),
                          painter: StarBorderPainter(
                            borderColor:
                                Colors.orange.shade600, // Draw star border
                          ),
                        ),
                      ],
                    ),
                    // Display corresponding textual title below the star
                    if ((widget.titleList?.length ?? 0) > 0 &&
                        widget.maxRating == (widget.titleList?.length ?? 0))
                      Text(widget.titleList![index]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
