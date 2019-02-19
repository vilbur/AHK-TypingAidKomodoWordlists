/**
	Class Mask
*/
Class Mask
{
	;test := "test"
	__New(){
		;this.parameter := $parameter
		;MsgBox,262144,, Mask, 2
	}
	/*---------------------------------
		SETTERS
	-----------------------------------*/
	/** setIncludes
	*/
	setIncludes($rx_includes)
	{
		this.rx_includes := $rx_includes
		return this
	}	
	/** setExcludes
	*/
	setExcludes($rx_excludes)
	{
		this.rx_excludes := $rx_excludes
		return this
	}
	/** folderIsIncluded
	*/
	folderIsIncluded($folder_name)
	{
		return RegExMatch( $folder_name, "i)^(" this.rx_includes.folder ").*$")
	}	
	/** folderIsExcluded
	*/
	folderIsExcluded($folder_name)
	{
		;return RegExMatch( $folder_name, "i)^(?!(?:" this.rx_excludes.folder ")).*$")
		return RegExMatch( $file_name, "i)^(" this.rx_excludes.folder ").*$")		
	}
	/** fileIsExcluded
	*/
	fileIsExcluded($file_name)
	{
		;Dump( RegExMatch( $file_name, "i)^(" this.rx_excludes.file ").*$"), $file_name, 1)
		;return RegExMatch( $file_name, "i)^(?!(?:" this.rx_excludes.file ")).*$")
		return RegExMatch( $file_name, "i)^(" this.rx_excludes.file ").*$")		
	}

}
