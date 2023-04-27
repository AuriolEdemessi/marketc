import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'country_pick.dart';

class SelectionList extends StatefulWidget {
  SelectionList(this.elements, this.initialSelection,
      {Key? key,})
      : super(key: key);
  final List elements;
  final CountryCode? initialSelection;

  @override
  _SelectionListState createState() => _SelectionListState();
}

class _SelectionListState extends State<SelectionList> {
  late List countries;
  final TextEditingController _controller = TextEditingController();
  ScrollController? _controllerScroll;

  var posSelected = 0;
  var height = 0.0;

  bool isShow = true;

  @override
  void initState() {
    countries = widget.elements;
    countries.sort((a, b) {
      return a.name.toString().compareTo(b.name.toString());
    });
    _controllerScroll = ScrollController();
    super.initState();
  }

  void _sendDataBack(BuildContext context, CountryCode initialSelection) {
    Navigator.pop(context, initialSelection);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    Widget scaffold = Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(52),
        child: AppBar(
          leading:InkWell(onTap: ()=>Navigator.pop(context), child: Padding(padding: EdgeInsets.only(left:20, right: 10), child: SvgPicture.asset("assets/icons/arrow_left.svg", package: 'country_pick',),),) ,
          bottomOpacity: 0.0,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xfff4f4f4),
        ),
      ),
      body: Container(
        color: Color(0xfff4f4f4),
        child: LayoutBuilder(builder: (context, contrainsts) {
          return Stack(
            children: <Widget>[
              CustomScrollView(
                controller: _controllerScroll,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       /* Padding(
                          padding: const EdgeInsets.only(top: 22, left: 20, bottom: 31),
                          child: Text(
                            'Add Language',
                            style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF6221bf)),
                          ),
                        ),*/
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(padding: EdgeInsets.only(top: 13, left: 10, right: 15, bottom: 10), child: SvgPicture.asset("assets/icons/search.svg", package: 'country_pick',),),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 16,),
                              hintText:  "Search...",
                            ),
                            onChanged: _filterElements,
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return  Padding(padding: EdgeInsets.only(bottom: 15, left: 20, right: 20), child: getListCountry(countries.elementAt(index)),);
                    }, childCount: countries.length),
                  )
                ],
              ),
            ],
          );
        }),
      ),
    );
    return scaffold;
  }

  Widget getListCountry(CountryCode e) {
    return InkWell(onTap:() =>_sendDataBack(context, e), child: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        // color,
        child:Row(children: [
          Container(height: 30, width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              image: DecorationImage(
                image: AssetImage("${e.flagUri!}" ,package: 'country_pick'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(child:  Row(children: [
            Text(e.name!, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF6221bf)),),
            Spacer(),
            Text(e.dialCode!, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF6221bf)),),
          ],))
        ],)
    ),);
  }

  void _filterElements(String s) {
    s = s.toUpperCase();
    setState(() {
      countries = widget.elements
          .where((e) =>
              e.code.contains(s) ||
              e.dialCode.contains(s) ||
              e.name.toUpperCase().contains(s))
          .toList();
    });
  }
}
