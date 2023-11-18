// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:workouts/presentation/screens/log_creation/tabs/graph_page.dart/services/graph_selector_provider.dart';
// import 'package:workouts/presentation/theme/app_colors.dart';

// class PropertiesDropDown extends ConsumerWidget {
//   const PropertiesDropDown({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final _selector = ref.watch(graphSelector);

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         height: 40,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           color: AppColors.primaryShades.shade80,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: DropdownButton<GraphProperties>(
//             icon: const Icon(Icons.keyboard_arrow_down),
//             iconSize: 24,
//             elevation: 0,
//             alignment: AlignmentDirectional.topCenter,
//             underline: Container(),
//             isExpanded: true,
//             dropdownColor: AppColors.primaryShades.shade80,
//             value: _selector.graphProperties,
//             onChanged: (GraphProperties? newValue) {
//               ref.read(graphSelector).setGraphProperties(newValue!);
//             },
//             items: GraphProperties.values.map((GraphProperties properties) {
//               return DropdownMenuItem<GraphProperties>(
//                 value: properties,
//                 child: Text(
//                   _selector.propertiesToString(properties),
//                   style: Theme.of(context).textTheme.bodyText1,
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }
