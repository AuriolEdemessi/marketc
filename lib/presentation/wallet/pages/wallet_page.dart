import 'package:flutter/material.dart';

import '../../../export.dart';
import '../../widgets/image_container.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key, required this.wallet}) : super(key: key);
  final List<Wallet> wallet;

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Tableau de bord',
              style: kHeading2.copyWith(fontSize: 15),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.separated(
                separatorBuilder: (context, index) => const SpaceHeight(5),
                scrollDirection: Axis.vertical,
                itemCount: widget.wallet.length,
                shrinkWrap: true,
                // padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              right: 10,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: ImageContainer(
                                  url: "${widget.wallet[index].currencyImage}"),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Text("${widget.wallet[index].deviseSymbol}"),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(Icons.arrow_downward),
                                    Text(
                                        "${widget.wallet[index].totalPurchase}"),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(Icons.arrow_upward),
                                    Text("${widget.wallet[index].totalSale}"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
