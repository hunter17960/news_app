import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/modules/webview/web_view_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function Function(String)? onSubmit,
  final ValueChanged<String>? onChange,
  final VoidCallback? onTap,
  bool isPassword = false,
  required final FormFieldValidator<String> validator,
  required String label,
  required IconData prefix,
  IconData? suffix,
  final VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget buildArticleItem(article, context) {
  return InkWell(
    onTap: () {
      navigateTo(context, WebViewScreen(article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              // color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                onError: (exception, stackTrace) => Container(),
                image: NetworkImage(
                  '${article['urlToImage']}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      article['title'],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    DateFormat('MMMM d, y - HH:mm')
                        .format(DateTime.parse(article['publishedAt'])),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget articlePageBuilder(List<dynamic> articles, BuildContext context,
    {bool isSearch = false}) {
  return ConditionalBuilder(
    condition: articles.isNotEmpty,
    builder: (context) => ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(
        articles[index],
        context,
      ),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
        ),
        child: Container(
          width: double.infinity,
          height: 1.0,
          color: Theme.of(context).dividerColor,
        ),
      ),
      itemCount: articles.length,
    ),
    fallback: (context) => isSearch
        ? Container()
        : const Center(
            child: CircularProgressIndicator(),
          ),
  );
}

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}
// Widget buildTaskItem(Map model, context) => Dismissible(
//       key: Key('${model['id']}'),
//       onDismissed: (direction) {
//         AppCubit.get(context).deleteFromDb(
//           id: model['id'],
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 40.0,
//               child: Text('${model['time']}'),
//             ),
//             const SizedBox(
//               width: 15.0,
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '${model['title']}',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20.0,
//                     ),
//                   ),
//                   Text(
//                     '${model['date']}',
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               width: 15.0,
//             ),
//             IconButton(
//               onPressed: () {
//                 AppCubit.get(context).updateData(
//                   status: 'done',
//                   id: model['id'],
//                 );
//               },
//               icon: Icon(
//                 Icons.check_box,
//                 color: Theme.of(context).primaryColorDark,
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 AppCubit.get(context).updateData(
//                   status: 'archive',
//                   id: model['id'],
//                 );
//               },
//               icon: const Icon(
//                 Icons.archive,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

// Widget tasksPageBuilder({
//   required List<Map> tasks,
// }) =>
//     ConditionalBuilder(
//       condition: tasks.isNotEmpty,
//       builder: (BuildContext context) => ListView.separated(
//         itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
//         separatorBuilder: (context, index) => Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 5.0,
//           ),
//           child: Container(
//             width: double.infinity,
//             height: 1.0,
//             color: Theme.of(context).dividerColor,
//           ),
//         ),
//         itemCount: tasks.length,
//       ),
//       fallback: (BuildContext context) => Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.menu,
//               size: 100.0,
//               color: Theme.of(context).dividerColor,
//             ),
//             Text(
//               'No Tasks Yet',
//               style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                   color: Theme.of(context).dividerColor),
//             )
//           ],
//         ),
//       ),
//     );
