#SingleInstance force
#NoTrayIcon

#Include %A_LineFile%\..\Ahk-Lib\Array\Arr.ahk
#Include %A_LineFile%\..\Ahk-Lib\Ini\INI.ahk
#Include %A_LineFile%\..\Ahk-Lib\File\Path\Path.ahk

#Include  %A_ScriptDir%\Lib\KomodotoolsFolder.ahk
#Include  %A_ScriptDir%\Lib\Wordlists.ahk


/**	Class TypingAidKomodo
*/
Class TypingAidKomodo
{
	_INI	:= INI( A_ScriptDir "\\TypingAidKomodo.ini")
	KomodotoolsFolder	:= new KomodotoolsFolder().setPath(  Path(this._INI.get("paths", "komodotools")) )
	Wordlists	:= new Wordlists().setWordlistsPath( Path(this._INI.getFile()).combine(this._INI.get("paths", "wordlists")) )
	komodotools_folders	:= {}
	
	/** setKomodotoolsFolders
	*/
	setKomodotoolsFolders()
	{
		For $folder_name, $path in this._INI.get("komodotools_folders")
			this.komodotools_folders[$folder_name]	:= this.KomodotoolsFolder.setSubFolder($path?$path:$folder_name).getKomodoTools()
		return this
	}

	/** createWordlist
	*/
	createWordlists()
	{
		this.Wordlists.setWordlistData(this.komodotools_folders).createWordlists()
	}
}


/** EXECUTE SCRIPT
*/
new TypingAidKomodo()
		.setKomodotoolsFolders()
		.createWordlists()
