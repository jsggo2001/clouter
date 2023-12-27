import 'package:clout/screens/campaign_register/widgets/data_title.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class Signature extends StatefulWidget {
  Signature({
    super.key,
    required this.globalKey,
    required this.signatureKey,
    required this.setBlank,
    required this.signatureSubject,
  });
  final globalKey;
  final signatureKey;
  final signatureSubject;
  var setBlank;

  @override
  State<Signature> createState() => _SignatureState();
}

class _SignatureState extends State<Signature> {
  void _handleClearButtonPressed() {
    widget.signatureKey.currentState!.clear();
    widget.setBlank(true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          DataTitle(text: '전자 서명'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton.icon(
                onPressed: _handleClearButtonPressed,
                icon: Icon(
                  Icons.restart_alt_outlined,
                  color: style.colors['main1'],
                ),
                label: Text('초기화',
                    style:
                        TextStyle(color: style.colors['main1'], height: 1.25)),
              )
            ],
          )
        ]),
        Stack(
          children: [
            Positioned(
                bottom: 1,
                top: 1,
                left: 1,
                right: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                )),
            RepaintBoundary(
              key: widget.globalKey,
              child: Stack(
                children: [
                  Positioned(
                      bottom: 3,
                      top: 3,
                      left: 3,
                      right: 3,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.signatureSubject,
                                style: style.textTheme.titleMedium?.copyWith(
                                    color: style.colors['text'],
                                    height: 1,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ))),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: SfSignaturePad(
                        key: widget.signatureKey,
                        onDrawEnd: () {
                          widget.setBlank(false);
                          // return true;
                        },
                        backgroundColor: Colors.transparent,
                        strokeColor: Colors.black,
                        minimumStrokeWidth: 1.0,
                        maximumStrokeWidth: 4.0),
                  ),
                ],
              ),
            )
          ],
        ),
        // SizedBox(height: 10),
      ],
    );
  }
}
