import 'package:flutter/material.dart';

import '../api_bloc.dart';

typedef ApiValueWidget<String> = Widget Function(String message);
typedef ApiDataWidget<T> = Widget Function(T value);

class ApiStreamBuilder<T> extends StatelessWidget {
  final Stream<ApiResponse<T>> stream;
  final ApiDataWidget<T> dataWidget;
  final ApiValueWidget<String> loadingWidget;
  final ApiValueWidget<String> errorWidget;

  ApiStreamBuilder(
      {@required this.stream,
      @required this.dataWidget,
      @required this.loadingWidget,
      @required this.errorWidget});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<T>>(
      stream: stream,
      initialData: ApiResponse.loading("Loading"),
      builder: (context, AsyncSnapshot<ApiResponse<T>> snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.Loading:
              return loadingWidget(snapshot.data.message);
              break;
            case Status.Completed:
              return dataWidget(snapshot.data.data);
              break;
            case Status.UnNotifiedError:
              return dataWidget(snapshot.data.data);
              break;
            case Status.Error:
              return errorWidget(snapshot.data.message);
              break;
          }
        }
        return Container();
      },
    );
  }
}
