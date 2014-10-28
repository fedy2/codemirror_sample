import 'dart:html';

import 'package:codemirror/codemirror.dart';

void main() {
  Map options = {
    'value': """\n// You can edit this code! Click here and start typing.

package main

import "fmt"

func main() {
  fmt.Println("Hello, 世界")
}\n""",
    'mode':  "go",
    'theme': "3024-day"
  };

  CodeMirror editor = new CodeMirror.fromElement(
      querySelector('#textContainer'), options: options);

  // Theme control.
  SelectElement themeSelect = querySelector('#theme');
  for (String theme in CodeMirror.THEMES) {
    themeSelect.children.add(new OptionElement(value: theme)..text = theme);
  }
  themeSelect.onChange.listen((e) {
    String themeName = themeSelect.options[themeSelect.selectedIndex].value;
    editor.setTheme(themeName);
  });

  // Mode control.
  SelectElement modeSelect = querySelector('#mode');
  for (String theme in ['go', 'css', 'javascript', 'sparql']) {
    modeSelect.children.add(new OptionElement(value: theme)..text = theme);
  }
  modeSelect.onChange.listen((e) {
    String modeName = modeSelect.options[modeSelect.selectedIndex].value;
    editor.setMode(modeName);
  });

  // Show line numbers.
  InputElement lineNumbers = querySelector('#lineNumbers');
  lineNumbers.onChange.listen((e) {
    editor.setLineNumbers(lineNumbers.checked);
  });

  // Indent with tabs.
  InputElement tabIndent = querySelector('#tabIndent');
  tabIndent.onChange.listen((e) {
    editor.setIndentWithTabs(tabIndent.checked);
  });

  // Status line.
  editor.onCursorActivity.listen((_) {
    Position pos = editor.getCursor();
    writeFooter('line ${pos.line} column ${pos.ch}'
        + (editor.getDoc().isClean() ? '' : ' (dirty)'));
  });

  editor.refresh();

  editor.addCommand('find', (foo) {
    print('todo: handle find');
  });

  print(CodeMirror.MODES);
  print(CodeMirror.MIME_MODES);
  print(CodeMirror.COMMANDS);

  editor.onDoubleClick.listen((MouseEvent evt) {
    Doc doc = editor.getDoc();
    print('[${doc.getLine(doc.getCursor().line).trim()}]');
  });
}

void writeFooter(var obj) {
  querySelector('#footer').text = '${obj}';
}
