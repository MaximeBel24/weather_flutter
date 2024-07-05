import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_meteo/cubit/search_city/search_city_cubit.dart';

import '../model/city.dart';
import '../service/logger.dart';

class WeatherSearchCity extends StatelessWidget {
  final Function(String) onSelected;

  const WeatherSearchCity({Key? key, required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final FocusNode focusNode = FocusNode();

    return BlocProvider(
      create: (context) => SearchCityCubit(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<SearchCityCubit, SearchCityState>(
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    // Background transparent
                    labelText: "Recherche de ville",
                    labelStyle: const TextStyle(color: Colors.white),
                    hintText: 'Saisissez un nom de ville',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                    // Hint text color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Colors.white, // White border
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Colors.white, // White border
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Colors.white, // White border
                        width: 2.0,
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  // Text color
                  onChanged: (query) {
                    if (query.isNotEmpty) {
                      context.read<SearchCityCubit>().initSearchCities(query);
                      logger.e(query);
                    }
                  },
                  onSubmitted: (query) {
                    onSelected(query);
                  },
                ),
                if (state.status == SearchCityStatus.loading)
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )),
                if (state.status == SearchCityStatus.loaded &&
                    state.cities.isNotEmpty)
                  SizedBox(
                    height: 350,
                    width: 280,
                    child: ListView.builder(
                      itemCount: state.cities.length,
                      itemBuilder: (context, index) {
                        final city = state.cities[index];
                        return ListTile(
                          title: Text(
                            city.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(city.country,
                              style: const TextStyle(color: Colors.grey)),
                          onTap: () {
                            onSelected(city.name);
                          },
                        );
                      },
                    ),
                  ),
                if (state.status == SearchCityStatus.error)
                  Center(
                    child: Text(
                      'Error: ${state.error?.toString() ?? 'Unknown error'}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
