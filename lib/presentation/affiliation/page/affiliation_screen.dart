import 'package:flutter/material.dart';

import '../../../export.dart';

class AffiliationScreen extends StatefulWidget {
  const AffiliationScreen({Key? key}) : super(key: key);

  @override
  State<AffiliationScreen> createState() => _AffiliationScreenState();
}

class _AffiliationScreenState extends State<AffiliationScreen> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<AffiliationCubit>().fetchAffiliation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: BlocConsumer<AffiliationCubit, AffiliationState>(
              listener: (context, state) {},
              builder: (context, state) {
                return state.affiliationStatus.isSubmissionSuccess
                    ?  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Code affiliation",
                      style: kHeading3,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColors.grey),
                        borderRadius: BorderRadius.circular(RadiusSizes.r10)
                      ),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${context.read<ProfilCubit>().getUser!.username}",
                            style: kHeading3,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            FlutterClipboard.copy('${state.data?.metaData?.myRefer}').then(( value ) {
                              buildWhitePopUpMessage(message: "copier avec succès");
                            });
                          },
                        )
                      ],),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SpaceHeight(10);
                          },
                          scrollDirection: Axis.vertical,
                          itemCount: state.data!.metaData!.affiliation!.length,
                          //physics:  ScrollableScrollPhysics(),
                          shrinkWrap: true,
                          //padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            // var faqItem = state.faqList![index];
                            return Container(alignment: Alignment.center, height: 50, decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColors.primary1)), child: Text("${state.data!.metaData!.affiliation![index].username}"),);
                          },
                        ),
                      ),
                    ),
                  ],
                )
                    : state.affiliationStatus.isSubmissionFailure
                    ? Center(
                  child: CustomError(
                    errorMessage: state.message!,
                  ),
                )
                    : Center(child: AppLoadingIndicator());
              }),
        )


       );
  }
}
