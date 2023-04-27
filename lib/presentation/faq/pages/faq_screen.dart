import 'package:flutter/material.dart';

import '../../../export.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({
    Key? key,
  }) : super(key: key);

  @override
  FaqScreenState createState() => FaqScreenState();
}

class FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<FaqCubit>().fetchFaq();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: BlocConsumer<FaqCubit, FaqState>(
            listener: (context, state) {

            },
            builder: (context, state) {
              return state.faqStatus.isSubmissionSuccess
                  ? ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SpaceHeight(10);
                      },
                      scrollDirection: Axis.vertical,
                      itemCount: state.faqList!.length,
                      //physics:  ScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8).copyWith(bottom: 120),
                      itemBuilder: (context, index) {
                        var faqItem = state.faqList![index];
                        return  Container(decoration:  BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)
                          ),

                        ),
                          child: ExpansionTile(
                            title: Text('${faqItem.title}', style: kHeading4,),
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(left: 15, bottom: 20), child: Text("${faqItem.description}", style: kSubtitle1,),)
                            ],
                          ));
                      },
                    )
                  :state.faqStatus.isSubmissionFailure?Center(child: CustomError(errorMessage: state.message!,),):Center(child: AppLoadingIndicator());
            }));
  }
}
