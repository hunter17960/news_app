import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        if (state is NewsGetBusinessDataLoading) {
          NewsCubit.get(context).getBusiness();
        }
      },
      builder: (context, state) {
        List<dynamic> business = NewsCubit.get(context).business;
        return articlePageBuilder(business, context);
      },
    );
  }
}
