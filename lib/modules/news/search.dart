import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_start/layout/newsapp/cubit/cubit.dart';
import 'package:shop_app_start/layout/newsapp/cubit/states.dart';
import 'package:shop_app_start/shared/componant/componant.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  Widget getSearch(BuildContext context) {
    var list = newCubit.getInstance(context).search;
    if (list != null) {
      return articleCBuilder(list, context);
    }
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newCubit, newsapp>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (String value) {
                    newCubit.getInstance(context).searchh(value);
                  },
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(child: getSearch(context)),
            ],
          ),
        );
      },
    );
  }
}
