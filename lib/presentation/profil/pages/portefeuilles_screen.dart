import 'package:marketscc/data/models/user_model.dart';
import 'package:flutter/material.dart';

import '../../../export.dart';
import '../../../main.dart';
import '../../common/clipboard.dart';

class PortefeuillesScreen extends StatefulWidget {
  const PortefeuillesScreen({Key? key}) : super(key: key);

  @override
  State<PortefeuillesScreen> createState() => _PortefeuillesScreenState();
}

class _PortefeuillesScreenState extends State<PortefeuillesScreen> {

  CurrencyType? _selectedTypeDevise;
  Currencies? _selectedSubTypeDevise;
  //Statuts? _selectedStatuts;

  List<CurrencyType> currencyTypeList = [CurrencyType(currencyTypeName: "Aucun")];
  List<Currencies> currenciesListe= [Currencies(currencyName: "Aucun")];


/*  List<Statuts> statusList = [
    Statuts(label:"Activé", id: 1),
    Statuts(label:"Désativé", id:2),
    Statuts(label:"Aucun", id:3),
  ];*/

  TextEditingController adressePortefeuilleController = TextEditingController();

  //TextEditingController adresseMobileController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController adressDomicileController = TextEditingController();

  TextEditingController otherAdressController = TextEditingController();

 // TextEditingController nomReceveurController = TextEditingController();
  TextEditingController nomBanqueController = TextEditingController();
  TextEditingController ibanController = TextEditingController();
  TextEditingController bicController = TextEditingController();

  bool isChecked = false;

  late UserModel userModel;

  @override
  void initState() {
    Future.microtask(() {
      context.read<PortefeuillesCubit>().fetchCurrencyTypeList();
    });
    userModel = context.read<ProfilCubit>().getUser!;

    super.initState();
  }

  List<CurrencyType?> getStates(list) => list.map((map) => CurrencyType.fromJson(map)).map((item) => item.currencyTypeName).toList();

  TextEditingController cryptoAdressController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldMessengerKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldMessengerKey,
      body: BlocConsumer<PortefeuillesCubit, PortefeuillesState>(
          listener: (context, state) {
        if (state.currrencyTypeListStatus.isSubmissionSuccess) {
          currencyTypeList= List.from(currencyTypeList)..addAll(state.currrencyTypeList!);
        }else if(state.createWalletStatus.isSubmissionInProgress){
        }else if(state.createWalletStatus.isSubmissionSuccess){
          context.read<ProfilCubit>().setUserData(state.user!);
          _selectedTypeDevise = null;
          currenciesListe = [];
          _selectedSubTypeDevise = null;
          currenciesListe =[Currencies(currencyName: "Aucun")];
          buildWhitePopUpMessage(message: "Votre adresse portefeuille a été mise à jour avec succès");
          context.read<PortefeuillesCubit>().reset();
        }else if(state.createWalletStatus.isSubmissionFailure){

          String message ="";

          state.message?.errors?.forEach((element) {
            message+=element;
          });

          buildWhitePopUpMessage(message: "${message}");
        }
      }, builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Configuration de vos adresses",
                      style: kHeading3,
                    ),
                    const SpaceHeight(10),
                    Text(
                      "Veuillez vous assurer d'ajouter vos portefeuilles préférés afin de l'utiliser pour vos transactions.",
                      style: kSubtitle2,
                    ),
                    const SpaceHeight(10),
                    Text(
                      "Type de devise",
                      style: kSubtitle1,
                    ),
                    const SpaceHeight(10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: AppColors.grey)),
                      child: DropdownButtonFormField<CurrencyType>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          //fillColor: Colors.grey[300],
                        ),
                        hint: Text('Aucun'),
                        isExpanded: true,
                        isDense: true,
                        value: _selectedTypeDevise,
                        selectedItemBuilder: (BuildContext context) {
                          return currencyTypeList.map<Widget>((CurrencyType? item) {
                            return DropdownMenuItem(value: item, child: Text("${item?.currencyTypeName}"));
                          }).toList();
                        },
                        items: currencyTypeList.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text("${item.currencyTypeName}"),
                          );
                        }).toList(),
                        onChanged:(CurrencyType? value){
                          onTypeDeviseChange(value);
                        },
                      ),
                    ),
                    Visibility(
                        visible: _selectedTypeDevise != null && _selectedTypeDevise?.currencyTypeName != "Aucun",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SpaceHeight(10),
                            Text(
                              "Ma liste des portefeuilles ${_selectedTypeDevise?.currencyTypeName}",
                              style: kSubtitle1,
                            ),
                            const SpaceHeight(10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                  Border.all(width: 1, color: AppColors.grey)),
                              child: DropdownButtonFormField<Currencies>(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  //fillColor: Colors.grey[300],
                                ),
                                hint: Text('Choisir...'),
                                isExpanded: true,
                                isDense: true,
                                value: _selectedSubTypeDevise,
                                selectedItemBuilder: (BuildContext context) {
                                  return currenciesListe.map<Widget>((Currencies? item) {
                                    return DropdownMenuItem(
                                        value: item, child: Text("${item!.currencyName}"));
                                  }).toList();
                                },
                                items: currenciesListe.map((item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text("${item.currencyName}"),
                                  );
                                }).toList(),
                                onChanged: (value) => onSubTypeChange(value!),
                              ),
                            ),
                          ],
                        )),

                    // transfert bancaire
                    Visibility(
                        visible: _selectedTypeDevise != null &&
                            _selectedSubTypeDevise != null &&
                            _selectedSubTypeDevise!.currencyName != "Aucun" &&
                            _selectedTypeDevise!.currencyTypeId == 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SpaceHeight(10),
                            bankTransfert(),
                          ],
                        )),

                    //Transfert Express
                    Visibility(
                        visible:_selectedTypeDevise != null &&
                            _selectedSubTypeDevise != null &&
                            _selectedSubTypeDevise!.currencyName != "Aucun" &&
                            _selectedTypeDevise!.currencyTypeId == 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SpaceHeight(10),
                            transfertExpress(),
                          ],
                        )),

                    //Mobile Money
                    Visibility(
                        visible: _selectedTypeDevise != null &&
                            _selectedSubTypeDevise != null &&
                            _selectedSubTypeDevise!.currencyName != "Aucun" &&
                            _selectedTypeDevise!.currencyTypeId == 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SpaceHeight(10),
                            mobileMoney(_selectedSubTypeDevise),
                          ],
                        )),

                    //
                    //Carte bancaire
                    Visibility(
                        visible: _selectedTypeDevise != null &&
                            _selectedSubTypeDevise != null &&
                            _selectedSubTypeDevise!.currencyName != "Aucun" &&
                            _selectedTypeDevise!.currencyTypeId == 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SpaceHeight(10),
                            mobileMoney(_selectedSubTypeDevise),
                            const SpaceHeight(5),
                            Text("Votre adresse de réception des paiements reçu par carte bancaire.", style: kSubtitle1,),
                          ],
                        )),

                    //Crypto Monnaie
                    Visibility(
                      visible: _selectedTypeDevise != null &&
                          _selectedSubTypeDevise != null &&
                          _selectedSubTypeDevise!.currencyName != "Aucun" &&
                          _selectedTypeDevise!.currencyTypeId == 1,
                      child: Column(
                        children: [
                          const SpaceHeight(10),
                          InputTextField(
                            label: "Adresse portefeuille ou Numéro",
                            hintText: 'Adresse portefeuille ou Numéro',
                            keyboardType: TextInputType.text,
                            controller: adressePortefeuilleController,
                            isSuffixIcon: true,
                            suffixWidget: InkWell(
                              onTap: () {
                                FlutterClipboard.paste().then((value) {
                                  setState(() {
                                    adressePortefeuilleController.text = value;
                                  });
                                });
                              },
                              child: Icon(Icons.paste),
                            ),
                            error: null,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),

                    //Other Crypto Monnaie
                    Visibility(
                      visible: _selectedTypeDevise != null &&
                          _selectedSubTypeDevise != null &&
                          _selectedSubTypeDevise!.currencyName != "Aucun" &&
                          _selectedTypeDevise!.currencyTypeId == 6,
                      child: Column(
                        children: [
                          const SpaceHeight(10),
                          InputTextField(
                            label: "Adresse portefeuille ou Numéro",
                            hintText: 'Adresse portefeuille ou Numéro',
                            keyboardType: TextInputType.text,
                            controller: adressePortefeuilleController,
                            isSuffixIcon: true,
                            suffixWidget: InkWell(
                              onTap: () {
                                FlutterClipboard.paste().then((value) {
                                  setState(() {
                                    cryptoAdressController.text = value;
                                    // field.text = value;
                                    //  pasteValue = value;
                                  });
                                });
                              },
                              child: Icon(Icons.paste),
                            ),
                            error: null,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),

                    //button send
                    Visibility(
                        visible: _selectedSubTypeDevise != null &&
                            _selectedTypeDevise!.currencyTypeName != "Aucun" &&
                            _selectedSubTypeDevise != null &&
                            _selectedSubTypeDevise!.currencyName != "Aucun",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SpaceHeight(10),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isChecked = !isChecked;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      //color: AppColors.primary,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(RadiusSizes.r5)),
                                    ),
                                    child: isChecked
                                        ? const Icon(
                                      Icons.check_box,
                                      size: 24.0,
                                      color: AppColors.primary,
                                    )
                                        : const Icon(
                                      Icons.check_box_outline_blank,
                                      size: 24.0,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                //SpaceWidth(8),
                                Expanded(
                                    child: Text(
                                      "Je certifie être titulaire des comptes renseignés",
                                      style: kSubtitle2.copyWith(),
                                    ))
                              ],
                            ),
                            const SpaceHeight(10),
                            Center(
                              child: state.createWalletStatus.isSubmissionInProgress?AppLoadingIndicator():ButtonWidget(
                                  background: AppColors.primary,
                                  textColor: AppColors.white,
                                  text: "Envoyer",
                                  voidCallback: () async{
                                    Map<String, dynamic> body={};

                                    if(_selectedTypeDevise!=null && _selectedSubTypeDevise!=null){

                                      switch (_selectedTypeDevise!.currencyTypeId){
                                        case 1:
                                        case 6:
                                          if(adressePortefeuilleController.text.isNotEmpty){
                                            body = {
                                              "currency_type":_selectedTypeDevise?.currencyTypeId,
                                              "status":1,
                                              "currency_id":_selectedSubTypeDevise?.currencyId,
                                              "payment_address":adressePortefeuilleController.text,
                                            };
                                            if(isChecked){
                                              context.read<PortefeuillesCubit>().createWallet(body);
                                            }else{
                                              buildWhitePopUpMessage(message: "Veillez confirmer etre titulaire de l'adresse");
                                            }
                                          }else{
                                            buildWhitePopUpMessage(message: "Remplir correctement tous les champs");
                                          }
                                          break;

                                        case 2:
                                        case 5:
                                          if(phoneNumberController.text.isNotEmpty){
                                            body = {
                                              "currency_type":_selectedTypeDevise?.currencyTypeId,
                                              "currency_id":_selectedSubTypeDevise?.currencyId,
                                              "status":1,
                                              "payment_address":phoneNumberController.text,
                                            };
                                            if(isChecked){
                                              context.read<PortefeuillesCubit>().createWallet(body);
                                            }else{
                                              buildWhitePopUpMessage(message: "Veillez confirmer etre titulaire de l'adresse");
                                            }
                                          }else{
                                            buildWhitePopUpMessage(message: "Remplir correctement tous les champs");
                                          }
                                          break;
                                        case 3:
                                          if(phoneNumberController.text.isNotEmpty && nameController.text.isNotEmpty && adressDomicileController.text.isNotEmpty){
                                            body = {
                                              "status":1,
                                              "currency_type":_selectedTypeDevise?.currencyTypeId,
                                              "currency_id":_selectedSubTypeDevise?.currencyId,
                                              "payment_address":phoneNumberController.text,
                                              "account_holder":nameController.text,
                                              "home_adress":adressDomicileController.text,
                                              "country":userModel.country,
                                            };
                                            if(isChecked){
                                              context.read<PortefeuillesCubit>().createWallet(body);
                                            }else{
                                              buildWhitePopUpMessage(message: "Veillez confirmer etre titulaire de l'adresse");
                                            }
                                          }else{
                                            buildWhitePopUpMessage(message: "Remplir correctement tous les champs");
                                          }
                                          break;
                                        case 4:
                                          if(nameController.text.isNotEmpty && nomBanqueController.text.isNotEmpty && ibanController.text.isNotEmpty && bicController.text.isNotEmpty){
                                            body = {
                                              "status":1,
                                              "currency_type":_selectedTypeDevise?.currencyTypeId,
                                              "currency_id":_selectedSubTypeDevise?.currencyId,
                                              "account_holder":nameController.text,
                                              "banque_name":nomBanqueController.text,
                                              "iban":ibanController.text,
                                              "bic":bicController.text,
                                            };
                                            if(isChecked){
                                              context.read<PortefeuillesCubit>().createWallet(body);
                                            }else{
                                              buildWhitePopUpMessage(message: "Veillez confirmer etre titulaire de l'adresse");
                                            }

                                          }else{
                                            buildWhitePopUpMessage(message: "Remplir correctement tous les champs");
                                          }
                                          break;
                                        default:
                                          buildWhitePopUpMessage(message: "Moyen de paiement non supporté");
                                          break;
                                      }

                                    }else {
                                      buildWhitePopUpMessage(message: "Remplir correctement tous les champs");
                                    }
                                  },
                                ),
                            ),
                            const SpaceHeight(10),
                            Row(
                              children: [
                                Icon(
                                  Icons.warning,

                                ),
                                SpaceWidth(5),
                                Expanded(
                                    child: Text(
                                      "PS : Vos adresses sont utilisées par defaut pour tout achats ou ventes.",
                                      style: kSubtitle2,
                                    ))
                              ],
                            ),
                            const SpaceHeight(10),
                          ],
                        )),
                    const SpaceHeight(30),
                    Text(
                      "Mes adresses enregistrés",
                      style: kHeading3,
                    ),
                    ListeMesWallet(),
                    const SpaceHeight(100),
                  ],
                ),
              ),
            );
      }
      ),
    );
  }



  void onTypeDeviseChange(CurrencyType? state) {
    setState(() {
      _selectedTypeDevise = state;
      currenciesListe = [];
      _selectedSubTypeDevise = null;
      currenciesListe =[Currencies(currencyName: "Aucun")];
      currenciesListe = List.from(currenciesListe)..addAll(_selectedTypeDevise!.currencies!);
    });

  }

  void onSubTypeChange(Currencies district) {
    setState(() {
      _selectedSubTypeDevise = district;
    });
  }

  Widget otherElectronic() {
    return Column(
      children: [
        InputTextField(
          label: "Adresse portefeuille ou Numéro",
          hintText: 'Adresse portefeuille ou Numéro',
          keyboardType: TextInputType.text,
          controller: adressePortefeuilleController,
          isSuffixIcon: true,
          suffixWidget: InkWell(
            onTap: () {
              FlutterClipboard.paste().then((value) {
                setState(() {
                });
              });
            },
            child: Icon(Icons.paste),
          ),
          error: null,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget bankTransfert() {
    return Column(
      children: [
        InputTextField(
          label: "Nom du Receveur",
          hintText: 'Nom et Prénom',
          keyboardType: TextInputType.text,
          error: null,
          controller: nameController,
          onChanged: (value) {},
        ),
        const SpaceHeight(10),
        InputTextField(
          label: "Nom de la banque receveur",
          hintText: 'Ecobank',
          keyboardType: TextInputType.text,
          controller: nomBanqueController,
          error: null,
          onChanged: (value) {},
        ),
        const SpaceHeight(10),
        InputTextField(
          label: "IBAN",
          hintText: 'BJ87 7766 7676 76767',
          keyboardType: TextInputType.text,
          controller: ibanController,
          error: null,
          onChanged: (value) {},
        ),
        const SpaceHeight(10),
        InputTextField(
          label: "BIC",
          hintText: 'BJBI87867',
          keyboardType: TextInputType.text,
          controller: bicController,
          error: null,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget transfertExpress() {
    return Column(
      children: [
        InputTextField(
          label: "Telephone",
          hintText: '+229 97 828',
          keyboardType: TextInputType.text,
          controller: phoneNumberController,
          error: null,
          onChanged: (value) {},
        ),
        const SpaceHeight(10),
        InputTextField(
          label: "Nom du Receveur",
          hintText: 'Nom et Prénom',
          keyboardType: TextInputType.text,
          controller: nameController,
          error: null,
          onChanged: (value) {},
        ),
        const SpaceHeight(10),
        InputTextField(
          label: "Adresse domicile",
          hintText: 'Cotonou',
          controller: adressDomicileController,
          keyboardType: TextInputType.text,
          error: null,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget mobileMoney(Currencies? selectedSubTypeDevise) {
    return Column(
      children: [
        InputTextField(
          label: "Mon adresse ${selectedSubTypeDevise?.currencyName}",
          hintText: '+229 97 00 00 00',
          controller: phoneNumberController,
          keyboardType: TextInputType.text,
          error: null,
          onChanged: (value) {},
        ),
      ],
    );
  }
}

class Statuts {
  final String? label;
  final int? id;
  const Statuts({this.label, this.id});

}
