import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../services/models/enums.dart';
import '../../../services/nhtsa_service.dart';
import 'vehicle_setup_provider.dart';

class VehicleSetupScreen extends ConsumerWidget {
  const VehicleSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(vehicleFormProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Fahrzeug hinzufügen')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionLabel('Fahrzeugdaten'),
            const SizedBox(height: 4),
            Text(
              'Grunddaten deines Autos. Ohne VIN kein Problem — die ist optional.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
            const SizedBox(height: 16),
            _YearPicker(form: form),
            const SizedBox(height: 12),
            _MakeSearch(form: form),
            const SizedBox(height: 12),
            _ModelSearch(form: form),
            const SizedBox(height: 12),
            _VinField(vin: form.vin),
            const SizedBox(height: 12),
            _FuelTypePicker(selected: form.fuelType),
            const SizedBox(height: 12),
            _MileageField(mileage: form.mileage),
            const SizedBox(height: 12),
            _AnnualKmField(value: form.annualKmEstimate),
            const SizedBox(height: 32),
            if (form.error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  form.error!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            _SaveButton(form: form),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION LABEL
// ============================================================================

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

// ============================================================================
// YEAR PICKER
// ============================================================================

class _YearPicker extends ConsumerWidget {
  final VehicleFormState form;
  const _YearPicker({required this.form});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final years = ref.watch(yearOptionsProvider);

    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: 'Baujahr *',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.calendar_today),
      ),
      initialValue: form.year,
      items: years
          .map((y) => DropdownMenuItem(value: y, child: Text('$y')))
          .toList(),
      onChanged: (y) {
        if (y != null) ref.read(vehicleFormProvider.notifier).setYear(y);
      },
    );
  }
}

// ============================================================================
// MAKE SEARCH
// ============================================================================

class _MakeSearch extends ConsumerStatefulWidget {
  final VehicleFormState form;
  const _MakeSearch({required this.form});

  @override
  ConsumerState<_MakeSearch> createState() => _MakeSearchState();
}

class _MakeSearchState extends ConsumerState<_MakeSearch> {
  @override
  Widget build(BuildContext context) {
    final makesAsync = ref.watch(makesProvider);
    final makes = makesAsync.valueOrNull ?? [];

    return Autocomplete<String>(
      initialValue: TextEditingValue(text: widget.form.make ?? ''),
      optionsBuilder: (value) {
        if (makes.isEmpty) return const [];
        final q = value.text.toLowerCase();
        if (q.isEmpty) return makes;
        return makes.where((m) => m.toLowerCase().contains(q));
      },
      onSelected: (make) {
        ref.read(vehicleFormProvider.notifier).setMake(make);
      },
      fieldViewBuilder: (context, controller, focusNode, onSubmitted) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: 'Marke *',
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.directions_car),
            hintText:
                makesAsync.isLoading ? 'Lade ...' : 'z. B. Ford, Toyota, BMW',
          ),
          onChanged: (v) {
            ref.read(vehicleFormProvider.notifier).setMake(v);
          },
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return _OptionsOverlay(options: options, onSelected: onSelected);
      },
    );
  }
}

// ============================================================================
// MODEL SEARCH
// ============================================================================

class _ModelSearch extends ConsumerWidget {
  final VehicleFormState form;
  const _ModelSearch({required this.form});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final make = form.make;
    final modelsAsync = ref.watch(availableModelsProvider);
    final models = modelsAsync.valueOrNull ?? [];

    return Autocomplete<String>(
      initialValue: TextEditingValue(text: form.model ?? ''),
      optionsBuilder: (value) {
        if (make == null || models.isEmpty) return const [];
        final q = value.text.toLowerCase();
        if (q.isEmpty) return models;
        return models.where((m) => m.toLowerCase().contains(q));
      },
      onSelected: (model) {
        ref.read(vehicleFormProvider.notifier).setModel(model);
      },
      fieldViewBuilder: (context, controller, focusNode, onSubmitted) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          enabled: make != null,
          decoration: InputDecoration(
            labelText: make == null ? 'Modell * (erst Marke wählen)' : 'Modell *',
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.directions_car_outlined),
            hintText:
                modelsAsync.isLoading ? 'Lade ...' : 'z. B. Golf, Corolla, 3er',
          ),
          onChanged: (v) {
            ref.read(vehicleFormProvider.notifier).setModel(v);
          },
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return _OptionsOverlay(options: options, onSelected: onSelected);
      },
    );
  }
}

// ============================================================================
// SHARED AUTOCOMPLETE OVERLAY
// ============================================================================

class _OptionsOverlay extends StatelessWidget {
  final Iterable<String> options;
  final AutocompleteOnSelected<String> onSelected;

  const _OptionsOverlay({required this.options, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 220, maxWidth: 400),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, i) {
              final option = options.elementAt(i);
              return ListTile(
                dense: true,
                title: Text(option),
                onTap: () => onSelected(option),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// OTHER FORM FIELDS
// ============================================================================

class _VinField extends ConsumerWidget {
  final String vin;
  const _VinField({required this.vin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      initialValue: vin,
      decoration: const InputDecoration(
        labelText: 'Fahrgestellnummer (optional)',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.qr_code),
        helperText: '17-stellige VIN, findest du im Fahrzeugschein',
      ),
      maxLength: 17,
      textCapitalization: TextCapitalization.characters,
      onChanged: (v) => ref.read(vehicleFormProvider.notifier).setVin(v),
    );
  }
}

class _FuelTypePicker extends ConsumerWidget {
  final FuelType selected;
  const _FuelTypePicker({required this.selected});

  String _label(FuelType ft) => switch (ft) {
        FuelType.petrol => 'Benzin',
        FuelType.diesel => 'Diesel',
        FuelType.electric => 'Elektro',
        FuelType.hybrid => 'Hybrid',
        FuelType.other => 'Sonstiges',
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonFormField<FuelType>(
      decoration: const InputDecoration(
        labelText: 'Kraftstoff *',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.local_gas_station),
      ),
      initialValue: selected,
      items: FuelType.values
          .map((ft) =>
              DropdownMenuItem(value: ft, child: Text(_label(ft))))
          .toList(),
      onChanged: (ft) {
        if (ft != null) {
          ref.read(vehicleFormProvider.notifier).setFuelType(ft);
        }
      },
    );
  }
}

class _MileageField extends ConsumerWidget {
  final int mileage;
  const _MileageField({required this.mileage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      initialValue: mileage > 0 ? '$mileage' : '',
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Aktueller Kilometerstand *',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.speed),
        suffixText: 'km',
      ),
      onChanged: (v) {
        final km = int.tryParse(v) ?? 0;
        ref.read(vehicleFormProvider.notifier).setMileage(km);
      },
    );
  }
}

class _AnnualKmField extends ConsumerWidget {
  final int? value;
  const _AnnualKmField({required this.value});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      initialValue: value != null ? '$value' : '',
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Geschätzte Kilometer pro Jahr (optional)',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.route),
        suffixText: 'km/Jahr',
        helperText: 'Hilft bei der Berechnung von Wartungsintervallen',
      ),
      onChanged: (v) {
        final km = int.tryParse(v.trim());
        ref.read(vehicleFormProvider.notifier).setAnnualKmEstimate(km);
      },
    );
  }
}

// ============================================================================
// SAVE BUTTON
// ============================================================================

class _SaveButton extends ConsumerWidget {
  final VehicleFormState form;
  const _SaveButton({required this.form});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        icon: form.isSaving
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : const Icon(Icons.check),
        label: Text(form.isSaving ? 'Speichere ...' : 'Fahrzeug speichern'),
        onPressed: form.isValid && !form.isSaving
            ? () async {
                final ok =
                    await ref.read(vehicleFormProvider.notifier).save();
                if (ok && context.mounted) context.go('/');
              }
            : null,
      ),
    );
  }
}
