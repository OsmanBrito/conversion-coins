import 'package:coin_conversion/core/viewmodels/base_model.dart';
import 'package:coin_conversion/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Function(T) modelIsReady;
  final Widget Function(BuildContext context, T model, Widget child) builder;

  BaseView({this.builder, this.modelIsReady});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = sl<T>();

  @override
  void initState() {
    if (widget.modelIsReady != null) {
      widget.modelIsReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (context) => model,
        child: Consumer<T>(builder: widget.builder));
  }
}
