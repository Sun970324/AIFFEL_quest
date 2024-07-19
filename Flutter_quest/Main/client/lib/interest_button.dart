import 'package:flutter/material.dart';
import '../../../constants/sizes.dart';

class InterestButton extends StatefulWidget {
  const InterestButton({
    Key? key,
    required this.genre,
    required this.isSelected,
  }) : super(key: key);

  final String genre;
  final bool isSelected;
  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size16,
        horizontal: Sizes.size24,
      ),
      decoration: BoxDecoration(
        color:
            widget.isSelected ? Theme.of(context).primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(
          Sizes.size32,
        ),
        border: Border.all(
          color: Colors.black.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Text(
        widget.genre,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: widget.isSelected ? Colors.white : Colors.black87),
      ),
    );
  }
}
