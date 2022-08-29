import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home.dart';
import 'package:news_app/shared/bloc/cubit.dart';
import 'package:news_app/shared/bloc/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget
{
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        List<dynamic> list = NewsCubit.get(context).search ;

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: ()
              {
                navigateTo(context, Home());
                NewsCubit.get(context).clearSearch();
              },
              icon: Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
          ),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (value)
                  {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validate: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'search must be not empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(child: articleBuilder(list, context, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
