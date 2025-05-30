import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TemperatureSection extends StatelessWidget {
  final TextEditingController inputController;
  final double? convertedValue;
  final VoidCallback onInputChanged;

  const TemperatureSection({
    Key? key,
    required this.inputController,
    required this.convertedValue,
    required this.onInputChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Input field
        TextField(
          controller: inputController,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
            signed: true,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
          ],
          decoration: InputDecoration(
            hintText: 'Enter temperature',
            prefixIcon: const Icon(Icons.thermostat_outlined),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          style: const TextStyle(fontSize: 16),
          onChanged: (_) => onInputChanged(),
        ),

        const SizedBox(height: 12),

        // Equals sign with animation
        Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              '=',
              key: ValueKey<double?>(convertedValue),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Result display with animation
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color:
                convertedValue != null
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                    : Colors.grey.shade100,
            border: Border.all(
              color:
                  convertedValue != null
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade300,
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              convertedValue?.toStringAsFixed(1) ?? '',
              key: ValueKey<double?>(convertedValue),
              style: TextStyle(
                fontSize: 16,
                color:
                    convertedValue != null
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                fontWeight:
                    convertedValue != null
                        ? FontWeight.bold
                        : FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
