import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/bloc/cubit.dart';
import 'package:news_app/shared/bloc/states.dart';

class Wait extends StatelessWidget {
  const Wait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 150.0,
              color: NewsCubit.get(context).isDark? Colors.white54 : Colors.black26,
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              'Try searching for anything',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: NewsCubit.get(context).isDark? Colors.white54 : Colors.black45,
              ),
            ),
          ],);
      },
    );
  }
}
