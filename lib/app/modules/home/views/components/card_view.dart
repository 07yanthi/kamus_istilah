import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/app/modules/home/controllers/favorit_controller.dart';
import 'package:news_app/app/modules/home/controllers/search_controller.dart';
import 'package:unique_identifier/unique_identifier.dart';

class CardView extends StatefulWidget {
  String? id;
  String? title;
  String? detail;
  bool favorit;

  CardView({
    required this.id,
    required this.title,
    required this.detail,
    required this.favorit,
  });

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  addFavorit(String? kamus) async {
    String? user = await UniqueIdentifier.serial;
    print(kamus);
    var response = await http.get(Uri.parse(
        'http://kamus.test-web.my.id/api/add_favorit?user=' +
            user! +
            '&kamus_id=' +
            kamus!));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);
      return 'berhasil';
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 8),
        child: SizedBox(
          height: widget.detail!.length < 60
              ? MediaQuery.of(context).size.height * 0.115
              : widget.detail!.length < 100
                  ? MediaQuery.of(context).size.height * 0.135
                  : widget.detail!.length < 200
                      ? MediaQuery.of(context).size.height * 0.185
                      : MediaQuery.of(context).size.height * 0.265,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              widget.title!,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                await addFavorit(widget.id);
                                setState(() {
                                  if (widget.favorit)
                                    widget.favorit = false;
                                  else
                                    widget.favorit = true;
                                });
                              },
                              icon: Icon(
                                Icons.star,
                                size: 20,
                                color: widget.favorit
                                    ? Color(0xff4f9b9b)
                                    : Colors.black,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(
                      height: 5,
                      thickness: 2,
                    ),
                    SizedBox(height: 5),
                    Flexible(
                      child: Text(
                        widget.detail!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        softWrap: false,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    // SizedBox(
                    //   child: Text(
                    //     dateTime.toString(),
                    //     style: Theme.of(context).textTheme.caption,
                    //   ),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
