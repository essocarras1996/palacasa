import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:palacasa/Helper/color_constant.dart';


 OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(20)),
);

class SearchForm extends StatefulWidget {
  final String name;
  final Function(String) onSearch;

  const SearchForm({
    Key? key,
    required this.name,
    required this.onSearch,
  }) : super(key: key);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _searchText;

  @override
  void initState() {
    super.initState();
    _searchText = '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: TextFormField(
          style:
          TextStyle(fontFamily: 'Poppinsr', color: Colors.grey),
          onSaved: (value) {
            _searchText = value ?? '';
          },
          decoration: InputDecoration(
            hintText: widget.name,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
            EdgeInsets.only(left: 15, bottom: 20, top: 20, right: 15),
            hintStyle: TextStyle(fontFamily: 'Poppinsr'),
            labelStyle: TextStyle(fontFamily: 'Poppinsr'),
            suffixIcon: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: SizedBox(
                width: 60,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: PaLaCasaAppTheme.Orange,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  onPressed: () {
                    _formKey.currentState!.save();
                    widget.onSearch(_searchText);
                  },
                  child: SvgPicture.asset("assets/icons/Filter.svg"),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

