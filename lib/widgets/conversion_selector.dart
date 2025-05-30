import 'package:flutter/material.dart';

class ConversionSelector extends StatelessWidget {
  final bool isFahrenheitToCelsius;
  final ValueChanged<bool> onChanged;

  const ConversionSelector({
    Key? key,
    required this.isFahrenheitToCelsius,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Conversion:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile<bool>(
                title: const Text(
                  'Fahrenheit to Celsius',
                  style: TextStyle(fontSize: 10),
                ),
                value: true,
                groupValue: isFahrenheitToCelsius,
                onChanged: (bool? value) => onChanged(value!),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Expanded(
              child: RadioListTile<bool>(
                title: const Text(
                  'Celsius to Fahrenheit',
                  style: TextStyle(fontSize: 10),
                ),
                value: false,
                groupValue: isFahrenheitToCelsius,
                onChanged: (bool? value) => onChanged(value!),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
