import 'package:flutter/material.dart';
import 'package:gome_dropdown/gome_dropdown.dart';
import 'package:gome_search/gome_search.dart';
import 'package:gome_expand_collapse/gome_expand_collapse.dart';
import 'package:gome_intrinsic_height_memo/gome_intrinsic_height_memo.dart';
import 'package:gome_visibility_aware/gome_visibility_aware.dart';

void main() {
  runApp(const GomeShowcaseApp());
}

class GomeShowcaseApp extends StatelessWidget {
  const GomeShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gome Widget Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const GomeHomePage(),
    );
  }
}

class GomeHomePage extends StatefulWidget {
  const GomeHomePage({super.key});

  @override
  State<GomeHomePage> createState() => _GomeHomePageState();
}

class _GomeHomePageState extends State<GomeHomePage> {
  final List<String> _dropdownItems = ['Apple', 'Banana', 'Cherry'];
  String? _selectedFruit;
  String _searchQuery = '';
  bool _isExpanded = false;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gome Widgets')),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        children: [
          const Text('🔍 Gome Search'),
          const SizedBox(height: 8),
          Search(
            placeholder: 'Search fruits...',
            onSearchChanged: (text) {
              setState(() {
                _searchQuery = text;
              });
            },
          ),
          const SizedBox(height: 16),

          const Text('⬇️ Gome Dropdown'),
          const SizedBox(height: 8),
          Dropdown<String>(
            items: _dropdownItems,
            getName: (e) => e,
            selectedValue: _selectedFruit,
            onChanged: (value) => setState(() => _selectedFruit = value),
            labelText: 'Choose Fruit',
          ),
          const SizedBox(height: 16),

          const Text('📏 Gome Intrinsic Height Memo'),
          const SizedBox(height: 8),
          IntrinsicHeightMemo(
            child: Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'This widget caches its height after initial render.\nTry to rebuild it to test performance!',
              ),
            ),
          ),
          const SizedBox(height: 16),

          const Text('👁️ Gome Visibility Aware'),
          const SizedBox(height: 8),
          Container(
            height: 300,
            color: Colors.grey.withOpacity(0.1),
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return VisibilityAware(
                  index: index,
                  onVisibleChange: (visible) {
                    debugPrint('Item $index is visible: $visible');
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(16),
                    color: Colors.teal.withOpacity(0.2),
                    child: Text('Item #$index'),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          const Text('⬇️⬆️ Gome Expand Collapse'),
          const SizedBox(height: 8),
          ExpandCollapse(
            data: 'Tap to Expand',
            prefixIcon: Icons.info,
            fontSize: 18,
            isExpanded: _isExpanded,
            onChangeExpand: (val) => setState(() => _isExpanded = val),
            child: Container(
              width: double.infinity,
              color: Colors.grey.shade100,
              padding: const EdgeInsets.all(16),
              child: const Text('This section is now expanded!'),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
