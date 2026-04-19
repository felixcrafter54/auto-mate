import 'package:auto_mate/l10n/app_localizations.dart';
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
    final l = AppLocalizations.of(context);
    final form = ref.watch(vehicleFormProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.vehicleSetupTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionLabel(l.vehicleSetupSectionData),
            const SizedBox(height: 4),
            Text(
              l.vehicleSetupSectionHint,
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
    final l = AppLocalizations.of(context);
    final years = ref.watch(yearOptionsProvider);

    return DropdownButtonFormField<int>(
      decoration: InputDecoration(
        labelText: l.vehicleSetupYear,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.calendar_today),
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
    final l = AppLocalizations.of(context);
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
            labelText: l.vehicleSetupMake,
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.directions_car),
            hintText: makesAsync.isLoading ? l.vehicleSetupMakeLoading : l.vehicleSetupMakePlaceholder,
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
    final l = AppLocalizations.of(context);
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
            labelText: make == null ? l.vehicleSetupModelDisabled : l.vehicleSetupModel,
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.directions_car_outlined),
            hintText: modelsAsync.isLoading ? l.vehicleSetupMakeLoading : l.vehicleSetupModelPlaceholder,
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
    final l = AppLocalizations.of(context);
    return TextFormField(
      initialValue: vin,
      decoration: InputDecoration(
        labelText: l.vehicleSetupVin,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.qr_code),
        helperText: l.vehicleSetupVinHint,
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    return DropdownButtonFormField<FuelType>(
      decoration: InputDecoration(
        labelText: l.vehicleSetupFuel,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.local_gas_station),
      ),
      initialValue: selected,
      items: FuelType.values
          .map((ft) =>
              DropdownMenuItem(value: ft, child: Text(_fuelLabel(l, ft))))
          .toList(),
      onChanged: (ft) {
        if (ft != null) {
          ref.read(vehicleFormProvider.notifier).setFuelType(ft);
        }
      },
    );
  }

  String _fuelLabel(AppLocalizations l, FuelType ft) => switch (ft) {
        FuelType.petrol => l.fuelTypePetrol,
        FuelType.diesel => l.fuelTypeDiesel,
        FuelType.electric => l.fuelTypeElectric,
        FuelType.hybrid => l.fuelTypeHybrid,
        FuelType.other => l.fuelTypeOther,
      };
}

class _MileageField extends ConsumerWidget {
  final int mileage;
  const _MileageField({required this.mileage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    return TextFormField(
      initialValue: mileage > 0 ? '$mileage' : '',
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: l.vehicleSetupMileage,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.speed),
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
    final l = AppLocalizations.of(context);
    return TextFormField(
      initialValue: value != null ? '$value' : '',
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: l.vehicleSetupAnnualKm,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.route),
        suffixText: l.vehicleSetupAnnualKmSuffix,
        helperText: l.vehicleSetupAnnualKmHint,
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
    final l = AppLocalizations.of(context);
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
        label: Text(form.isSaving ? l.vehicleSetupSavingButton : l.vehicleSetupSaveButton),
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
