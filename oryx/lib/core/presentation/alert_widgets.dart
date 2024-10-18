import '../../utils/font.dart';
import '../../utils/colors.dart';
import 'package:flutter/material.dart';

class Alerts {
  static Alerts alert = Alerts();
  static Alerts getInstance() => alert;

  /// twoButton
  twoButtonAlert(BuildContext context, {required String title, required String msg, required String btnNoText, required String btnYesText, required Function functionNo, required Function functionYes}) {
    return showDialog(
      context: context,
      /// Disable dismiss on outside tap
      barrierDismissible: false,
      builder: (BuildContext context) => PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: kColorWhite,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Center(
            child: Text(
              title,
              style: kInter700(context, fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          titlePadding: const EdgeInsets.only(top: 28, left: 24, right: 24),
          content: Text(
            msg,
            style: kInter400(context, color: kHomeFont, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          contentPadding: const EdgeInsets.only(top: 12, left: 40, right: 40),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    functionNo();
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    height: 40,
                    constraints: const BoxConstraints(maxWidth: 128),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: kColorIcon),
                      color: kColorWhite,
                    ),
                    child: Center(
                      child: Text(
                        btnNoText,
                        textAlign: TextAlign.center,
                        style: kInter500(context, color: kColorIcon, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    functionYes();
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    height: 40,
                    constraints: const BoxConstraints(maxWidth: 128),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kColorRed,
                    ),
                    child: Center(
                      child: Text(
                        btnYesText,
                        textAlign: TextAlign.center,
                        style: kInter500(context, color: kColorWhite, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          actionsPadding: const EdgeInsets.fromLTRB(24, 18, 24, 22),
          actionsAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
