//Auto-generated config-file for FlexiCapture Engine C-Sharp samples
using System;

class FceConfig
{
    // full path to FCE dll
    public const string DllPath = "C:\\Program Files (x86)\\ABBYY SDK\\11\\FlexiCapture Engine\\Bin\\FCEngine.dll";

    // Return full path to FCE dll
    public static string GetDllPath()
    {
        return "C:\\Program Files (x86)\\ABBYY SDK\\11\\FlexiCapture Engine\\Bin\\FCEngine.dll";
    }

    // Return developer serial number for FCE
    public static string GetDeveloperSN()
    {
        // sacarla de algun archivo!!!

        if (true)
        {
            return "SWTD11020005707249634925"; // la de SDK en el server3, si usamos el deploy IIS de testing
                    
        }
        else if (true)
        {
            return "SWTD11020005707251470907"; // cuando uso el visual acá en mi pc. la projectid es SWTD11020005707249634925 (la misma q está en el server)
        }
        else
        {
            return "SWTR11020005707252017844"; // la del runtime
        }
    }


    /*
    Working with the LicensingSettings.xml File
     * 
The LicensingSettings.xml file contains the ABBYY FlexiCapture Engine protection settings. This file is necessary 
     * for correct work of the Licensing Service in the network. When Licensing Service is used on a local computer, 
     * this file is required if you use a Hardware protection key. 

The file is generated automatically during Developer or Runtime installation in automatic mode. When installing manually, 
     * you must specify the correct settings in this file. The XML scheme of the settings is located in 
     * the LicensingSettings.xsd file. You can find this file in the Inc folder 
     * (Start > Programs > ABBYY FlexiCapture Engine 11 > Installation Folders > Include Files Folder).




The sample below shows a simple LisensingSettings.xml file for a standalone installation. Local inter-process communication is used. Hardware protection keys are disabled.

<?xml version="1.0" encoding="utf-8"?>
<LicensingSettings xmlns="http://www.abbyy.com/Protection/LicensingSettings">
	<LocalLicenseServer>
		<ConnectionProtocol ProtocolType="LocalInterprocessCommunication" />
		<EnableIKeyLicenses Enable="no" />
	</LocalLicenseServer>
</LicensingSettings> 
The samples below show simple LisensingSettings.xml files for a network installation: a file for workstations and a file for a server. Licensing Service is located on the computer with the name "computername". The TCP/IP protocol is used for communication between the server and workstations. 

For a workstation:

<?xml version="1.0" encoding="utf-8"?>
<LicensingSettings xmlns="http://www.abbyy.com/Protection/LicensingSettings">
	<LicensingServers>
		<MainNetworkLicenseServer ServerAddress="computername" ProtocolType="TCP/IP" />
	</LicensingServers>
</LicensingSettings> 
For a server:

<?xml version="1.0" encoding="utf-8"?>
<LicensingSettings xmlns="http://www.abbyy.com/Protection/LicensingSettings">
	<LocalLicenseServer>
		<ConnectionProtocol ProtocolType="TCP/IP" />
	</LocalLicenseServer>
</LicensingSettings>


    */



    // Return full path to Samples directory
    public static string GetSamplesFolder()
    {
        return "C:\\ProgramData\\ABBYY\\SDK\\11\\FlexiCapture Engine\\Samples";
    }

}
