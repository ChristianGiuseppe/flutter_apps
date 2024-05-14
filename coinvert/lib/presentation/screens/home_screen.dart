import 'package:coinvert/data/core/utils/extensions/%20datetime_extension.dart';
import 'package:coinvert/presentation/viewmodels/exchange_rate_vm.dart';
import 'package:coinvert/presentation/style/app_color_styles.dart';
import 'package:coinvert/presentation/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ExchangeRateViewModel exchangeRateViewModel;

  @override
  Widget build(BuildContext context) {
    exchangeRateViewModel = Provider.of<ExchangeRateViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/logo.svg",
            ),
            const SizedBox(width: 8.0),
            Text('Coinvert', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              title(context),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Last update',
                            style: Theme.of(context).textTheme.labelLarge),
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            exchangeRateViewModel.lastUpdated
                                .formatAsDayMonthYearWithSlash(),
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(child: inputCurrency()),
                  const SizedBox(width: 8.0),
                  dropdown(),
                ],
              ),
              buildList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget title(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text('Current\nExchange Rate',
          style: Theme.of(context).textTheme.titleSmall),
    );
  }

  Widget inputCurrency() {
    return TextFormField(
        style: AppTextStylesLight.labelSmall,
        initialValue: '${exchangeRateViewModel.amount}',
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.isNotEmpty) {
            exchangeRateViewModel.updateAmount(double.parse(value));
          }
        });
  }

  Widget dropdown() {
    return DropdownMenu<String>(
      expandedInsets: null,
      menuHeight: 200.0,
      initialSelection: exchangeRateViewModel.currentCurrency,
      dropdownMenuEntries: exchangeRateViewModel.currencies
          .map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(
          label: value,
          value: value,
          labelWidget: Text(value),
        );
      }).toList(),
      onSelected: (String? value) {
        if (value != null) exchangeRateViewModel.updateCurrency(value);
      },
    );
  }

  Widget buildList() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: exchangeRateViewModel.currencies.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColorLight.primary,
                  child: Text(exchangeRateViewModel.currencies[index]
                      .substring(0, 1)), // Mostra l'iniziale della valuta
                ),
                title: Text(
                  exchangeRateViewModel.currencies[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${exchangeRateViewModel.convert(exchangeRateViewModel.currencies[index])}",
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
