# Introduction #

Как се ползва диалог за избор на файл от сървъра

# Details #

Необходими пакети
```
	import com.filemanagerpn.DialogFileSelectedEvent;
	import com.filemanagerpn.SaveFileDialog;
	import com.filemanagerpn.OpenSaveFileDialog;
```

Извикване на диалога. За параметър на show се подава контролата която ще е родител
```
        //tuk se syzdava noviq dialog
        var dlg:SaveFileDialog = SaveFileDialog.show(this);
        dlg.addEventListener(OpenSaveFileDialog.FILESELECTED, onSaveDlg);

```
(Този код трябва да го сложиш например във функция onClick която се изпълнява когато натиснеш някой бутон)

Съдържането на onSaveDlg. Пътя до файла се получава в event.file
```
        private function onSaveDlg(event:DialogFileSelectedEvent):void {
        	//tova se izpylnqva kogato potrebitelq natisne "save"
        	Alert.show("result:" + event.file);
	}
		
```

Подобно ще е и за OpenFileDialog

Enjoy

Допълнение:
След като си създал диалог с SaveFileDialog.show, можеш да му зададеш текущо избран файл и дали е активно менюто за работа с файлове (в диалоговия прозорец има меню което позволята да се прави всичко което може да се прави от файл мениджъра).
пр:
```
	var newDirDlg:SaveFileDialog.show(this);
	newDirDlg.setFile("/wallpapers");
	newDirDlg.setMenu(false);
```
Ще създаде диалогов прозорец в който текущата директория е /wallpapers и менюто е скрито