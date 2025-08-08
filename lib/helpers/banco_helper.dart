import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/pessoa.dart';

class BancoHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await inicializarDB();
    return _db!;
  }

  Future<Database> inicializarDB() async {
    final pathDB = await getDatabasesPath();
    print('######### Banco salvo em: $pathDB');
    final localDB = join(pathDB, 'pessoas.db');

    return await openDatabase(
      localDB,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE pessoa (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            idade INTEGER
          )
        ''');
      },
    );
  }

  Future<int> inserirPessoa(Pessoa pessoa) async {
    final banco = await db;
    print('########## Inserindo pessoa: ${pessoa.toMap()}');
    return await banco.insert('pessoa', pessoa.toMap());
  }

  Future<List<Pessoa>> listarPessoas() async {
    final banco = await db;
    final result = await banco.query('pessoa');
    print('########## Listando todas pessoas:');
    return result.map((e) => Pessoa.fromMap(e)).toList();
  }

  Future<int> deletarTodasPessoas() async {
    final banco = await db;
    print('########## Deletando todas pessoas');
    return await banco.delete('pessoa'); // Equivalente a "DELETE FROM pessoa"
  }

} 