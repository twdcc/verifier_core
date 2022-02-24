import 'package:flutter/material.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:verifier_core/core/view_model/dcc_result_view_model.dart';
import 'package:verifier_core/helper/const.dart';
import 'package:verifier_core/helper/utils.dart';

class DccResultView extends StatelessWidget {
  final CoseResult result;
  final PanelController panel;

  DccResultView({
    required this.result,
    required this.panel,
  });

  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: false, initialScrollOffset: 0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DccResultViewModel>(
        init: DccResultViewModel(),
        builder: (drvm) {
          drvm.checkValidity(result);
          return Column(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.transparent),
                  child: Column(
                    children: [
                      Flexible(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.225,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: drvm.displayColor,
                          ),
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            top: MediaQuery.of(context).size.height * 0.005,
                            right: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          drvm.fullName,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.045,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        panel.close();
                                      },
                                      icon: Icon(
                                        Icons.exit_to_app_outlined,
                                        color: Colors.white,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.005,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.004),
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      drvm.displayIcon,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.height *
                                          0.055,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        drvm.displayTitle,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.045,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: ListView(
                          key: Key(drvm.hashCode.toString()),
                          physics: BouncingScrollPhysics(),
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: [
                            for (var item in drvm.generateDetailedInfo()) ...[
                              Utils.detailedInfoText(item.chTitle, item.enTitle,
                                  item.info, context)
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  child: Column(
                    children: [
                      TextButton(
                        child: Text(
                          confirmText,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: drvm.displayColor,
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.09,
                              MediaQuery.of(context).size.height * 0.01,
                              MediaQuery.of(context).size.width * 0.09,
                              MediaQuery.of(context).size.height * 0.01),
                        ),
                        onPressed: () {
                          panel.close();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
