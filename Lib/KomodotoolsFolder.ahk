#Include  %A_ScriptDir%\Lib\Komodotool.ahk
#Include  %A_ScriptDir%\Lib\Mask.ahk

/** Class KomodotoolsFolder
*/
Class KomodotoolsFolder
{
	ini	:= INI( A_ScriptDir "\\TypingAidKomodo.ini")
	Komodotool	:= new Komodotool()
	Mask	:= new Mask().setIncludes(this.ini.get("includes")).setExcludes(this.ini.get("exclude"))
	komodo_tools	:= []
	path_komodotools	:= ""
	subfolder	:= ""

	/*---------------------------------
		SETTERS
	-----------------------------------*/
	/** setPath
	*/
	setPath($Path_komodotools)
	{
		;Dump(this.ini.get("exclude"), "this.ini.get('exclude')", 1)
		;Dump(this.ini, "this.ini.get('exclude')", 1)		
		if($Path_komodotools.exist(true))
			this.path_komodotools :=  $Path_komodotools.getPath()
		return this
	}
	/** setSubFolder
	*/
	setSubFolder($subfolder)
	{
		this.subfolder := $subfolder
		return this
	}
	/*---------------------------------
		PUBLIC METHODS
	-----------------------------------*/
	/** getKomodoTools
	*/
	getKomodoTools()
	{
		$folder_path := this.path_komodotools  "\\" this.subfolder

		if (FileExist($folder_path))
		{
			this.komodo_tools	:= []
			loop, % $folder_path  "\*", 2, 0
				if( ! this.Mask.folderIsExcluded(A_LoopFileName) )
					this._setFilesInFolder(A_LoopFileFullPath)

			;Dump(this.komodo_tools, $folder_path, 0)
			return % this.komodo_tools
		}else
			MsgBox,262144,, % "PATH DOES NOT EXISTS: " $folder_path
	}

	/*---------------------------------
		PRIVATE METHODS
	-----------------------------------*/
	/** _getFilesInFolder
	*/
	_setFilesInFolder($path_folder)
	{
		$file_paths := []
		loop, % $path_folder "\*.komodotool", 0, 1
			if( ! this.Mask.fileIsExcluded(A_LoopFileName) )
				$file_paths.insert(A_LoopFileFullPath)
		
		;For $i, $path in Arr($file_paths).sort()
		;	this.komodo_tools.push( this.Komodotool.setFilePath($path).getWordlistWord() )
		For $i, $path in Arr($file_paths).sort()
		{
			$word := this.Komodotool.setFilePath($path).getWordlistWord()
			if($word)
				this.komodo_tools.push( $word )
		}
	}

	/** _strToLowerCase
	*/
	_strToLowerCase($string){
		StringLower, $string_lower, $string
		return %$string_lower%
	}


}
