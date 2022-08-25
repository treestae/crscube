import 'package:flutter/material.dart';
import 'subject_data.dart';

class CustomRadioTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final IconData leading;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  const CustomRadioTile({required this.value, required this.groupValue, required this.onChanged, required this.leading, this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: _customRadioButton,
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? kThemeColor : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? kThemeColor : Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Icon(leading, color: isSelected ? Colors.white : Colors.black54),
    );
  }
}
