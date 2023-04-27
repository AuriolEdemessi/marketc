import 'package:marketscc/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../export.dart';
import '../widget/parametre_widget.dart';
import '../widget/password_widget.dart';
import 'portefeuilles_screen.dart';


class ProfilScreen extends StatefulWidget {
  const ProfilScreen({
    Key? key,
  }) : super(key: key);

  @override
  ProfilScreenState createState() => ProfilScreenState();
}

class ProfilScreenState extends State<ProfilScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  int _selectedTab = 0;

  bool seeAll = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);

    _tabController.addListener((){
      if (!_tabController.indexIsChanging){
        setState(() {
          _selectedTab = _tabController.index;
        });
      }
    });

    Future.microtask(() {
      //context.read<ProfilCubit>().fetchUser();
    });

  }


  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();



  @override
  Widget build(BuildContext context) {
    return  ScaffoldMessenger(
      key: scaffoldMessengerKey,
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: BlocConsumer<ProfilCubit, ProfilState>(

          listener: (context, state){
            if(state.status.isSubmissionFailure){
              loadingOverlay.hide();
              buildWhitePopUpMessage(message: "${state.message?.debug}");
            }else if(state.status.isSubmissionSuccess){
              loadingOverlay.hide();
            }else if(state.updateStatus.isSubmissionSuccess){
              loadingOverlay.hide();
              buildWhitePopUpMessage(message: '${state.message?.release}');
             // buildWhitePopUpMessage(message: '${state.message?.release}');
            }else{
              loadingOverlay.show(context);
            }
          },
          builder:(context, state){
            if(state.status.isSubmissionFailure){
              return CustomError(errorMessage: state.message!);
            }else if(state.status.isSubmissionSuccess){
              return  DefaultTabController(
                  length: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SpaceHeight(10),
                      TabBar(
                        indicatorColor: AppColors.white,
                        controller: _tabController,
                        labelPadding: const EdgeInsets.all(0.0),
                        tabs: [
                          _getTab(0, const Text("Profile")),
                          _getTab(1, const Text("Mes Portefeuilles")),
                          _getTab(2, const Text("Mot de passe")),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children:  [
                            ParametreWidget(userData: state.userResponse!,),
                            PortefeuillesScreen(),
                            PasswordWidget(),
                          ],
                        ),
                      ),
                    ],
                  ));
            } else if(state.status.isSubmissionInProgress){
              return Center(child: AppLoadingIndicator());
            }else{
              return Center(child: AppLoadingIndicator());
            }
          },

        ),),
    );
  }

  _getTab(index, child) {
    return Tab(
      child: SizedBox.expand(
        child: Container(
          alignment: Alignment.center,
          child: child,
          decoration: BoxDecoration(
              color: (_selectedTab == index ? AppColors.primary : AppColors.primary.withOpacity(0.5)),
              //borderRadius: _generateBorderRadius(index)
          ),
        ),
      ),
    );


  }


/*  void showInSnackBar(String value) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(value),
    ));}*/
}







