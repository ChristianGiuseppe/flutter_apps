import 'package:flutter/material.dart';
import 'package:meals_app/widget/main_drawer.dart';

class Settings extends StatefulWidget {
  static const routeName = '/settings';
  Settings({Key? key, required this.setFilter, this.filter});
  final Function setFilter;
  final filter;
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _vegetarian = false;
  bool _glutenFree = false;
  bool _vegan = false;
  bool _lactose = false;

  Widget buildToogle(String title, String subtitle, bool value,
      Function(bool value) onChange) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChange);
  }

  @override
  void initState() {
    _vegetarian = widget.filter['vegetarian'];
    _glutenFree = widget.filter['gluten'];
    _vegan = widget.filter['vegan'];
    _lactose = widget.filter['lactose'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Map<String, bool> filters = {
                'gluten': _glutenFree,
                'lactose': _lactose,
                'vegan': _vegan,
                'vegetarian': _vegetarian
              };

              widget.setFilter(filters);
            },
            icon: Icon(Icons.save_rounded),
          )
        ],
        title: Text(
          'Filters',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text('Adjust your meal selection.',
                style: Theme.of(context).textTheme.displayLarge),
          ),
          Expanded(
            child: ListView(
              children: [
                buildToogle(
                    'Gluten-Free',
                    'Only include gluten-free meals.',
                    _glutenFree,
                    (value) => {
                          setState(() {
                            _glutenFree = value;
                          })
                        }),
                buildToogle(
                    'Vegetarian',
                    'Only include vegetarian meals.',
                    _vegetarian,
                    (value) => {
                          setState(() {
                            _vegetarian = value;
                          })
                        }),
                buildToogle(
                    'Vegan',
                    'Only include Vegan meals.',
                    _vegan,
                    (value) => {
                          setState(() {
                            _vegan = value;
                          })
                        }),
                buildToogle(
                    'Lactose',
                    'Only include lactose meals.',
                    _lactose,
                    (value) => {
                          setState(() {
                            _lactose = value;
                          })
                        }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
