string assemblyVersion = Assembly.GetExecutingAssembly().GetName().Version.ToString(); 
string assemblyVersion = Assembly.LoadFile('your assembly file').GetName().Version.ToString(); 
string fileVersion = FileVersionInfo.GetVersionInfo(Assembly.GetExecutingAssembly().Location).FileVersion; 
string productVersion = FileVersionInfo.GetVersionInfo(Assembly.GetExecutingAssembly().Location).ProductVersion;

//From <https://stackoverflow.com/questions/909555/how-can-i-get-the-assembly-file-version> 
