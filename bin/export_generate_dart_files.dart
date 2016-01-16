import "dart:io";
import 'package:args/args.dart';
import 'package:path/path.dart';

const String DEFAULT_SOURCE_DIR = "C:/Users/santiago/Desktop/AsWing/src";
const String DEFAULT_TARGET_DIR = "C:/Users/santiago/Adobe Flash Builder 4.7/AsWingDart";
const String DEFAULT_IS_MOVED = "false";

String source_basedir;
String target_basedir;
bool is_moved;

void main(List args) {
  source_basedir = DEFAULT_SOURCE_DIR;
  target_basedir = DEFAULT_TARGET_DIR;
  _setupArgs(args);
  recursiveFolderCopySync(source_basedir,target_basedir);
}

void recursiveFolderCopySync(String path1, String path2) {
  Directory dir1 = new Directory(path1);
  if (!dir1.existsSync()) {
    throw new Exception(
        'Source directory "${dir1.path}" does not exist, nothing to copy'
    );
  }
  Directory dir2 = new Directory(path2);
  if (!dir2.existsSync()) {
    dir2.createSync(recursive: true);
  }

  dir1.listSync().forEach((element) {
      String elementPath = element.path;
      String newPath = elementPath.replaceAll(source_basedir,target_basedir);
      if (element is File) {
        if(extension(element.path).toLowerCase() == ".dart"){
          print("oldPath: "+elementPath);
          print("newPath: "+newPath);
          File newFile = new File(newPath);
          if(newFile.existsSync()){
            newFile.deleteSync();
            newFile = new File(newPath);
          }
          newFile.writeAsBytesSync(element.readAsBytesSync());
          if(is_moved){
            element.delete();
          }
        }
      } else if (element is Directory) {
        recursiveFolderCopySync(element.path, newPath);
      } else {
        throw new Exception('File is neither File nor Directory. HOW?!');
    }
  });

}

void _setupArgs(List args) {
  ArgParser argParser = new ArgParser();

  argParser.addOption('target', abbr: 't', defaultsTo: DEFAULT_TARGET_DIR, help: 'The path (relative or absolute) the generated Dart library will be written to. Usually, your Dart project\'s \'lib\' directory.', valueHelp: 'target', callback: (_target_basedir) {
    target_basedir = _target_basedir;
  });
  argParser.addOption('source', abbr: 's', defaultsTo: DEFAULT_SOURCE_DIR, help: 'The path (relative or absolute) to the Actionscript source(s) to be converted.', valueHelp: 'source', callback: (_source_basedir) {
    source_basedir = _source_basedir;
  });
  argParser.addOption('is_move', abbr: 'm', defaultsTo: DEFAULT_IS_MOVED, help: 'Should the generated dart files removed from source dir.', valueHelp: 'is_moved', callback: (_is_moved) {
    is_moved = _is_moved == "true";
  });

  argParser.addFlag('help', negatable: false, help: 'Displays the help.', callback: (help) {
    if (help) {
      print(argParser.getUsage());
      exit(1);
    }
  });

  argParser.parse(args);
}