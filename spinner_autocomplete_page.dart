import 'package:flutter/material.dart';

class SpinnerAutocompletePage extends StatefulWidget {
  const SpinnerAutocompletePage({super.key});

  @override
  State<SpinnerAutocompletePage> createState() => _SpinnerAutocompletePageState();
}

class _SpinnerAutocompletePageState extends State<SpinnerAutocompletePage> {
  String _selectedCity = 'Jakarta';
  final List<String> _cities = ['Jakarta', 'Bandung', 'Surabaya', 'Yogyakarta', 'Medan'];

  final TextEditingController _autocompleteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Autocomplete & Spinner')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Spinner (Dropdown)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            DropdownButton<String>(
              value: _selectedCity,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _selectedCity = value!;
                });
              },
              items: _cities.map((city) {
                return DropdownMenuItem(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
            ),
            SizedBox(height: 24),
            Text('Autocomplete', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return _cities.where((String option) {
                  return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                _autocompleteController.text = selection;
              },
              fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                _autocompleteController.text = controller.text;
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: 'Ketik nama kotamu',
                    border: OutlineInputBorder(),
                  ),
                  onEditingComplete: onEditingComplete,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
