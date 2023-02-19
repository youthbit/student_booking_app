import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:go_router/go_router.dart';

import '../../generated/locale_keys.g.dart';
import '../routing/router_spec.dart';
import 'alert_base_view.dart';

class AlertSuccessView extends StatelessWidget {
  const AlertSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parser = EmojiParser();
    return AlertBaseView(
      backgroundText:
          List.filled(7, LocaleKeys.alertSuccessViewBackgroundText.tr()),
      cardTitle: LocaleKeys.alertSuccessViewCardTitle.tr(),
      cardBody: LocaleKeys.alertSuccessViewCardBody.tr(),
      headerContent: Text(
        parser.get('ok_hand').code,
        style: const TextStyle(fontSize: 40),
      ),
      btnHeader: LocaleKeys.alertSuccessViewBtnHeader.tr(),
      backgroundTextColor: Colors.tealAccent,
      btnColor: Colors.teal,
      onBtnTap: () {
        if (!context.mounted) return;
        context.goNamed(RouteSpec.homepage.name);
      },
    );
  }
}
