// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _skillLevelMeta = const VerificationMeta(
    'skillLevel',
  );
  @override
  late final GeneratedColumn<String> skillLevel = GeneratedColumn<String>(
    'skill_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _onboardingCompleteMeta =
      const VerificationMeta('onboardingComplete');
  @override
  late final GeneratedColumn<bool> onboardingComplete = GeneratedColumn<bool>(
    'onboarding_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    email,
    skillLevel,
    onboardingComplete,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('skill_level')) {
      context.handle(
        _skillLevelMeta,
        skillLevel.isAcceptableOrUnknown(data['skill_level']!, _skillLevelMeta),
      );
    }
    if (data.containsKey('onboarding_complete')) {
      context.handle(
        _onboardingCompleteMeta,
        onboardingComplete.isAcceptableOrUnknown(
          data['onboarding_complete']!,
          _onboardingCompleteMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      skillLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}skill_level'],
      ),
      onboardingComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_complete'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final String email;
  final String? skillLevel;
  final bool onboardingComplete;
  final DateTime createdAt;
  final DateTime updatedAt;
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.skillLevel,
    required this.onboardingComplete,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || skillLevel != null) {
      map['skill_level'] = Variable<String>(skillLevel);
    }
    map['onboarding_complete'] = Variable<bool>(onboardingComplete);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      skillLevel: skillLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(skillLevel),
      onboardingComplete: Value(onboardingComplete),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      skillLevel: serializer.fromJson<String?>(json['skillLevel']),
      onboardingComplete: serializer.fromJson<bool>(json['onboardingComplete']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'skillLevel': serializer.toJson<String?>(skillLevel),
      'onboardingComplete': serializer.toJson<bool>(onboardingComplete),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
    Value<String?> skillLevel = const Value.absent(),
    bool? onboardingComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    skillLevel: skillLevel.present ? skillLevel.value : this.skillLevel,
    onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      skillLevel: data.skillLevel.present
          ? data.skillLevel.value
          : this.skillLevel,
      onboardingComplete: data.onboardingComplete.present
          ? data.onboardingComplete.value
          : this.onboardingComplete,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('skillLevel: $skillLevel, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    email,
    skillLevel,
    onboardingComplete,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.skillLevel == this.skillLevel &&
          other.onboardingComplete == this.onboardingComplete &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String?> skillLevel;
  final Value<bool> onboardingComplete;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.skillLevel = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String email,
    this.skillLevel = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : name = Value(name),
       email = Value(email),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? skillLevel,
    Expression<bool>? onboardingComplete,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (skillLevel != null) 'skill_level': skillLevel,
      if (onboardingComplete != null) 'onboarding_complete': onboardingComplete,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? email,
    Value<String?>? skillLevel,
    Value<bool>? onboardingComplete,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      skillLevel: skillLevel ?? this.skillLevel,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (skillLevel.present) {
      map['skill_level'] = Variable<String>(skillLevel.value);
    }
    if (onboardingComplete.present) {
      map['onboarding_complete'] = Variable<bool>(onboardingComplete.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('skillLevel: $skillLevel, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $VehiclesTable extends Vehicles with TableInfo<$VehiclesTable, Vehicle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _makeMeta = const VerificationMeta('make');
  @override
  late final GeneratedColumn<String> make = GeneratedColumn<String>(
    'make',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vinMeta = const VerificationMeta('vin');
  @override
  late final GeneratedColumn<String> vin = GeneratedColumn<String>(
    'vin',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fuelTypeMeta = const VerificationMeta(
    'fuelType',
  );
  @override
  late final GeneratedColumn<String> fuelType = GeneratedColumn<String>(
    'fuel_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentMileageMeta = const VerificationMeta(
    'currentMileage',
  );
  @override
  late final GeneratedColumn<int> currentMileage = GeneratedColumn<int>(
    'current_mileage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _annualKmEstimateMeta = const VerificationMeta(
    'annualKmEstimate',
  );
  @override
  late final GeneratedColumn<int> annualKmEstimate = GeneratedColumn<int>(
    'annual_km_estimate',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    make,
    model,
    year,
    vin,
    fuelType,
    currentMileage,
    annualKmEstimate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Vehicle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('make')) {
      context.handle(
        _makeMeta,
        make.isAcceptableOrUnknown(data['make']!, _makeMeta),
      );
    } else if (isInserting) {
      context.missing(_makeMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('vin')) {
      context.handle(
        _vinMeta,
        vin.isAcceptableOrUnknown(data['vin']!, _vinMeta),
      );
    }
    if (data.containsKey('fuel_type')) {
      context.handle(
        _fuelTypeMeta,
        fuelType.isAcceptableOrUnknown(data['fuel_type']!, _fuelTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fuelTypeMeta);
    }
    if (data.containsKey('current_mileage')) {
      context.handle(
        _currentMileageMeta,
        currentMileage.isAcceptableOrUnknown(
          data['current_mileage']!,
          _currentMileageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentMileageMeta);
    }
    if (data.containsKey('annual_km_estimate')) {
      context.handle(
        _annualKmEstimateMeta,
        annualKmEstimate.isAcceptableOrUnknown(
          data['annual_km_estimate']!,
          _annualKmEstimateMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vehicle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vehicle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      make: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}make'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      vin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vin'],
      ),
      fuelType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fuel_type'],
      )!,
      currentMileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_mileage'],
      )!,
      annualKmEstimate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}annual_km_estimate'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $VehiclesTable createAlias(String alias) {
    return $VehiclesTable(attachedDatabase, alias);
  }
}

class Vehicle extends DataClass implements Insertable<Vehicle> {
  final int id;
  final int userId;
  final String make;
  final String model;
  final int year;
  final String? vin;
  final String fuelType;
  final int currentMileage;
  final int? annualKmEstimate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Vehicle({
    required this.id,
    required this.userId,
    required this.make,
    required this.model,
    required this.year,
    this.vin,
    required this.fuelType,
    required this.currentMileage,
    this.annualKmEstimate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['make'] = Variable<String>(make);
    map['model'] = Variable<String>(model);
    map['year'] = Variable<int>(year);
    if (!nullToAbsent || vin != null) {
      map['vin'] = Variable<String>(vin);
    }
    map['fuel_type'] = Variable<String>(fuelType);
    map['current_mileage'] = Variable<int>(currentMileage);
    if (!nullToAbsent || annualKmEstimate != null) {
      map['annual_km_estimate'] = Variable<int>(annualKmEstimate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  VehiclesCompanion toCompanion(bool nullToAbsent) {
    return VehiclesCompanion(
      id: Value(id),
      userId: Value(userId),
      make: Value(make),
      model: Value(model),
      year: Value(year),
      vin: vin == null && nullToAbsent ? const Value.absent() : Value(vin),
      fuelType: Value(fuelType),
      currentMileage: Value(currentMileage),
      annualKmEstimate: annualKmEstimate == null && nullToAbsent
          ? const Value.absent()
          : Value(annualKmEstimate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Vehicle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vehicle(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      make: serializer.fromJson<String>(json['make']),
      model: serializer.fromJson<String>(json['model']),
      year: serializer.fromJson<int>(json['year']),
      vin: serializer.fromJson<String?>(json['vin']),
      fuelType: serializer.fromJson<String>(json['fuelType']),
      currentMileage: serializer.fromJson<int>(json['currentMileage']),
      annualKmEstimate: serializer.fromJson<int?>(json['annualKmEstimate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'make': serializer.toJson<String>(make),
      'model': serializer.toJson<String>(model),
      'year': serializer.toJson<int>(year),
      'vin': serializer.toJson<String?>(vin),
      'fuelType': serializer.toJson<String>(fuelType),
      'currentMileage': serializer.toJson<int>(currentMileage),
      'annualKmEstimate': serializer.toJson<int?>(annualKmEstimate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Vehicle copyWith({
    int? id,
    int? userId,
    String? make,
    String? model,
    int? year,
    Value<String?> vin = const Value.absent(),
    String? fuelType,
    int? currentMileage,
    Value<int?> annualKmEstimate = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Vehicle(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    make: make ?? this.make,
    model: model ?? this.model,
    year: year ?? this.year,
    vin: vin.present ? vin.value : this.vin,
    fuelType: fuelType ?? this.fuelType,
    currentMileage: currentMileage ?? this.currentMileage,
    annualKmEstimate: annualKmEstimate.present
        ? annualKmEstimate.value
        : this.annualKmEstimate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Vehicle copyWithCompanion(VehiclesCompanion data) {
    return Vehicle(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      make: data.make.present ? data.make.value : this.make,
      model: data.model.present ? data.model.value : this.model,
      year: data.year.present ? data.year.value : this.year,
      vin: data.vin.present ? data.vin.value : this.vin,
      fuelType: data.fuelType.present ? data.fuelType.value : this.fuelType,
      currentMileage: data.currentMileage.present
          ? data.currentMileage.value
          : this.currentMileage,
      annualKmEstimate: data.annualKmEstimate.present
          ? data.annualKmEstimate.value
          : this.annualKmEstimate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vehicle(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('vin: $vin, ')
          ..write('fuelType: $fuelType, ')
          ..write('currentMileage: $currentMileage, ')
          ..write('annualKmEstimate: $annualKmEstimate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    make,
    model,
    year,
    vin,
    fuelType,
    currentMileage,
    annualKmEstimate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vehicle &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.make == this.make &&
          other.model == this.model &&
          other.year == this.year &&
          other.vin == this.vin &&
          other.fuelType == this.fuelType &&
          other.currentMileage == this.currentMileage &&
          other.annualKmEstimate == this.annualKmEstimate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class VehiclesCompanion extends UpdateCompanion<Vehicle> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> make;
  final Value<String> model;
  final Value<int> year;
  final Value<String?> vin;
  final Value<String> fuelType;
  final Value<int> currentMileage;
  final Value<int?> annualKmEstimate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const VehiclesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.make = const Value.absent(),
    this.model = const Value.absent(),
    this.year = const Value.absent(),
    this.vin = const Value.absent(),
    this.fuelType = const Value.absent(),
    this.currentMileage = const Value.absent(),
    this.annualKmEstimate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  VehiclesCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String make,
    required String model,
    required int year,
    this.vin = const Value.absent(),
    required String fuelType,
    required int currentMileage,
    this.annualKmEstimate = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       make = Value(make),
       model = Value(model),
       year = Value(year),
       fuelType = Value(fuelType),
       currentMileage = Value(currentMileage),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Vehicle> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? make,
    Expression<String>? model,
    Expression<int>? year,
    Expression<String>? vin,
    Expression<String>? fuelType,
    Expression<int>? currentMileage,
    Expression<int>? annualKmEstimate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (make != null) 'make': make,
      if (model != null) 'model': model,
      if (year != null) 'year': year,
      if (vin != null) 'vin': vin,
      if (fuelType != null) 'fuel_type': fuelType,
      if (currentMileage != null) 'current_mileage': currentMileage,
      if (annualKmEstimate != null) 'annual_km_estimate': annualKmEstimate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  VehiclesCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<String>? make,
    Value<String>? model,
    Value<int>? year,
    Value<String?>? vin,
    Value<String>? fuelType,
    Value<int>? currentMileage,
    Value<int?>? annualKmEstimate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return VehiclesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      vin: vin ?? this.vin,
      fuelType: fuelType ?? this.fuelType,
      currentMileage: currentMileage ?? this.currentMileage,
      annualKmEstimate: annualKmEstimate ?? this.annualKmEstimate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (make.present) {
      map['make'] = Variable<String>(make.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (vin.present) {
      map['vin'] = Variable<String>(vin.value);
    }
    if (fuelType.present) {
      map['fuel_type'] = Variable<String>(fuelType.value);
    }
    if (currentMileage.present) {
      map['current_mileage'] = Variable<int>(currentMileage.value);
    }
    if (annualKmEstimate.present) {
      map['annual_km_estimate'] = Variable<int>(annualKmEstimate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('vin: $vin, ')
          ..write('fuelType: $fuelType, ')
          ..write('currentMileage: $currentMileage, ')
          ..write('annualKmEstimate: $annualKmEstimate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customLabelMeta = const VerificationMeta(
    'customLabel',
  );
  @override
  late final GeneratedColumn<String> customLabel = GeneratedColumn<String>(
    'custom_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueMileageMeta = const VerificationMeta(
    'dueMileage',
  );
  @override
  late final GeneratedColumn<int> dueMileage = GeneratedColumn<int>(
    'due_mileage',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notifyOffsetKmMeta = const VerificationMeta(
    'notifyOffsetKm',
  );
  @override
  late final GeneratedColumn<int> notifyOffsetKm = GeneratedColumn<int>(
    'notify_offset_km',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notifyOffsetsDaysMeta = const VerificationMeta(
    'notifyOffsetsDays',
  );
  @override
  late final GeneratedColumn<String> notifyOffsetsDays =
      GeneratedColumn<String>(
        'notify_offsets_days',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notifiedMeta = const VerificationMeta(
    'notified',
  );
  @override
  late final GeneratedColumn<bool> notified = GeneratedColumn<bool>(
    'notified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notified" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    type,
    customLabel,
    dueDate,
    dueMileage,
    notifyOffsetKm,
    notifyOffsetsDays,
    notified,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reminder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('custom_label')) {
      context.handle(
        _customLabelMeta,
        customLabel.isAcceptableOrUnknown(
          data['custom_label']!,
          _customLabelMeta,
        ),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('due_mileage')) {
      context.handle(
        _dueMileageMeta,
        dueMileage.isAcceptableOrUnknown(data['due_mileage']!, _dueMileageMeta),
      );
    }
    if (data.containsKey('notify_offset_km')) {
      context.handle(
        _notifyOffsetKmMeta,
        notifyOffsetKm.isAcceptableOrUnknown(
          data['notify_offset_km']!,
          _notifyOffsetKmMeta,
        ),
      );
    }
    if (data.containsKey('notify_offsets_days')) {
      context.handle(
        _notifyOffsetsDaysMeta,
        notifyOffsetsDays.isAcceptableOrUnknown(
          data['notify_offsets_days']!,
          _notifyOffsetsDaysMeta,
        ),
      );
    }
    if (data.containsKey('notified')) {
      context.handle(
        _notifiedMeta,
        notified.isAcceptableOrUnknown(data['notified']!, _notifiedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      customLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_label'],
      ),
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      dueMileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_mileage'],
      ),
      notifyOffsetKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notify_offset_km'],
      ),
      notifyOffsetsDays: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notify_offsets_days'],
      ),
      notified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notified'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final int id;
  final int vehicleId;
  final String type;
  final String? customLabel;
  final DateTime dueDate;
  final int? dueMileage;
  final int? notifyOffsetKm;
  final String? notifyOffsetsDays;
  final bool notified;
  final DateTime createdAt;
  const Reminder({
    required this.id,
    required this.vehicleId,
    required this.type,
    this.customLabel,
    required this.dueDate,
    this.dueMileage,
    this.notifyOffsetKm,
    this.notifyOffsetsDays,
    required this.notified,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || customLabel != null) {
      map['custom_label'] = Variable<String>(customLabel);
    }
    map['due_date'] = Variable<DateTime>(dueDate);
    if (!nullToAbsent || dueMileage != null) {
      map['due_mileage'] = Variable<int>(dueMileage);
    }
    if (!nullToAbsent || notifyOffsetKm != null) {
      map['notify_offset_km'] = Variable<int>(notifyOffsetKm);
    }
    if (!nullToAbsent || notifyOffsetsDays != null) {
      map['notify_offsets_days'] = Variable<String>(notifyOffsetsDays);
    }
    map['notified'] = Variable<bool>(notified);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      type: Value(type),
      customLabel: customLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(customLabel),
      dueDate: Value(dueDate),
      dueMileage: dueMileage == null && nullToAbsent
          ? const Value.absent()
          : Value(dueMileage),
      notifyOffsetKm: notifyOffsetKm == null && nullToAbsent
          ? const Value.absent()
          : Value(notifyOffsetKm),
      notifyOffsetsDays: notifyOffsetsDays == null && nullToAbsent
          ? const Value.absent()
          : Value(notifyOffsetsDays),
      notified: Value(notified),
      createdAt: Value(createdAt),
    );
  }

  factory Reminder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      type: serializer.fromJson<String>(json['type']),
      customLabel: serializer.fromJson<String?>(json['customLabel']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      dueMileage: serializer.fromJson<int?>(json['dueMileage']),
      notifyOffsetKm: serializer.fromJson<int?>(json['notifyOffsetKm']),
      notifyOffsetsDays: serializer.fromJson<String?>(
        json['notifyOffsetsDays'],
      ),
      notified: serializer.fromJson<bool>(json['notified']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'type': serializer.toJson<String>(type),
      'customLabel': serializer.toJson<String?>(customLabel),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'dueMileage': serializer.toJson<int?>(dueMileage),
      'notifyOffsetKm': serializer.toJson<int?>(notifyOffsetKm),
      'notifyOffsetsDays': serializer.toJson<String?>(notifyOffsetsDays),
      'notified': serializer.toJson<bool>(notified),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Reminder copyWith({
    int? id,
    int? vehicleId,
    String? type,
    Value<String?> customLabel = const Value.absent(),
    DateTime? dueDate,
    Value<int?> dueMileage = const Value.absent(),
    Value<int?> notifyOffsetKm = const Value.absent(),
    Value<String?> notifyOffsetsDays = const Value.absent(),
    bool? notified,
    DateTime? createdAt,
  }) => Reminder(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    type: type ?? this.type,
    customLabel: customLabel.present ? customLabel.value : this.customLabel,
    dueDate: dueDate ?? this.dueDate,
    dueMileage: dueMileage.present ? dueMileage.value : this.dueMileage,
    notifyOffsetKm: notifyOffsetKm.present
        ? notifyOffsetKm.value
        : this.notifyOffsetKm,
    notifyOffsetsDays: notifyOffsetsDays.present
        ? notifyOffsetsDays.value
        : this.notifyOffsetsDays,
    notified: notified ?? this.notified,
    createdAt: createdAt ?? this.createdAt,
  );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      type: data.type.present ? data.type.value : this.type,
      customLabel: data.customLabel.present
          ? data.customLabel.value
          : this.customLabel,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      dueMileage: data.dueMileage.present
          ? data.dueMileage.value
          : this.dueMileage,
      notifyOffsetKm: data.notifyOffsetKm.present
          ? data.notifyOffsetKm.value
          : this.notifyOffsetKm,
      notifyOffsetsDays: data.notifyOffsetsDays.present
          ? data.notifyOffsetsDays.value
          : this.notifyOffsetsDays,
      notified: data.notified.present ? data.notified.value : this.notified,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('type: $type, ')
          ..write('customLabel: $customLabel, ')
          ..write('dueDate: $dueDate, ')
          ..write('dueMileage: $dueMileage, ')
          ..write('notifyOffsetKm: $notifyOffsetKm, ')
          ..write('notifyOffsetsDays: $notifyOffsetsDays, ')
          ..write('notified: $notified, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    type,
    customLabel,
    dueDate,
    dueMileage,
    notifyOffsetKm,
    notifyOffsetsDays,
    notified,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.type == this.type &&
          other.customLabel == this.customLabel &&
          other.dueDate == this.dueDate &&
          other.dueMileage == this.dueMileage &&
          other.notifyOffsetKm == this.notifyOffsetKm &&
          other.notifyOffsetsDays == this.notifyOffsetsDays &&
          other.notified == this.notified &&
          other.createdAt == this.createdAt);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<String> type;
  final Value<String?> customLabel;
  final Value<DateTime> dueDate;
  final Value<int?> dueMileage;
  final Value<int?> notifyOffsetKm;
  final Value<String?> notifyOffsetsDays;
  final Value<bool> notified;
  final Value<DateTime> createdAt;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.type = const Value.absent(),
    this.customLabel = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.dueMileage = const Value.absent(),
    this.notifyOffsetKm = const Value.absent(),
    this.notifyOffsetsDays = const Value.absent(),
    this.notified = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RemindersCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required String type,
    this.customLabel = const Value.absent(),
    required DateTime dueDate,
    this.dueMileage = const Value.absent(),
    this.notifyOffsetKm = const Value.absent(),
    this.notifyOffsetsDays = const Value.absent(),
    this.notified = const Value.absent(),
    required DateTime createdAt,
  }) : vehicleId = Value(vehicleId),
       type = Value(type),
       dueDate = Value(dueDate),
       createdAt = Value(createdAt);
  static Insertable<Reminder> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<String>? type,
    Expression<String>? customLabel,
    Expression<DateTime>? dueDate,
    Expression<int>? dueMileage,
    Expression<int>? notifyOffsetKm,
    Expression<String>? notifyOffsetsDays,
    Expression<bool>? notified,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (type != null) 'type': type,
      if (customLabel != null) 'custom_label': customLabel,
      if (dueDate != null) 'due_date': dueDate,
      if (dueMileage != null) 'due_mileage': dueMileage,
      if (notifyOffsetKm != null) 'notify_offset_km': notifyOffsetKm,
      if (notifyOffsetsDays != null) 'notify_offsets_days': notifyOffsetsDays,
      if (notified != null) 'notified': notified,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RemindersCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<String>? type,
    Value<String?>? customLabel,
    Value<DateTime>? dueDate,
    Value<int?>? dueMileage,
    Value<int?>? notifyOffsetKm,
    Value<String?>? notifyOffsetsDays,
    Value<bool>? notified,
    Value<DateTime>? createdAt,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      type: type ?? this.type,
      customLabel: customLabel ?? this.customLabel,
      dueDate: dueDate ?? this.dueDate,
      dueMileage: dueMileage ?? this.dueMileage,
      notifyOffsetKm: notifyOffsetKm ?? this.notifyOffsetKm,
      notifyOffsetsDays: notifyOffsetsDays ?? this.notifyOffsetsDays,
      notified: notified ?? this.notified,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (customLabel.present) {
      map['custom_label'] = Variable<String>(customLabel.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (dueMileage.present) {
      map['due_mileage'] = Variable<int>(dueMileage.value);
    }
    if (notifyOffsetKm.present) {
      map['notify_offset_km'] = Variable<int>(notifyOffsetKm.value);
    }
    if (notifyOffsetsDays.present) {
      map['notify_offsets_days'] = Variable<String>(notifyOffsetsDays.value);
    }
    if (notified.present) {
      map['notified'] = Variable<bool>(notified.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('type: $type, ')
          ..write('customLabel: $customLabel, ')
          ..write('dueDate: $dueDate, ')
          ..write('dueMileage: $dueMileage, ')
          ..write('notifyOffsetKm: $notifyOffsetKm, ')
          ..write('notifyOffsetsDays: $notifyOffsetsDays, ')
          ..write('notified: $notified, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MaintenanceHistoryTableTable extends MaintenanceHistoryTable
    with TableInfo<$MaintenanceHistoryTableTable, MaintenanceHistoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceHistoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customLabelMeta = const VerificationMeta(
    'customLabel',
  );
  @override
  late final GeneratedColumn<String> customLabel = GeneratedColumn<String>(
    'custom_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedDateMeta = const VerificationMeta(
    'completedDate',
  );
  @override
  late final GeneratedColumn<DateTime> completedDate =
      GeneratedColumn<DateTime>(
        'completed_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _mileageAtCompletionMeta =
      const VerificationMeta('mileageAtCompletion');
  @override
  late final GeneratedColumn<int> mileageAtCompletion = GeneratedColumn<int>(
    'mileage_at_completion',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workshopNameMeta = const VerificationMeta(
    'workshopName',
  );
  @override
  late final GeneratedColumn<String> workshopName = GeneratedColumn<String>(
    'workshop_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
    'cost',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    type,
    customLabel,
    completedDate,
    mileageAtCompletion,
    notes,
    workshopName,
    cost,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_history_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaintenanceHistoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('custom_label')) {
      context.handle(
        _customLabelMeta,
        customLabel.isAcceptableOrUnknown(
          data['custom_label']!,
          _customLabelMeta,
        ),
      );
    }
    if (data.containsKey('completed_date')) {
      context.handle(
        _completedDateMeta,
        completedDate.isAcceptableOrUnknown(
          data['completed_date']!,
          _completedDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedDateMeta);
    }
    if (data.containsKey('mileage_at_completion')) {
      context.handle(
        _mileageAtCompletionMeta,
        mileageAtCompletion.isAcceptableOrUnknown(
          data['mileage_at_completion']!,
          _mileageAtCompletionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mileageAtCompletionMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('workshop_name')) {
      context.handle(
        _workshopNameMeta,
        workshopName.isAcceptableOrUnknown(
          data['workshop_name']!,
          _workshopNameMeta,
        ),
      );
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaintenanceHistoryTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceHistoryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      customLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_label'],
      ),
      completedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_date'],
      )!,
      mileageAtCompletion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mileage_at_completion'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      workshopName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workshop_name'],
      ),
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost'],
      ),
    );
  }

  @override
  $MaintenanceHistoryTableTable createAlias(String alias) {
    return $MaintenanceHistoryTableTable(attachedDatabase, alias);
  }
}

class MaintenanceHistoryTableData extends DataClass
    implements Insertable<MaintenanceHistoryTableData> {
  final int id;
  final int vehicleId;
  final String type;
  final String? customLabel;
  final DateTime completedDate;
  final int mileageAtCompletion;
  final String? notes;
  final String? workshopName;
  final double? cost;
  const MaintenanceHistoryTableData({
    required this.id,
    required this.vehicleId,
    required this.type,
    this.customLabel,
    required this.completedDate,
    required this.mileageAtCompletion,
    this.notes,
    this.workshopName,
    this.cost,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || customLabel != null) {
      map['custom_label'] = Variable<String>(customLabel);
    }
    map['completed_date'] = Variable<DateTime>(completedDate);
    map['mileage_at_completion'] = Variable<int>(mileageAtCompletion);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || workshopName != null) {
      map['workshop_name'] = Variable<String>(workshopName);
    }
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<double>(cost);
    }
    return map;
  }

  MaintenanceHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceHistoryTableCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      type: Value(type),
      customLabel: customLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(customLabel),
      completedDate: Value(completedDate),
      mileageAtCompletion: Value(mileageAtCompletion),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      workshopName: workshopName == null && nullToAbsent
          ? const Value.absent()
          : Value(workshopName),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
    );
  }

  factory MaintenanceHistoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceHistoryTableData(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      type: serializer.fromJson<String>(json['type']),
      customLabel: serializer.fromJson<String?>(json['customLabel']),
      completedDate: serializer.fromJson<DateTime>(json['completedDate']),
      mileageAtCompletion: serializer.fromJson<int>(
        json['mileageAtCompletion'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      workshopName: serializer.fromJson<String?>(json['workshopName']),
      cost: serializer.fromJson<double?>(json['cost']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'type': serializer.toJson<String>(type),
      'customLabel': serializer.toJson<String?>(customLabel),
      'completedDate': serializer.toJson<DateTime>(completedDate),
      'mileageAtCompletion': serializer.toJson<int>(mileageAtCompletion),
      'notes': serializer.toJson<String?>(notes),
      'workshopName': serializer.toJson<String?>(workshopName),
      'cost': serializer.toJson<double?>(cost),
    };
  }

  MaintenanceHistoryTableData copyWith({
    int? id,
    int? vehicleId,
    String? type,
    Value<String?> customLabel = const Value.absent(),
    DateTime? completedDate,
    int? mileageAtCompletion,
    Value<String?> notes = const Value.absent(),
    Value<String?> workshopName = const Value.absent(),
    Value<double?> cost = const Value.absent(),
  }) => MaintenanceHistoryTableData(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    type: type ?? this.type,
    customLabel: customLabel.present ? customLabel.value : this.customLabel,
    completedDate: completedDate ?? this.completedDate,
    mileageAtCompletion: mileageAtCompletion ?? this.mileageAtCompletion,
    notes: notes.present ? notes.value : this.notes,
    workshopName: workshopName.present ? workshopName.value : this.workshopName,
    cost: cost.present ? cost.value : this.cost,
  );
  MaintenanceHistoryTableData copyWithCompanion(
    MaintenanceHistoryTableCompanion data,
  ) {
    return MaintenanceHistoryTableData(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      type: data.type.present ? data.type.value : this.type,
      customLabel: data.customLabel.present
          ? data.customLabel.value
          : this.customLabel,
      completedDate: data.completedDate.present
          ? data.completedDate.value
          : this.completedDate,
      mileageAtCompletion: data.mileageAtCompletion.present
          ? data.mileageAtCompletion.value
          : this.mileageAtCompletion,
      notes: data.notes.present ? data.notes.value : this.notes,
      workshopName: data.workshopName.present
          ? data.workshopName.value
          : this.workshopName,
      cost: data.cost.present ? data.cost.value : this.cost,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceHistoryTableData(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('type: $type, ')
          ..write('customLabel: $customLabel, ')
          ..write('completedDate: $completedDate, ')
          ..write('mileageAtCompletion: $mileageAtCompletion, ')
          ..write('notes: $notes, ')
          ..write('workshopName: $workshopName, ')
          ..write('cost: $cost')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    type,
    customLabel,
    completedDate,
    mileageAtCompletion,
    notes,
    workshopName,
    cost,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceHistoryTableData &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.type == this.type &&
          other.customLabel == this.customLabel &&
          other.completedDate == this.completedDate &&
          other.mileageAtCompletion == this.mileageAtCompletion &&
          other.notes == this.notes &&
          other.workshopName == this.workshopName &&
          other.cost == this.cost);
}

class MaintenanceHistoryTableCompanion
    extends UpdateCompanion<MaintenanceHistoryTableData> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<String> type;
  final Value<String?> customLabel;
  final Value<DateTime> completedDate;
  final Value<int> mileageAtCompletion;
  final Value<String?> notes;
  final Value<String?> workshopName;
  final Value<double?> cost;
  const MaintenanceHistoryTableCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.type = const Value.absent(),
    this.customLabel = const Value.absent(),
    this.completedDate = const Value.absent(),
    this.mileageAtCompletion = const Value.absent(),
    this.notes = const Value.absent(),
    this.workshopName = const Value.absent(),
    this.cost = const Value.absent(),
  });
  MaintenanceHistoryTableCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required String type,
    this.customLabel = const Value.absent(),
    required DateTime completedDate,
    required int mileageAtCompletion,
    this.notes = const Value.absent(),
    this.workshopName = const Value.absent(),
    this.cost = const Value.absent(),
  }) : vehicleId = Value(vehicleId),
       type = Value(type),
       completedDate = Value(completedDate),
       mileageAtCompletion = Value(mileageAtCompletion);
  static Insertable<MaintenanceHistoryTableData> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<String>? type,
    Expression<String>? customLabel,
    Expression<DateTime>? completedDate,
    Expression<int>? mileageAtCompletion,
    Expression<String>? notes,
    Expression<String>? workshopName,
    Expression<double>? cost,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (type != null) 'type': type,
      if (customLabel != null) 'custom_label': customLabel,
      if (completedDate != null) 'completed_date': completedDate,
      if (mileageAtCompletion != null)
        'mileage_at_completion': mileageAtCompletion,
      if (notes != null) 'notes': notes,
      if (workshopName != null) 'workshop_name': workshopName,
      if (cost != null) 'cost': cost,
    });
  }

  MaintenanceHistoryTableCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<String>? type,
    Value<String?>? customLabel,
    Value<DateTime>? completedDate,
    Value<int>? mileageAtCompletion,
    Value<String?>? notes,
    Value<String?>? workshopName,
    Value<double?>? cost,
  }) {
    return MaintenanceHistoryTableCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      type: type ?? this.type,
      customLabel: customLabel ?? this.customLabel,
      completedDate: completedDate ?? this.completedDate,
      mileageAtCompletion: mileageAtCompletion ?? this.mileageAtCompletion,
      notes: notes ?? this.notes,
      workshopName: workshopName ?? this.workshopName,
      cost: cost ?? this.cost,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (customLabel.present) {
      map['custom_label'] = Variable<String>(customLabel.value);
    }
    if (completedDate.present) {
      map['completed_date'] = Variable<DateTime>(completedDate.value);
    }
    if (mileageAtCompletion.present) {
      map['mileage_at_completion'] = Variable<int>(mileageAtCompletion.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (workshopName.present) {
      map['workshop_name'] = Variable<String>(workshopName.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('type: $type, ')
          ..write('customLabel: $customLabel, ')
          ..write('completedDate: $completedDate, ')
          ..write('mileageAtCompletion: $mileageAtCompletion, ')
          ..write('notes: $notes, ')
          ..write('workshopName: $workshopName, ')
          ..write('cost: $cost')
          ..write(')'))
        .toString();
  }
}

class $ConsumablesTableTable extends ConsumablesTable
    with TableInfo<$ConsumablesTableTable, ConsumablesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConsumablesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _engineOilGradeMeta = const VerificationMeta(
    'engineOilGrade',
  );
  @override
  late final GeneratedColumn<String> engineOilGrade = GeneratedColumn<String>(
    'engine_oil_grade',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _engineOilVolumeMeta = const VerificationMeta(
    'engineOilVolume',
  );
  @override
  late final GeneratedColumn<double> engineOilVolume = GeneratedColumn<double>(
    'engine_oil_volume',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coolantTypeMeta = const VerificationMeta(
    'coolantType',
  );
  @override
  late final GeneratedColumn<String> coolantType = GeneratedColumn<String>(
    'coolant_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brakeFluidSpecMeta = const VerificationMeta(
    'brakeFluidSpec',
  );
  @override
  late final GeneratedColumn<String> brakeFluidSpec = GeneratedColumn<String>(
    'brake_fluid_spec',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transmissionFluidMeta = const VerificationMeta(
    'transmissionFluid',
  );
  @override
  late final GeneratedColumn<String> transmissionFluid =
      GeneratedColumn<String>(
        'transmission_fluid',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    engineOilGrade,
    engineOilVolume,
    coolantType,
    brakeFluidSpec,
    transmissionFluid,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'consumables_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ConsumablesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('engine_oil_grade')) {
      context.handle(
        _engineOilGradeMeta,
        engineOilGrade.isAcceptableOrUnknown(
          data['engine_oil_grade']!,
          _engineOilGradeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_engineOilGradeMeta);
    }
    if (data.containsKey('engine_oil_volume')) {
      context.handle(
        _engineOilVolumeMeta,
        engineOilVolume.isAcceptableOrUnknown(
          data['engine_oil_volume']!,
          _engineOilVolumeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_engineOilVolumeMeta);
    }
    if (data.containsKey('coolant_type')) {
      context.handle(
        _coolantTypeMeta,
        coolantType.isAcceptableOrUnknown(
          data['coolant_type']!,
          _coolantTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coolantTypeMeta);
    }
    if (data.containsKey('brake_fluid_spec')) {
      context.handle(
        _brakeFluidSpecMeta,
        brakeFluidSpec.isAcceptableOrUnknown(
          data['brake_fluid_spec']!,
          _brakeFluidSpecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_brakeFluidSpecMeta);
    }
    if (data.containsKey('transmission_fluid')) {
      context.handle(
        _transmissionFluidMeta,
        transmissionFluid.isAcceptableOrUnknown(
          data['transmission_fluid']!,
          _transmissionFluidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transmissionFluidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConsumablesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConsumablesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      engineOilGrade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}engine_oil_grade'],
      )!,
      engineOilVolume: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}engine_oil_volume'],
      )!,
      coolantType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coolant_type'],
      )!,
      brakeFluidSpec: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brake_fluid_spec'],
      )!,
      transmissionFluid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transmission_fluid'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ConsumablesTableTable createAlias(String alias) {
    return $ConsumablesTableTable(attachedDatabase, alias);
  }
}

class ConsumablesTableData extends DataClass
    implements Insertable<ConsumablesTableData> {
  final int id;
  final int vehicleId;
  final String engineOilGrade;
  final double engineOilVolume;
  final String coolantType;
  final String brakeFluidSpec;
  final String transmissionFluid;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ConsumablesTableData({
    required this.id,
    required this.vehicleId,
    required this.engineOilGrade,
    required this.engineOilVolume,
    required this.coolantType,
    required this.brakeFluidSpec,
    required this.transmissionFluid,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['engine_oil_grade'] = Variable<String>(engineOilGrade);
    map['engine_oil_volume'] = Variable<double>(engineOilVolume);
    map['coolant_type'] = Variable<String>(coolantType);
    map['brake_fluid_spec'] = Variable<String>(brakeFluidSpec);
    map['transmission_fluid'] = Variable<String>(transmissionFluid);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ConsumablesTableCompanion toCompanion(bool nullToAbsent) {
    return ConsumablesTableCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      engineOilGrade: Value(engineOilGrade),
      engineOilVolume: Value(engineOilVolume),
      coolantType: Value(coolantType),
      brakeFluidSpec: Value(brakeFluidSpec),
      transmissionFluid: Value(transmissionFluid),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ConsumablesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConsumablesTableData(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      engineOilGrade: serializer.fromJson<String>(json['engineOilGrade']),
      engineOilVolume: serializer.fromJson<double>(json['engineOilVolume']),
      coolantType: serializer.fromJson<String>(json['coolantType']),
      brakeFluidSpec: serializer.fromJson<String>(json['brakeFluidSpec']),
      transmissionFluid: serializer.fromJson<String>(json['transmissionFluid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'engineOilGrade': serializer.toJson<String>(engineOilGrade),
      'engineOilVolume': serializer.toJson<double>(engineOilVolume),
      'coolantType': serializer.toJson<String>(coolantType),
      'brakeFluidSpec': serializer.toJson<String>(brakeFluidSpec),
      'transmissionFluid': serializer.toJson<String>(transmissionFluid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ConsumablesTableData copyWith({
    int? id,
    int? vehicleId,
    String? engineOilGrade,
    double? engineOilVolume,
    String? coolantType,
    String? brakeFluidSpec,
    String? transmissionFluid,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ConsumablesTableData(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    engineOilGrade: engineOilGrade ?? this.engineOilGrade,
    engineOilVolume: engineOilVolume ?? this.engineOilVolume,
    coolantType: coolantType ?? this.coolantType,
    brakeFluidSpec: brakeFluidSpec ?? this.brakeFluidSpec,
    transmissionFluid: transmissionFluid ?? this.transmissionFluid,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ConsumablesTableData copyWithCompanion(ConsumablesTableCompanion data) {
    return ConsumablesTableData(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      engineOilGrade: data.engineOilGrade.present
          ? data.engineOilGrade.value
          : this.engineOilGrade,
      engineOilVolume: data.engineOilVolume.present
          ? data.engineOilVolume.value
          : this.engineOilVolume,
      coolantType: data.coolantType.present
          ? data.coolantType.value
          : this.coolantType,
      brakeFluidSpec: data.brakeFluidSpec.present
          ? data.brakeFluidSpec.value
          : this.brakeFluidSpec,
      transmissionFluid: data.transmissionFluid.present
          ? data.transmissionFluid.value
          : this.transmissionFluid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConsumablesTableData(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('engineOilGrade: $engineOilGrade, ')
          ..write('engineOilVolume: $engineOilVolume, ')
          ..write('coolantType: $coolantType, ')
          ..write('brakeFluidSpec: $brakeFluidSpec, ')
          ..write('transmissionFluid: $transmissionFluid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    engineOilGrade,
    engineOilVolume,
    coolantType,
    brakeFluidSpec,
    transmissionFluid,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConsumablesTableData &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.engineOilGrade == this.engineOilGrade &&
          other.engineOilVolume == this.engineOilVolume &&
          other.coolantType == this.coolantType &&
          other.brakeFluidSpec == this.brakeFluidSpec &&
          other.transmissionFluid == this.transmissionFluid &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ConsumablesTableCompanion extends UpdateCompanion<ConsumablesTableData> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<String> engineOilGrade;
  final Value<double> engineOilVolume;
  final Value<String> coolantType;
  final Value<String> brakeFluidSpec;
  final Value<String> transmissionFluid;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ConsumablesTableCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.engineOilGrade = const Value.absent(),
    this.engineOilVolume = const Value.absent(),
    this.coolantType = const Value.absent(),
    this.brakeFluidSpec = const Value.absent(),
    this.transmissionFluid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ConsumablesTableCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required String engineOilGrade,
    required double engineOilVolume,
    required String coolantType,
    required String brakeFluidSpec,
    required String transmissionFluid,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : vehicleId = Value(vehicleId),
       engineOilGrade = Value(engineOilGrade),
       engineOilVolume = Value(engineOilVolume),
       coolantType = Value(coolantType),
       brakeFluidSpec = Value(brakeFluidSpec),
       transmissionFluid = Value(transmissionFluid),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ConsumablesTableData> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<String>? engineOilGrade,
    Expression<double>? engineOilVolume,
    Expression<String>? coolantType,
    Expression<String>? brakeFluidSpec,
    Expression<String>? transmissionFluid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (engineOilGrade != null) 'engine_oil_grade': engineOilGrade,
      if (engineOilVolume != null) 'engine_oil_volume': engineOilVolume,
      if (coolantType != null) 'coolant_type': coolantType,
      if (brakeFluidSpec != null) 'brake_fluid_spec': brakeFluidSpec,
      if (transmissionFluid != null) 'transmission_fluid': transmissionFluid,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ConsumablesTableCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<String>? engineOilGrade,
    Value<double>? engineOilVolume,
    Value<String>? coolantType,
    Value<String>? brakeFluidSpec,
    Value<String>? transmissionFluid,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ConsumablesTableCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      engineOilGrade: engineOilGrade ?? this.engineOilGrade,
      engineOilVolume: engineOilVolume ?? this.engineOilVolume,
      coolantType: coolantType ?? this.coolantType,
      brakeFluidSpec: brakeFluidSpec ?? this.brakeFluidSpec,
      transmissionFluid: transmissionFluid ?? this.transmissionFluid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (engineOilGrade.present) {
      map['engine_oil_grade'] = Variable<String>(engineOilGrade.value);
    }
    if (engineOilVolume.present) {
      map['engine_oil_volume'] = Variable<double>(engineOilVolume.value);
    }
    if (coolantType.present) {
      map['coolant_type'] = Variable<String>(coolantType.value);
    }
    if (brakeFluidSpec.present) {
      map['brake_fluid_spec'] = Variable<String>(brakeFluidSpec.value);
    }
    if (transmissionFluid.present) {
      map['transmission_fluid'] = Variable<String>(transmissionFluid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConsumablesTableCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('engineOilGrade: $engineOilGrade, ')
          ..write('engineOilVolume: $engineOilVolume, ')
          ..write('coolantType: $coolantType, ')
          ..write('brakeFluidSpec: $brakeFluidSpec, ')
          ..write('transmissionFluid: $transmissionFluid, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String value;
  const AppSetting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(key: Value(key), value: Value(value));
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppSetting copyWith({String? key, String? value}) =>
      AppSetting(key: key ?? this.key, value: value ?? this.value);
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FuelEntriesTable extends FuelEntries
    with TableInfo<$FuelEntriesTable, FuelEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FuelEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _litersMeta = const VerificationMeta('liters');
  @override
  late final GeneratedColumn<double> liters = GeneratedColumn<double>(
    'liters',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerKmMeta = const VerificationMeta(
    'odometerKm',
  );
  @override
  late final GeneratedColumn<int> odometerKm = GeneratedColumn<int>(
    'odometer_km',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fuelGradeMeta = const VerificationMeta(
    'fuelGrade',
  );
  @override
  late final GeneratedColumn<String> fuelGrade = GeneratedColumn<String>(
    'fuel_grade',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pricePerLiterMeta = const VerificationMeta(
    'pricePerLiter',
  );
  @override
  late final GeneratedColumn<double> pricePerLiter = GeneratedColumn<double>(
    'price_per_liter',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fullTankMeta = const VerificationMeta(
    'fullTank',
  );
  @override
  late final GeneratedColumn<bool> fullTank = GeneratedColumn<bool>(
    'full_tank',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("full_tank" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    date,
    liters,
    odometerKm,
    fuelGrade,
    pricePerLiter,
    fullTank,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fuel_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<FuelEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('liters')) {
      context.handle(
        _litersMeta,
        liters.isAcceptableOrUnknown(data['liters']!, _litersMeta),
      );
    } else if (isInserting) {
      context.missing(_litersMeta);
    }
    if (data.containsKey('odometer_km')) {
      context.handle(
        _odometerKmMeta,
        odometerKm.isAcceptableOrUnknown(data['odometer_km']!, _odometerKmMeta),
      );
    } else if (isInserting) {
      context.missing(_odometerKmMeta);
    }
    if (data.containsKey('fuel_grade')) {
      context.handle(
        _fuelGradeMeta,
        fuelGrade.isAcceptableOrUnknown(data['fuel_grade']!, _fuelGradeMeta),
      );
    }
    if (data.containsKey('price_per_liter')) {
      context.handle(
        _pricePerLiterMeta,
        pricePerLiter.isAcceptableOrUnknown(
          data['price_per_liter']!,
          _pricePerLiterMeta,
        ),
      );
    }
    if (data.containsKey('full_tank')) {
      context.handle(
        _fullTankMeta,
        fullTank.isAcceptableOrUnknown(data['full_tank']!, _fullTankMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FuelEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FuelEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      liters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}liters'],
      )!,
      odometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer_km'],
      )!,
      fuelGrade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fuel_grade'],
      ),
      pricePerLiter: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_per_liter'],
      ),
      fullTank: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}full_tank'],
      )!,
    );
  }

  @override
  $FuelEntriesTable createAlias(String alias) {
    return $FuelEntriesTable(attachedDatabase, alias);
  }
}

class FuelEntry extends DataClass implements Insertable<FuelEntry> {
  final int id;
  final int vehicleId;
  final DateTime date;
  final double liters;
  final int odometerKm;
  final String? fuelGrade;
  final double? pricePerLiter;
  final bool fullTank;
  const FuelEntry({
    required this.id,
    required this.vehicleId,
    required this.date,
    required this.liters,
    required this.odometerKm,
    this.fuelGrade,
    this.pricePerLiter,
    required this.fullTank,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['date'] = Variable<DateTime>(date);
    map['liters'] = Variable<double>(liters);
    map['odometer_km'] = Variable<int>(odometerKm);
    if (!nullToAbsent || fuelGrade != null) {
      map['fuel_grade'] = Variable<String>(fuelGrade);
    }
    if (!nullToAbsent || pricePerLiter != null) {
      map['price_per_liter'] = Variable<double>(pricePerLiter);
    }
    map['full_tank'] = Variable<bool>(fullTank);
    return map;
  }

  FuelEntriesCompanion toCompanion(bool nullToAbsent) {
    return FuelEntriesCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      date: Value(date),
      liters: Value(liters),
      odometerKm: Value(odometerKm),
      fuelGrade: fuelGrade == null && nullToAbsent
          ? const Value.absent()
          : Value(fuelGrade),
      pricePerLiter: pricePerLiter == null && nullToAbsent
          ? const Value.absent()
          : Value(pricePerLiter),
      fullTank: Value(fullTank),
    );
  }

  factory FuelEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FuelEntry(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      date: serializer.fromJson<DateTime>(json['date']),
      liters: serializer.fromJson<double>(json['liters']),
      odometerKm: serializer.fromJson<int>(json['odometerKm']),
      fuelGrade: serializer.fromJson<String?>(json['fuelGrade']),
      pricePerLiter: serializer.fromJson<double?>(json['pricePerLiter']),
      fullTank: serializer.fromJson<bool>(json['fullTank']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'date': serializer.toJson<DateTime>(date),
      'liters': serializer.toJson<double>(liters),
      'odometerKm': serializer.toJson<int>(odometerKm),
      'fuelGrade': serializer.toJson<String?>(fuelGrade),
      'pricePerLiter': serializer.toJson<double?>(pricePerLiter),
      'fullTank': serializer.toJson<bool>(fullTank),
    };
  }

  FuelEntry copyWith({
    int? id,
    int? vehicleId,
    DateTime? date,
    double? liters,
    int? odometerKm,
    Value<String?> fuelGrade = const Value.absent(),
    Value<double?> pricePerLiter = const Value.absent(),
    bool? fullTank,
  }) => FuelEntry(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    date: date ?? this.date,
    liters: liters ?? this.liters,
    odometerKm: odometerKm ?? this.odometerKm,
    fuelGrade: fuelGrade.present ? fuelGrade.value : this.fuelGrade,
    pricePerLiter: pricePerLiter.present
        ? pricePerLiter.value
        : this.pricePerLiter,
    fullTank: fullTank ?? this.fullTank,
  );
  FuelEntry copyWithCompanion(FuelEntriesCompanion data) {
    return FuelEntry(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      date: data.date.present ? data.date.value : this.date,
      liters: data.liters.present ? data.liters.value : this.liters,
      odometerKm: data.odometerKm.present
          ? data.odometerKm.value
          : this.odometerKm,
      fuelGrade: data.fuelGrade.present ? data.fuelGrade.value : this.fuelGrade,
      pricePerLiter: data.pricePerLiter.present
          ? data.pricePerLiter.value
          : this.pricePerLiter,
      fullTank: data.fullTank.present ? data.fullTank.value : this.fullTank,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FuelEntry(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('date: $date, ')
          ..write('liters: $liters, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('fuelGrade: $fuelGrade, ')
          ..write('pricePerLiter: $pricePerLiter, ')
          ..write('fullTank: $fullTank')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    date,
    liters,
    odometerKm,
    fuelGrade,
    pricePerLiter,
    fullTank,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FuelEntry &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.date == this.date &&
          other.liters == this.liters &&
          other.odometerKm == this.odometerKm &&
          other.fuelGrade == this.fuelGrade &&
          other.pricePerLiter == this.pricePerLiter &&
          other.fullTank == this.fullTank);
}

class FuelEntriesCompanion extends UpdateCompanion<FuelEntry> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<DateTime> date;
  final Value<double> liters;
  final Value<int> odometerKm;
  final Value<String?> fuelGrade;
  final Value<double?> pricePerLiter;
  final Value<bool> fullTank;
  const FuelEntriesCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.date = const Value.absent(),
    this.liters = const Value.absent(),
    this.odometerKm = const Value.absent(),
    this.fuelGrade = const Value.absent(),
    this.pricePerLiter = const Value.absent(),
    this.fullTank = const Value.absent(),
  });
  FuelEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required DateTime date,
    required double liters,
    required int odometerKm,
    this.fuelGrade = const Value.absent(),
    this.pricePerLiter = const Value.absent(),
    this.fullTank = const Value.absent(),
  }) : vehicleId = Value(vehicleId),
       date = Value(date),
       liters = Value(liters),
       odometerKm = Value(odometerKm);
  static Insertable<FuelEntry> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<DateTime>? date,
    Expression<double>? liters,
    Expression<int>? odometerKm,
    Expression<String>? fuelGrade,
    Expression<double>? pricePerLiter,
    Expression<bool>? fullTank,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (date != null) 'date': date,
      if (liters != null) 'liters': liters,
      if (odometerKm != null) 'odometer_km': odometerKm,
      if (fuelGrade != null) 'fuel_grade': fuelGrade,
      if (pricePerLiter != null) 'price_per_liter': pricePerLiter,
      if (fullTank != null) 'full_tank': fullTank,
    });
  }

  FuelEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<DateTime>? date,
    Value<double>? liters,
    Value<int>? odometerKm,
    Value<String?>? fuelGrade,
    Value<double?>? pricePerLiter,
    Value<bool>? fullTank,
  }) {
    return FuelEntriesCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      date: date ?? this.date,
      liters: liters ?? this.liters,
      odometerKm: odometerKm ?? this.odometerKm,
      fuelGrade: fuelGrade ?? this.fuelGrade,
      pricePerLiter: pricePerLiter ?? this.pricePerLiter,
      fullTank: fullTank ?? this.fullTank,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (liters.present) {
      map['liters'] = Variable<double>(liters.value);
    }
    if (odometerKm.present) {
      map['odometer_km'] = Variable<int>(odometerKm.value);
    }
    if (fuelGrade.present) {
      map['fuel_grade'] = Variable<String>(fuelGrade.value);
    }
    if (pricePerLiter.present) {
      map['price_per_liter'] = Variable<double>(pricePerLiter.value);
    }
    if (fullTank.present) {
      map['full_tank'] = Variable<bool>(fullTank.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FuelEntriesCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('date: $date, ')
          ..write('liters: $liters, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('fuelGrade: $fuelGrade, ')
          ..write('pricePerLiter: $pricePerLiter, ')
          ..write('fullTank: $fullTank')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $VehiclesTable vehicles = $VehiclesTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $MaintenanceHistoryTableTable maintenanceHistoryTable =
      $MaintenanceHistoryTableTable(this);
  late final $ConsumablesTableTable consumablesTable = $ConsumablesTableTable(
    this,
  );
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $FuelEntriesTable fuelEntries = $FuelEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    vehicles,
    reminders,
    maintenanceHistoryTable,
    consumablesTable,
    appSettings,
    fuelEntries,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String name,
      required String email,
      Value<String?> skillLevel,
      Value<bool> onboardingComplete,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> email,
      Value<String?> skillLevel,
      Value<bool> onboardingComplete,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VehiclesTable, List<Vehicle>> _vehiclesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.vehicles,
    aliasName: $_aliasNameGenerator(db.users.id, db.vehicles.userId),
  );

  $$VehiclesTableProcessedTableManager get vehiclesRefs {
    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_vehiclesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skillLevel => $composableBuilder(
    column: $table.skillLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> vehiclesRefs(
    Expression<bool> Function($$VehiclesTableFilterComposer f) f,
  ) {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skillLevel => $composableBuilder(
    column: $table.skillLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get skillLevel => $composableBuilder(
    column: $table.skillLevel,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> vehiclesRefs<T extends Object>(
    Expression<T> Function($$VehiclesTableAnnotationComposer a) f,
  ) {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({bool vehiclesRefs})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String?> skillLevel = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                email: email,
                skillLevel: skillLevel,
                onboardingComplete: onboardingComplete,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String email,
                Value<String?> skillLevel = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                email: email,
                skillLevel: skillLevel,
                onboardingComplete: onboardingComplete,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({vehiclesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (vehiclesRefs) db.vehicles],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (vehiclesRefs)
                    await $_getPrefetchedData<User, $UsersTable, Vehicle>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences
                          ._vehiclesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UsersTableReferences(db, table, p0).vehiclesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({bool vehiclesRefs})
    >;
typedef $$VehiclesTableCreateCompanionBuilder =
    VehiclesCompanion Function({
      Value<int> id,
      required int userId,
      required String make,
      required String model,
      required int year,
      Value<String?> vin,
      required String fuelType,
      required int currentMileage,
      Value<int?> annualKmEstimate,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$VehiclesTableUpdateCompanionBuilder =
    VehiclesCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<String> make,
      Value<String> model,
      Value<int> year,
      Value<String?> vin,
      Value<String> fuelType,
      Value<int> currentMileage,
      Value<int?> annualKmEstimate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$VehiclesTableReferences
    extends BaseReferences<_$AppDatabase, $VehiclesTable, Vehicle> {
  $$VehiclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.vehicles.userId, db.users.id),
  );

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RemindersTable, List<Reminder>>
  _remindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminders,
    aliasName: $_aliasNameGenerator(db.vehicles.id, db.reminders.vehicleId),
  );

  $$RemindersTableProcessedTableManager get remindersRefs {
    final manager = $$RemindersTableTableManager(
      $_db,
      $_db.reminders,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_remindersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $MaintenanceHistoryTableTable,
    List<MaintenanceHistoryTableData>
  >
  _maintenanceHistoryTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.maintenanceHistoryTable,
        aliasName: $_aliasNameGenerator(
          db.vehicles.id,
          db.maintenanceHistoryTable.vehicleId,
        ),
      );

  $$MaintenanceHistoryTableTableProcessedTableManager
  get maintenanceHistoryTableRefs {
    final manager = $$MaintenanceHistoryTableTableTableManager(
      $_db,
      $_db.maintenanceHistoryTable,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _maintenanceHistoryTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ConsumablesTableTable, List<ConsumablesTableData>>
  _consumablesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.consumablesTable,
    aliasName: $_aliasNameGenerator(
      db.vehicles.id,
      db.consumablesTable.vehicleId,
    ),
  );

  $$ConsumablesTableTableProcessedTableManager get consumablesTableRefs {
    final manager = $$ConsumablesTableTableTableManager(
      $_db,
      $_db.consumablesTable,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _consumablesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FuelEntriesTable, List<FuelEntry>>
  _fuelEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fuelEntries,
    aliasName: $_aliasNameGenerator(db.vehicles.id, db.fuelEntries.vehicleId),
  );

  $$FuelEntriesTableProcessedTableManager get fuelEntriesRefs {
    final manager = $$FuelEntriesTableTableManager(
      $_db,
      $_db.fuelEntries,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_fuelEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VehiclesTableFilterComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vin => $composableBuilder(
    column: $table.vin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentMileage => $composableBuilder(
    column: $table.currentMileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get annualKmEstimate => $composableBuilder(
    column: $table.annualKmEstimate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> remindersRefs(
    Expression<bool> Function($$RemindersTableFilterComposer f) f,
  ) {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableFilterComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> maintenanceHistoryTableRefs(
    Expression<bool> Function($$MaintenanceHistoryTableTableFilterComposer f) f,
  ) {
    final $$MaintenanceHistoryTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.maintenanceHistoryTable,
          getReferencedColumn: (t) => t.vehicleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MaintenanceHistoryTableTableFilterComposer(
                $db: $db,
                $table: $db.maintenanceHistoryTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> consumablesTableRefs(
    Expression<bool> Function($$ConsumablesTableTableFilterComposer f) f,
  ) {
    final $$ConsumablesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.consumablesTable,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConsumablesTableTableFilterComposer(
            $db: $db,
            $table: $db.consumablesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fuelEntriesRefs(
    Expression<bool> Function($$FuelEntriesTableFilterComposer f) f,
  ) {
    final $$FuelEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelEntries,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelEntriesTableFilterComposer(
            $db: $db,
            $table: $db.fuelEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiclesTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vin => $composableBuilder(
    column: $table.vin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentMileage => $composableBuilder(
    column: $table.currentMileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get annualKmEstimate => $composableBuilder(
    column: $table.annualKmEstimate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehiclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get make =>
      $composableBuilder(column: $table.make, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<String> get vin =>
      $composableBuilder(column: $table.vin, builder: (column) => column);

  GeneratedColumn<String> get fuelType =>
      $composableBuilder(column: $table.fuelType, builder: (column) => column);

  GeneratedColumn<int> get currentMileage => $composableBuilder(
    column: $table.currentMileage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get annualKmEstimate => $composableBuilder(
    column: $table.annualKmEstimate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> remindersRefs<T extends Object>(
    Expression<T> Function($$RemindersTableAnnotationComposer a) f,
  ) {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> maintenanceHistoryTableRefs<T extends Object>(
    Expression<T> Function($$MaintenanceHistoryTableTableAnnotationComposer a)
    f,
  ) {
    final $$MaintenanceHistoryTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.maintenanceHistoryTable,
          getReferencedColumn: (t) => t.vehicleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MaintenanceHistoryTableTableAnnotationComposer(
                $db: $db,
                $table: $db.maintenanceHistoryTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> consumablesTableRefs<T extends Object>(
    Expression<T> Function($$ConsumablesTableTableAnnotationComposer a) f,
  ) {
    final $$ConsumablesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.consumablesTable,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConsumablesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.consumablesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fuelEntriesRefs<T extends Object>(
    Expression<T> Function($$FuelEntriesTableAnnotationComposer a) f,
  ) {
    final $$FuelEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelEntries,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.fuelEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehiclesTable,
          Vehicle,
          $$VehiclesTableFilterComposer,
          $$VehiclesTableOrderingComposer,
          $$VehiclesTableAnnotationComposer,
          $$VehiclesTableCreateCompanionBuilder,
          $$VehiclesTableUpdateCompanionBuilder,
          (Vehicle, $$VehiclesTableReferences),
          Vehicle,
          PrefetchHooks Function({
            bool userId,
            bool remindersRefs,
            bool maintenanceHistoryTableRefs,
            bool consumablesTableRefs,
            bool fuelEntriesRefs,
          })
        > {
  $$VehiclesTableTableManager(_$AppDatabase db, $VehiclesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> make = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<String?> vin = const Value.absent(),
                Value<String> fuelType = const Value.absent(),
                Value<int> currentMileage = const Value.absent(),
                Value<int?> annualKmEstimate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => VehiclesCompanion(
                id: id,
                userId: userId,
                make: make,
                model: model,
                year: year,
                vin: vin,
                fuelType: fuelType,
                currentMileage: currentMileage,
                annualKmEstimate: annualKmEstimate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required String make,
                required String model,
                required int year,
                Value<String?> vin = const Value.absent(),
                required String fuelType,
                required int currentMileage,
                Value<int?> annualKmEstimate = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => VehiclesCompanion.insert(
                id: id,
                userId: userId,
                make: make,
                model: model,
                year: year,
                vin: vin,
                fuelType: fuelType,
                currentMileage: currentMileage,
                annualKmEstimate: annualKmEstimate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VehiclesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userId = false,
                remindersRefs = false,
                maintenanceHistoryTableRefs = false,
                consumablesTableRefs = false,
                fuelEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (remindersRefs) db.reminders,
                    if (maintenanceHistoryTableRefs) db.maintenanceHistoryTable,
                    if (consumablesTableRefs) db.consumablesTable,
                    if (fuelEntriesRefs) db.fuelEntries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (userId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userId,
                                    referencedTable: $$VehiclesTableReferences
                                        ._userIdTable(db),
                                    referencedColumn: $$VehiclesTableReferences
                                        ._userIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (remindersRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          Reminder
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._remindersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).remindersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (maintenanceHistoryTableRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          MaintenanceHistoryTableData
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._maintenanceHistoryTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).maintenanceHistoryTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (consumablesTableRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          ConsumablesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._consumablesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).consumablesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fuelEntriesRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          FuelEntry
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._fuelEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).fuelEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VehiclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehiclesTable,
      Vehicle,
      $$VehiclesTableFilterComposer,
      $$VehiclesTableOrderingComposer,
      $$VehiclesTableAnnotationComposer,
      $$VehiclesTableCreateCompanionBuilder,
      $$VehiclesTableUpdateCompanionBuilder,
      (Vehicle, $$VehiclesTableReferences),
      Vehicle,
      PrefetchHooks Function({
        bool userId,
        bool remindersRefs,
        bool maintenanceHistoryTableRefs,
        bool consumablesTableRefs,
        bool fuelEntriesRefs,
      })
    >;
typedef $$RemindersTableCreateCompanionBuilder =
    RemindersCompanion Function({
      Value<int> id,
      required int vehicleId,
      required String type,
      Value<String?> customLabel,
      required DateTime dueDate,
      Value<int?> dueMileage,
      Value<int?> notifyOffsetKm,
      Value<String?> notifyOffsetsDays,
      Value<bool> notified,
      required DateTime createdAt,
    });
typedef $$RemindersTableUpdateCompanionBuilder =
    RemindersCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<String> type,
      Value<String?> customLabel,
      Value<DateTime> dueDate,
      Value<int?> dueMileage,
      Value<int?> notifyOffsetKm,
      Value<String?> notifyOffsetsDays,
      Value<bool> notified,
      Value<DateTime> createdAt,
    });

final class $$RemindersTableReferences
    extends BaseReferences<_$AppDatabase, $RemindersTable, Reminder> {
  $$RemindersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias(
        $_aliasNameGenerator(db.reminders.vehicleId, db.vehicles.id),
      );

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customLabel => $composableBuilder(
    column: $table.customLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueMileage => $composableBuilder(
    column: $table.dueMileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notifyOffsetKm => $composableBuilder(
    column: $table.notifyOffsetKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notifyOffsetsDays => $composableBuilder(
    column: $table.notifyOffsetsDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notified => $composableBuilder(
    column: $table.notified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customLabel => $composableBuilder(
    column: $table.customLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueMileage => $composableBuilder(
    column: $table.dueMileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notifyOffsetKm => $composableBuilder(
    column: $table.notifyOffsetKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notifyOffsetsDays => $composableBuilder(
    column: $table.notifyOffsetsDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notified => $composableBuilder(
    column: $table.notified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get customLabel => $composableBuilder(
    column: $table.customLabel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<int> get dueMileage => $composableBuilder(
    column: $table.dueMileage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get notifyOffsetKm => $composableBuilder(
    column: $table.notifyOffsetKm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notifyOffsetsDays => $composableBuilder(
    column: $table.notifyOffsetsDays,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notified =>
      $composableBuilder(column: $table.notified, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          Reminder,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (Reminder, $$RemindersTableReferences),
          Reminder,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> customLabel = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<int?> dueMileage = const Value.absent(),
                Value<int?> notifyOffsetKm = const Value.absent(),
                Value<String?> notifyOffsetsDays = const Value.absent(),
                Value<bool> notified = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                vehicleId: vehicleId,
                type: type,
                customLabel: customLabel,
                dueDate: dueDate,
                dueMileage: dueMileage,
                notifyOffsetKm: notifyOffsetKm,
                notifyOffsetsDays: notifyOffsetsDays,
                notified: notified,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                required String type,
                Value<String?> customLabel = const Value.absent(),
                required DateTime dueDate,
                Value<int?> dueMileage = const Value.absent(),
                Value<int?> notifyOffsetKm = const Value.absent(),
                Value<String?> notifyOffsetsDays = const Value.absent(),
                Value<bool> notified = const Value.absent(),
                required DateTime createdAt,
              }) => RemindersCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                type: type,
                customLabel: customLabel,
                dueDate: dueDate,
                dueMileage: dueMileage,
                notifyOffsetKm: notifyOffsetKm,
                notifyOffsetsDays: notifyOffsetsDays,
                notified: notified,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RemindersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$RemindersTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn: $$RemindersTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      Reminder,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (Reminder, $$RemindersTableReferences),
      Reminder,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$MaintenanceHistoryTableTableCreateCompanionBuilder =
    MaintenanceHistoryTableCompanion Function({
      Value<int> id,
      required int vehicleId,
      required String type,
      Value<String?> customLabel,
      required DateTime completedDate,
      required int mileageAtCompletion,
      Value<String?> notes,
      Value<String?> workshopName,
      Value<double?> cost,
    });
typedef $$MaintenanceHistoryTableTableUpdateCompanionBuilder =
    MaintenanceHistoryTableCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<String> type,
      Value<String?> customLabel,
      Value<DateTime> completedDate,
      Value<int> mileageAtCompletion,
      Value<String?> notes,
      Value<String?> workshopName,
      Value<double?> cost,
    });

final class $$MaintenanceHistoryTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MaintenanceHistoryTableTable,
          MaintenanceHistoryTableData
        > {
  $$MaintenanceHistoryTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias(
        $_aliasNameGenerator(
          db.maintenanceHistoryTable.vehicleId,
          db.vehicles.id,
        ),
      );

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MaintenanceHistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceHistoryTableTable> {
  $$MaintenanceHistoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customLabel => $composableBuilder(
    column: $table.customLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedDate => $composableBuilder(
    column: $table.completedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mileageAtCompletion => $composableBuilder(
    column: $table.mileageAtCompletion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workshopName => $composableBuilder(
    column: $table.workshopName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceHistoryTableTable> {
  $$MaintenanceHistoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customLabel => $composableBuilder(
    column: $table.customLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedDate => $composableBuilder(
    column: $table.completedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mileageAtCompletion => $composableBuilder(
    column: $table.mileageAtCompletion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workshopName => $composableBuilder(
    column: $table.workshopName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceHistoryTableTable> {
  $$MaintenanceHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get customLabel => $composableBuilder(
    column: $table.customLabel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedDate => $composableBuilder(
    column: $table.completedDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get mileageAtCompletion => $composableBuilder(
    column: $table.mileageAtCompletion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get workshopName => $composableBuilder(
    column: $table.workshopName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceHistoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenanceHistoryTableTable,
          MaintenanceHistoryTableData,
          $$MaintenanceHistoryTableTableFilterComposer,
          $$MaintenanceHistoryTableTableOrderingComposer,
          $$MaintenanceHistoryTableTableAnnotationComposer,
          $$MaintenanceHistoryTableTableCreateCompanionBuilder,
          $$MaintenanceHistoryTableTableUpdateCompanionBuilder,
          (
            MaintenanceHistoryTableData,
            $$MaintenanceHistoryTableTableReferences,
          ),
          MaintenanceHistoryTableData,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$MaintenanceHistoryTableTableTableManager(
    _$AppDatabase db,
    $MaintenanceHistoryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceHistoryTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MaintenanceHistoryTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MaintenanceHistoryTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> customLabel = const Value.absent(),
                Value<DateTime> completedDate = const Value.absent(),
                Value<int> mileageAtCompletion = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> workshopName = const Value.absent(),
                Value<double?> cost = const Value.absent(),
              }) => MaintenanceHistoryTableCompanion(
                id: id,
                vehicleId: vehicleId,
                type: type,
                customLabel: customLabel,
                completedDate: completedDate,
                mileageAtCompletion: mileageAtCompletion,
                notes: notes,
                workshopName: workshopName,
                cost: cost,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                required String type,
                Value<String?> customLabel = const Value.absent(),
                required DateTime completedDate,
                required int mileageAtCompletion,
                Value<String?> notes = const Value.absent(),
                Value<String?> workshopName = const Value.absent(),
                Value<double?> cost = const Value.absent(),
              }) => MaintenanceHistoryTableCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                type: type,
                customLabel: customLabel,
                completedDate: completedDate,
                mileageAtCompletion: mileageAtCompletion,
                notes: notes,
                workshopName: workshopName,
                cost: cost,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MaintenanceHistoryTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable:
                                    $$MaintenanceHistoryTableTableReferences
                                        ._vehicleIdTable(db),
                                referencedColumn:
                                    $$MaintenanceHistoryTableTableReferences
                                        ._vehicleIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MaintenanceHistoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenanceHistoryTableTable,
      MaintenanceHistoryTableData,
      $$MaintenanceHistoryTableTableFilterComposer,
      $$MaintenanceHistoryTableTableOrderingComposer,
      $$MaintenanceHistoryTableTableAnnotationComposer,
      $$MaintenanceHistoryTableTableCreateCompanionBuilder,
      $$MaintenanceHistoryTableTableUpdateCompanionBuilder,
      (MaintenanceHistoryTableData, $$MaintenanceHistoryTableTableReferences),
      MaintenanceHistoryTableData,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$ConsumablesTableTableCreateCompanionBuilder =
    ConsumablesTableCompanion Function({
      Value<int> id,
      required int vehicleId,
      required String engineOilGrade,
      required double engineOilVolume,
      required String coolantType,
      required String brakeFluidSpec,
      required String transmissionFluid,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$ConsumablesTableTableUpdateCompanionBuilder =
    ConsumablesTableCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<String> engineOilGrade,
      Value<double> engineOilVolume,
      Value<String> coolantType,
      Value<String> brakeFluidSpec,
      Value<String> transmissionFluid,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ConsumablesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ConsumablesTableTable,
          ConsumablesTableData
        > {
  $$ConsumablesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias(
        $_aliasNameGenerator(db.consumablesTable.vehicleId, db.vehicles.id),
      );

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ConsumablesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ConsumablesTableTable> {
  $$ConsumablesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get engineOilGrade => $composableBuilder(
    column: $table.engineOilGrade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get engineOilVolume => $composableBuilder(
    column: $table.engineOilVolume,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coolantType => $composableBuilder(
    column: $table.coolantType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brakeFluidSpec => $composableBuilder(
    column: $table.brakeFluidSpec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transmissionFluid => $composableBuilder(
    column: $table.transmissionFluid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConsumablesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ConsumablesTableTable> {
  $$ConsumablesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get engineOilGrade => $composableBuilder(
    column: $table.engineOilGrade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get engineOilVolume => $composableBuilder(
    column: $table.engineOilVolume,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coolantType => $composableBuilder(
    column: $table.coolantType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brakeFluidSpec => $composableBuilder(
    column: $table.brakeFluidSpec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transmissionFluid => $composableBuilder(
    column: $table.transmissionFluid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConsumablesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConsumablesTableTable> {
  $$ConsumablesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get engineOilGrade => $composableBuilder(
    column: $table.engineOilGrade,
    builder: (column) => column,
  );

  GeneratedColumn<double> get engineOilVolume => $composableBuilder(
    column: $table.engineOilVolume,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coolantType => $composableBuilder(
    column: $table.coolantType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get brakeFluidSpec => $composableBuilder(
    column: $table.brakeFluidSpec,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transmissionFluid => $composableBuilder(
    column: $table.transmissionFluid,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConsumablesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConsumablesTableTable,
          ConsumablesTableData,
          $$ConsumablesTableTableFilterComposer,
          $$ConsumablesTableTableOrderingComposer,
          $$ConsumablesTableTableAnnotationComposer,
          $$ConsumablesTableTableCreateCompanionBuilder,
          $$ConsumablesTableTableUpdateCompanionBuilder,
          (ConsumablesTableData, $$ConsumablesTableTableReferences),
          ConsumablesTableData,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$ConsumablesTableTableTableManager(
    _$AppDatabase db,
    $ConsumablesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConsumablesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConsumablesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConsumablesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<String> engineOilGrade = const Value.absent(),
                Value<double> engineOilVolume = const Value.absent(),
                Value<String> coolantType = const Value.absent(),
                Value<String> brakeFluidSpec = const Value.absent(),
                Value<String> transmissionFluid = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ConsumablesTableCompanion(
                id: id,
                vehicleId: vehicleId,
                engineOilGrade: engineOilGrade,
                engineOilVolume: engineOilVolume,
                coolantType: coolantType,
                brakeFluidSpec: brakeFluidSpec,
                transmissionFluid: transmissionFluid,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                required String engineOilGrade,
                required double engineOilVolume,
                required String coolantType,
                required String brakeFluidSpec,
                required String transmissionFluid,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => ConsumablesTableCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                engineOilGrade: engineOilGrade,
                engineOilVolume: engineOilVolume,
                coolantType: coolantType,
                brakeFluidSpec: brakeFluidSpec,
                transmissionFluid: transmissionFluid,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ConsumablesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable:
                                    $$ConsumablesTableTableReferences
                                        ._vehicleIdTable(db),
                                referencedColumn:
                                    $$ConsumablesTableTableReferences
                                        ._vehicleIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ConsumablesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConsumablesTableTable,
      ConsumablesTableData,
      $$ConsumablesTableTableFilterComposer,
      $$ConsumablesTableTableOrderingComposer,
      $$ConsumablesTableTableAnnotationComposer,
      $$ConsumablesTableTableCreateCompanionBuilder,
      $$ConsumablesTableTableUpdateCompanionBuilder,
      (ConsumablesTableData, $$ConsumablesTableTableReferences),
      ConsumablesTableData,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;
typedef $$FuelEntriesTableCreateCompanionBuilder =
    FuelEntriesCompanion Function({
      Value<int> id,
      required int vehicleId,
      required DateTime date,
      required double liters,
      required int odometerKm,
      Value<String?> fuelGrade,
      Value<double?> pricePerLiter,
      Value<bool> fullTank,
    });
typedef $$FuelEntriesTableUpdateCompanionBuilder =
    FuelEntriesCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<DateTime> date,
      Value<double> liters,
      Value<int> odometerKm,
      Value<String?> fuelGrade,
      Value<double?> pricePerLiter,
      Value<bool> fullTank,
    });

final class $$FuelEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $FuelEntriesTable, FuelEntry> {
  $$FuelEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias(
        $_aliasNameGenerator(db.fuelEntries.vehicleId, db.vehicles.id),
      );

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FuelEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $FuelEntriesTable> {
  $$FuelEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get liters => $composableBuilder(
    column: $table.liters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fuelGrade => $composableBuilder(
    column: $table.fuelGrade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pricePerLiter => $composableBuilder(
    column: $table.pricePerLiter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get fullTank => $composableBuilder(
    column: $table.fullTank,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FuelEntriesTable> {
  $$FuelEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get liters => $composableBuilder(
    column: $table.liters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fuelGrade => $composableBuilder(
    column: $table.fuelGrade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pricePerLiter => $composableBuilder(
    column: $table.pricePerLiter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get fullTank => $composableBuilder(
    column: $table.fullTank,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FuelEntriesTable> {
  $$FuelEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get liters =>
      $composableBuilder(column: $table.liters, builder: (column) => column);

  GeneratedColumn<int> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fuelGrade =>
      $composableBuilder(column: $table.fuelGrade, builder: (column) => column);

  GeneratedColumn<double> get pricePerLiter => $composableBuilder(
    column: $table.pricePerLiter,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get fullTank =>
      $composableBuilder(column: $table.fullTank, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FuelEntriesTable,
          FuelEntry,
          $$FuelEntriesTableFilterComposer,
          $$FuelEntriesTableOrderingComposer,
          $$FuelEntriesTableAnnotationComposer,
          $$FuelEntriesTableCreateCompanionBuilder,
          $$FuelEntriesTableUpdateCompanionBuilder,
          (FuelEntry, $$FuelEntriesTableReferences),
          FuelEntry,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$FuelEntriesTableTableManager(_$AppDatabase db, $FuelEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FuelEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FuelEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FuelEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> liters = const Value.absent(),
                Value<int> odometerKm = const Value.absent(),
                Value<String?> fuelGrade = const Value.absent(),
                Value<double?> pricePerLiter = const Value.absent(),
                Value<bool> fullTank = const Value.absent(),
              }) => FuelEntriesCompanion(
                id: id,
                vehicleId: vehicleId,
                date: date,
                liters: liters,
                odometerKm: odometerKm,
                fuelGrade: fuelGrade,
                pricePerLiter: pricePerLiter,
                fullTank: fullTank,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                required DateTime date,
                required double liters,
                required int odometerKm,
                Value<String?> fuelGrade = const Value.absent(),
                Value<double?> pricePerLiter = const Value.absent(),
                Value<bool> fullTank = const Value.absent(),
              }) => FuelEntriesCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                date: date,
                liters: liters,
                odometerKm: odometerKm,
                fuelGrade: fuelGrade,
                pricePerLiter: pricePerLiter,
                fullTank: fullTank,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FuelEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehicleId,
                                referencedTable: $$FuelEntriesTableReferences
                                    ._vehicleIdTable(db),
                                referencedColumn: $$FuelEntriesTableReferences
                                    ._vehicleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FuelEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FuelEntriesTable,
      FuelEntry,
      $$FuelEntriesTableFilterComposer,
      $$FuelEntriesTableOrderingComposer,
      $$FuelEntriesTableAnnotationComposer,
      $$FuelEntriesTableCreateCompanionBuilder,
      $$FuelEntriesTableUpdateCompanionBuilder,
      (FuelEntry, $$FuelEntriesTableReferences),
      FuelEntry,
      PrefetchHooks Function({bool vehicleId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db, _db.vehicles);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$MaintenanceHistoryTableTableTableManager get maintenanceHistoryTable =>
      $$MaintenanceHistoryTableTableTableManager(
        _db,
        _db.maintenanceHistoryTable,
      );
  $$ConsumablesTableTableTableManager get consumablesTable =>
      $$ConsumablesTableTableTableManager(_db, _db.consumablesTable);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$FuelEntriesTableTableManager get fuelEntries =>
      $$FuelEntriesTableTableManager(_db, _db.fuelEntries);
}
