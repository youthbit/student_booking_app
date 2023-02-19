import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:go_router/go_router.dart';

import '../../generated/locale_keys.g.dart';
import '../routing/router_spec.dart';
import 'alert_base_view.dart';

class AlertErrorView extends StatelessWidget {
  const AlertErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parser = EmojiParser();
    return AlertBaseView(
      backgroundText:
          List.filled(7, LocaleKeys.alertErrorViewBackgroundText.tr()),
      cardTitle: LocaleKeys.alertErrorViewCardTitle.tr(),
      cardBody: LocaleKeys.alertErrorViewCardBody.tr(),
      headerContent: Text(
        parser.get('cold_face').code,
        style: const TextStyle(fontSize: 40),
      ),
      btnHeader: LocaleKeys.alertErrorViewBtnHeader.tr(),
      backgroundTextColor: Colors.redAccent,
      btnColor: Colors.red,
      onBtnTap: () {
        if (!context.mounted) return;
        context.goNamed(RouteSpec.homepage.name);
      },
    );
  }
}
