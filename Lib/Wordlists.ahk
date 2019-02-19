/**
	Class Wordlists
*/
Class Wordlists
{

	/** setWordlistsPath
	*/
	setWordlistsPath($Path_wordlists)
	{
		;Dump($Path_wordlists, "Path_wordlists", 1)
		;MsgBox,262144,Path_wordlists, %$Path_wordlists%
		if($Path_wordlists.exist(true))
			this.path_wordlists := $Path_wordlists.getPath()

		;Dump(this.path_wordlists, "this.path_wordlists", 1)
		return this
	}

	/** setWordlistData
	*/
	setWordlistData($wordlist_data)
	{
		this.wordlist_data	:= $wordlist_data
		;dump(this.wordlist_data, "this.wordlist_data", 0)
		return this
	}

	/** createWordlists
	*/
	createWordlists()
	{
		;dump(this, "this", 0)
		For $folder_name, $snippets in this.wordlist_data
			this._createWordlist($folder_name, $snippets)
	}

	/** _createWordlist
	*/
	_createWordlist($folder_name, $snippets)
	{
		;Dump($snippets, $folder_name, 0)
		$path_folder	:= this.path_wordlists "\Komodo-" $folder_name "\Wordlist"
		$path_file	:= $path_folder "\\" $folder_name "-generated.txt"
		FileCreateDir, % $path_folder
		FileDelete %$path_file%  
		;Dump($path_file, "path_file", 1)
		
		;FileAppend, % Arr($snippets).filter().sort().join("`n"), %$path_file%
		For $s, $snippet in $snippets
			FileAppend, % $snippet.name this.getReplacementOrDescription($snippet) "`n", %$path_file%
	}
	/** getReplacementOrDescription
	*/
	getReplacementOrDescription($snippet)
	{
		if($snippet.replacement!="" || $snippet.description!="")
			return % $snippet.replacement!="" ? "|R|" $snippet.replacement : "|D|" $snippet.description

		return ""
	}

}
