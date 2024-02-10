import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BaseDatos {
  late Database _database;

  // Constructor para abrir la base de datos
  BaseDatos() {
    open(); // Llama al método open cuando se crea la instancia de BaseDatos
  }

  Future<void> open() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'DriveDoct.db'),
      onCreate: (db, version) async {
        // Crear tablas al crear la base de datos
        await db.execute('''
        CREATE TABLE Usuario (
          ID_Usuario INTEGER PRIMARY KEY AUTOINCREMENT,
          Usuario TEXT NOT NULL,
          Contrasena TEXT NOT NULL
        )
      ''');

        await db.execute('''
        CREATE TABLE Vehiculo (
          ID_Vehiculo INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre TEXT NOT NULL,
          ID_Usuario INTEGER,
          FOREIGN KEY (ID_Usuario) REFERENCES Usuario (ID_Usuario)
        )
      ''');

        await db.execute('''
        CREATE TABLE RegistroKilometraje (
          ID_Kilometraje INTEGER PRIMARY KEY AUTOINCREMENT,
          Kilometraje INTEGER NOT NULL,
          Fecha DATE NOT NULL,
          ID_Usuario INTEGER,
          ID_Vehiculo INTEGER,
          FOREIGN KEY (ID_Vehiculo) REFERENCES Vehiculo (ID_Vehiculo),
          FOREIGN KEY (ID_Usuario) REFERENCES Usuario (ID_Usuario)
        )
      ''');

        await db.execute('''
        CREATE TABLE Mantenimiento (
          ID_Mantenimiento INTEGER PRIMARY KEY AUTOINCREMENT,
          Agua INTEGER NOT NULL,
          Aceite INTEGER NOT NULL,
          FiltroDeGasolina INTEGER NOT NULL,
          bujias INTEGER NOT NULL,
          Valvulas INTEGER NOT NULL,
          CorreaDistribucion INTEGER NOT NULL,
          FiltroDeParticulas INTEGER NOT NULL,
          DiscoDeFrenos INTEGER NOT NULL,
          Amortiguadores INTEGER NOT NULL,
          ID_Vehiculo INTEGER,
          FOREIGN KEY (ID_Vehiculo) REFERENCES Vehiculo (ID_Vehiculo)
        )
      ''');

        await db.execute('''
        CREATE TABLE Sedan (
          ID_Sedan INTEGER PRIMARY KEY AUTOINCREMENT,
          Afinacion DATETIME NOT NULL,
          ID_Mantenimiento INTEGER,
          FOREIGN KEY (ID_Mantenimiento) REFERENCES Mantenimiento (ID_Mantenimiento)
        )
      ''');

        await db.execute('''
        CREATE TABLE PickUp (
          ID_PickUp INTEGER PRIMARY KEY AUTOINCREMENT,
          Afinacion DATETIME NOT NULL,
          ID_Mantenimiento INTEGER,
          FOREIGN KEY (ID_Mantenimiento) REFERENCES Mantenimiento (ID_Mantenimiento)
        )
      ''');

        await db.execute('''
        CREATE TABLE Moto (
          ID_Moto INTEGER PRIMARY KEY AUTOINCREMENT,
          Afinacion DATETIME NOT NULL,
          ID_Mantenimiento INTEGER,
          FOREIGN KEY (ID_Mantenimiento) REFERENCES Mantenimiento (ID_Mantenimiento)
        )
      ''');
      },
      version: 2,
    );
  }

  Future<bool> verificarCredenciales(String usuario, String contrasena) async {
    try {
      List<Map<String, dynamic>> result = await _database.query(
        'Usuario',
        where: 'Usuario = ? AND Contrasena = ?',
        whereArgs: [usuario, contrasena],
      );

      return result.isNotEmpty;
    } catch (e) {
      print('Error al verificar credenciales: $e');
      return false;
    }
  }

  Future<int> insertUsuario(String usuario, String contrasena) async {
    try {
      int id = await _database.insert(
        'Usuario',
        {'Usuario': usuario, 'Contrasena': contrasena},
      );

      print('Usuario registrado con ID: $id');

      return id;
    } catch (e) {
      print('Error al insertar usuario: $e');
      return -1;
    }
  }

  Future<int?> obtenerIdUsuario(String nombre) async {
    try {
      List<Map<String, Object?>> usuarios = await _database.query(
        'Usuario', // Modificado a 'Usuario' en lugar de 'usuarios'
        where: 'Usuario = ?',
        whereArgs: [nombre],
      );

      if (usuarios.isNotEmpty) {
        int idUsuario = usuarios.first['ID_Usuario'] as int;
        return idUsuario;
      } else {
        return null;
      }
    } catch (e) {
      print('Error al obtener el ID del usuario: $e');
      return null;
    }
  }

  Future<int> insertVehiculo(String nombre, int idUsuario) async {
    try {
      int id = await _database.insert(
        'Vehiculo',
        {
          'nombre': nombre,
          'ID_Usuario': idUsuario,
        },
      );

      print('Vehículo registrado con ID: $id');

      return id;
    } catch (e) {
      print('Error al insertar vehículo: $e');
      return -1;
    }
  }

  Future<int> insertKilometraje(
      int kilometraje, int idUsuario, int idVehiculo) async {
    try {
      String currentDate = DateTime.now().toLocal().toString();
      int id = await _database.insert(
        'RegistroKilometraje',
        {
          'Kilometraje': kilometraje,
          'Fecha': currentDate,
          'ID_Usuario': idUsuario,
          'ID_Vehiculo': idVehiculo,
        },
      );

      print('Kilometraje registrado con ID: $id');

      return id;
    } catch (e) {
      print('Error al insertar Kilometraje: $e');
      return -1;
    }
  }

  Future<int> insertMantenimiento(int idVehiculo) async {
    try {
      int id = await _database.insert(
        'Mantenimiento',
        {
          'Agua': 0,
          'Aceite': 0,
          'FiltroDeGasolina': 0,
          'bujias': 0,
          'Valvulas': 0,
          'CorreaDistribucion': 0,
          'FiltroDeParticulas': 0,
          'DiscoDeFrenos': 0,
          'Amortiguadores': 0,
          'ID_Vehiculo': idVehiculo,
        },
      );

      print('Mantenimiento registrado con ID: $id');

      return id;
    } catch (e) {
      print('Error al insertar Mantenimiento: $e');
      return -1;
    }
  }

  Future<int> insertSedan(int idMantenimiento, String fechaAfinacion) async {
    try {
      int id = await _database.insert(
        'Sedan',
        {
          'Afinacion': fechaAfinacion,
          'ID_Mantenimiento': idMantenimiento,
        },
      );

      print('Sedan registrado con ID: $id');

      return id;
    } catch (e) {
      print('Error al insertar Sedan: $e');
      return -1;
    }
  }

  Future<int> insertPickUp(int idMantenimiento, String fechaAfinacion) async {
    try {
      int id = await _database.insert(
        'PickUp',
        {
          'Afinacion': fechaAfinacion,
          'ID_Mantenimiento': idMantenimiento,
        },
      );

      print('PickUp registrado con ID: $id');

      return id;
    } catch (e) {
      print('Error al insertar PickUp: $e');
      return -1;
    }
  }

  Future<int> insertMoto(int idMantenimiento, String fechaAfinacion) async {
    try {
      int id = await _database.insert(
        'Moto',
        {
          'Afinacion': fechaAfinacion,
          'ID_Mantenimiento': idMantenimiento,
        },
      );

      print('Moto registrado con ID: $id');

      return id;
    } catch (e) {
      print('Error al insertar Moto: $e');
      return -1;
    }
  }

  Future<Map<String, dynamic>?> obtenerVehiculoYKilometraje(
      String nombre, int idUsuario) async {
    try {
      List<Map<String, dynamic>> vehiculos = await _database.query(
        'Vehiculo',
        columns: ['ID_Vehiculo'],
        where: 'nombre = ? AND ID_Usuario = ?',
        whereArgs: [nombre, idUsuario],
      );

      if (vehiculos.isNotEmpty) {
        int idVehiculo = vehiculos.first['ID_Vehiculo'] as int;

        List<Map<String, dynamic>> registrosKilometraje = await _database.query(
          'RegistroKilometraje',
          columns: ['Kilometraje'],
          where: 'ID_Vehiculo = ?',
          whereArgs: [idVehiculo],
          orderBy: 'Fecha DESC',
          limit: 1,
        );

        if (registrosKilometraje.isNotEmpty) {
          int kilometrajeAnterior =
              registrosKilometraje.first['Kilometraje'] as int;

          return {
            'idVehiculo': idVehiculo,
            'kilometrajeAnterior': kilometrajeAnterior
          };
        }
      }

      return null;
    } catch (e) {
      print('Error al obtener vehículo y kilometraje anterior: $e');
      return null;
    }
  }

/*
  Future<void> updateVehiculo(RegistrarVehiculoPage vehiculo) async {
    try {
      await _database.update(
        'Vehiculo',
        {
          'nombre': vehiculo.nombre,
          'ID_Usuario': vehiculo.idUsuario,
          'ID_Kilometraje': vehiculo.idKilometraje,
          'ID_Mantenimiento': vehiculo.idMantenimiento,
        },
        where: 'ID_Vehiculo = ?',
        whereArgs: [vehiculo.idVehiculo],
      );

      print('Vehículo actualizado con ID: ${vehiculo.idVehiculo}');
    } catch (e) {
      print('Error al actualizar vehículo: $e');
    }
  }

*/

  Future<void> cerrarBaseDatos() async {
    await _database.close();
  }
}
