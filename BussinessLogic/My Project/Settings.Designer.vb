﻿'------------------------------------------------------------------------------
' <auto-generated>
'     Este código fue generado por una herramienta.
'     Versión de runtime:4.0.30319.18444
'
'     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
'     se vuelve a generar el código.
' </auto-generated>
'------------------------------------------------------------------------------

Option Strict On
Option Explicit On


Namespace My
    
    <Global.System.Runtime.CompilerServices.CompilerGeneratedAttribute(),  _
     Global.System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.VisualStudio.Editors.SettingsDesigner.SettingsSingleFileGenerator", "12.0.0.0"),  _
     Global.System.ComponentModel.EditorBrowsableAttribute(Global.System.ComponentModel.EditorBrowsableState.Advanced)>  _
    Partial Friend NotInheritable Class MySettings
        Inherits Global.System.Configuration.ApplicationSettingsBase
        
        Private Shared defaultInstance As MySettings = CType(Global.System.Configuration.ApplicationSettingsBase.Synchronized(New MySettings()),MySettings)
        
#Region "Funcionalidad para autoguardar de My.Settings"
#If _MyType = "WindowsForms" Then
    Private Shared addedHandler As Boolean

    Private Shared addedHandlerLockObject As New Object

    <Global.System.Diagnostics.DebuggerNonUserCodeAttribute(), Global.System.ComponentModel.EditorBrowsableAttribute(Global.System.ComponentModel.EditorBrowsableState.Advanced)> _
    Private Shared Sub AutoSaveSettings(ByVal sender As Global.System.Object, ByVal e As Global.System.EventArgs)
        If My.Application.SaveMySettingsOnExit Then
            My.Settings.Save()
        End If
    End Sub
#End If
#End Region
        
        Public Shared ReadOnly Property [Default]() As MySettings
            Get
                
#If _MyType = "WindowsForms" Then
               If Not addedHandler Then
                    SyncLock addedHandlerLockObject
                        If Not addedHandler Then
                            AddHandler My.Application.Shutdown, AddressOf AutoSaveSettings
                            addedHandler = True
                        End If
                    End SyncLock
                End If
#End If
                Return defaultInstance
            End Get
        End Property
        
        <Global.System.Configuration.ApplicationScopedSettingAttribute(),  _
         Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
         Global.System.Configuration.SpecialSettingAttribute(Global.System.Configuration.SpecialSetting.ConnectionString),  _
         Global.System.Configuration.DefaultSettingValueAttribute("Data Source=NANOPC\FONDO;Initial Catalog=wDemoCNSapag;Integrated Security=True")>  _
        Public ReadOnly Property wDemoCNSapagConnectionString() As String
            Get
                Return CType(Me("wDemoCNSapagConnectionString"),String)
            End Get
        End Property
        
        <Global.System.Configuration.ApplicationScopedSettingAttribute(),  _
         Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
         Global.System.Configuration.SpecialSettingAttribute(Global.System.Configuration.SpecialSetting.ConnectionString),  _
         Global.System.Configuration.DefaultSettingValueAttribute("Data Source=NANOPC\FONDO;Initial Catalog=wDemoWilliams;Integrated Security=True")>  _
        Public ReadOnly Property wDemoWilliamsConnectionString() As String
            Get
                Return CType(Me("wDemoWilliamsConnectionString"),String)
            End Get
        End Property
        
        <Global.System.Configuration.ApplicationScopedSettingAttribute(),  _
         Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
         Global.System.Configuration.SpecialSettingAttribute(Global.System.Configuration.SpecialSetting.ConnectionString),  _
         Global.System.Configuration.DefaultSettingValueAttribute("Data Source=MARIANO-PC;Initial Catalog=wDemoWilliams;Integrated Security=True")>  _
        Public ReadOnly Property wDemoWilliamsConnectionString1() As String
            Get
                Return CType(Me("wDemoWilliamsConnectionString1"),String)
            End Get
        End Property
        
        <Global.System.Configuration.ApplicationScopedSettingAttribute(),  _
         Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
         Global.System.Configuration.SpecialSettingAttribute(Global.System.Configuration.SpecialSetting.ConnectionString),  _
         Global.System.Configuration.DefaultSettingValueAttribute("Data Source=MARIANO-PC\SQLEXPRESS2;Initial Catalog=wDemoWilliams;Integrated Secur"& _ 
            "ity=True")>  _
        Public ReadOnly Property wDemoWilliamsConnectionString2() As String
            Get
                Return CType(Me("wDemoWilliamsConnectionString2"),String)
            End Get
        End Property
        
        <Global.System.Configuration.ApplicationScopedSettingAttribute(),  _
         Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
         Global.System.Configuration.SpecialSettingAttribute(Global.System.Configuration.SpecialSetting.ConnectionString),  _
         Global.System.Configuration.DefaultSettingValueAttribute("Data Source=MARIANO-PC\SQLEXPRESS2;Initial Catalog=wDemoWilliams;Persist Security"& _ 
            " Info=True;User ID=sa;Password=ok")>  _
        Public ReadOnly Property wDemoWilliamsConnectionString3() As String
            Get
                Return CType(Me("wDemoWilliamsConnectionString3"),String)
            End Get
        End Property
        
        <Global.System.Configuration.ApplicationScopedSettingAttribute(),  _
         Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
         Global.System.Configuration.SpecialSettingAttribute(Global.System.Configuration.SpecialSetting.ConnectionString),  _
         Global.System.Configuration.DefaultSettingValueAttribute("Data Source=MARIANO-PC\SQLEXPRESS2;Initial Catalog=wDemoWilliams;Persist Security"& _ 
            " Info=True;User ID=sa")>  _
        Public ReadOnly Property wDemoWilliamsConnectionString4() As String
            Get
                Return CType(Me("wDemoWilliamsConnectionString4"),String)
            End Get
        End Property
        
        <Global.System.Configuration.ApplicationScopedSettingAttribute(),  _
         Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
         Global.System.Configuration.SpecialSettingAttribute(Global.System.Configuration.SpecialSetting.ConnectionString),  _
         Global.System.Configuration.DefaultSettingValueAttribute("Data Source=mariano-pc\sqlexpress2;Initial Catalog=BDLmaster;Integrated Security="& _ 
            "True")>  _
        Public ReadOnly Property BDLmasterConnectionString() As String
            Get
                Return CType(Me("BDLmasterConnectionString"),String)
            End Get
        End Property
        
        <Global.System.Configuration.ApplicationScopedSettingAttribute(),  _
         Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
         Global.System.Configuration.SpecialSettingAttribute(Global.System.Configuration.SpecialSetting.ConnectionString),  _
         Global.System.Configuration.DefaultSettingValueAttribute("Data Source=MARIANO-PC\SQLEXPRESS;Initial Catalog=wDemoWilliams;Integrated Securi"& _ 
            "ty=True")>  _
        Public ReadOnly Property wDemoWilliamsConnectionString5() As String
            Get
                Return CType(Me("wDemoWilliamsConnectionString5"),String)
            End Get
        End Property
        
        <Global.System.Configuration.ApplicationScopedSettingAttribute(),  _
         Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
         Global.System.Configuration.SpecialSettingAttribute(Global.System.Configuration.SpecialSetting.ConnectionString),  _
         Global.System.Configuration.DefaultSettingValueAttribute("Data Source=MARIANO-PC\SQLEXPRESS;Initial Catalog=BDLMaster;Integrated Security=T"& _ 
            "rue")>  _
        Public ReadOnly Property BDLMasterConnectionString1() As String
            Get
                Return CType(Me("BDLMasterConnectionString1"),String)
            End Get
        End Property
        
        <Global.System.Configuration.ApplicationScopedSettingAttribute(),  _
         Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
         Global.System.Configuration.SpecialSettingAttribute(Global.System.Configuration.SpecialSetting.ConnectionString),  _
         Global.System.Configuration.DefaultSettingValueAttribute("Data Source=MARIANO-PC\sqlexpress;Initial Catalog=Autotrol;Integrated Security=Tr"& _ 
            "ue")>  _
        Public ReadOnly Property AutotrolConnectionString() As String
            Get
                Return CType(Me("AutotrolConnectionString"),String)
            End Get
        End Property
        
        <Global.System.Configuration.ApplicationScopedSettingAttribute(),  _
         Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
         Global.System.Configuration.SpecialSettingAttribute(Global.System.Configuration.SpecialSetting.ConnectionString),  _
         Global.System.Configuration.DefaultSettingValueAttribute("Data Source=MARIANO-PC;Initial Catalog=BDLMaster;Integrated Security=True")>  _
        Public ReadOnly Property BDLMasterConnectionString2() As String
            Get
                Return CType(Me("BDLMasterConnectionString2"),String)
            End Get
        End Property
        
        <Global.System.Configuration.ApplicationScopedSettingAttribute(),  _
         Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
         Global.System.Configuration.SpecialSettingAttribute(Global.System.Configuration.SpecialSetting.ConnectionString),  _
         Global.System.Configuration.DefaultSettingValueAttribute("Data Source=mariano-pc;Initial Catalog=wDemoWilliams;Integrated Security=True")>  _
        Public ReadOnly Property wDemoWilliamsConnectionString6() As String
            Get
                Return CType(Me("wDemoWilliamsConnectionString6"),String)
            End Get
        End Property
        
        <Global.System.Configuration.ApplicationScopedSettingAttribute(),  _
         Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
         Global.System.Configuration.SpecialSettingAttribute(Global.System.Configuration.SpecialSetting.ConnectionString),  _
         Global.System.Configuration.DefaultSettingValueAttribute("Data Source=MARIANO-PC\MSSQLSERVER2;Initial Catalog=Autotrol;Integrated Security="& _ 
            "True")>  _
        Public ReadOnly Property AutotrolConnectionString1() As String
            Get
                Return CType(Me("AutotrolConnectionString1"),String)
            End Get
        End Property
        
        <Global.System.Configuration.ApplicationScopedSettingAttribute(),  _
         Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
         Global.System.Configuration.SpecialSettingAttribute(Global.System.Configuration.SpecialSetting.ConnectionString),  _
         Global.System.Configuration.DefaultSettingValueAttribute("Data Source=MARIANO-PC\MSSQLSERVER2;Initial Catalog=Williams;Integrated Security="& _ 
            "True;MultipleActiveResultSets=True;Application Name=EntityFramework")>  _
        Public ReadOnly Property WilliamsConnectionString() As String
            Get
                Return CType(Me("WilliamsConnectionString"),String)
            End Get
        End Property
        
        <Global.System.Configuration.ApplicationScopedSettingAttribute(),  _
         Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
         Global.System.Configuration.SpecialSettingAttribute(Global.System.Configuration.SpecialSetting.ConnectionString),  _
         Global.System.Configuration.DefaultSettingValueAttribute("Data Source=serversql1;Initial Catalog=WilliamsEntregas;Persist Security Info=Tru"& _ 
            "e;User ID=sa;Password=3D1consultore5")>  _
        Public ReadOnly Property WilliamsEntregasConnectionString() As String
            Get
                Return CType(Me("WilliamsEntregasConnectionString"),String)
            End Get
        End Property
        
        <Global.System.Configuration.ApplicationScopedSettingAttribute(),  _
         Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
         Global.System.Configuration.SpecialSettingAttribute(Global.System.Configuration.SpecialSetting.ConnectionString),  _
         Global.System.Configuration.DefaultSettingValueAttribute("Data Source=serversql3\testing;Initial Catalog=Pronto;Persist Security Info=True;"& _ 
            "User ID=sa;Password=.SistemaPronto.")>  _
        Public ReadOnly Property ProntoConnectionString() As String
            Get
                Return CType(Me("ProntoConnectionString"),String)
            End Get
        End Property
        
        <Global.System.Configuration.ApplicationScopedSettingAttribute(),  _
         Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
         Global.System.Configuration.SpecialSettingAttribute(Global.System.Configuration.SpecialSetting.ConnectionString),  _
         Global.System.Configuration.DefaultSettingValueAttribute("Data Source=serversql1;Initial Catalog=WilliamsEntregas;User ID=sa;Password=3D1co"& _ 
            "nsultore5")>  _
        Public ReadOnly Property WilliamsEntregasConnectionString1() As String
            Get
                Return CType(Me("WilliamsEntregasConnectionString1"),String)
            End Get
        End Property
    End Class
End Namespace

Namespace My
    
    <Global.Microsoft.VisualBasic.HideModuleNameAttribute(),  _
     Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
     Global.System.Runtime.CompilerServices.CompilerGeneratedAttribute()>  _
    Friend Module MySettingsProperty
        
        <Global.System.ComponentModel.Design.HelpKeywordAttribute("My.Settings")>  _
        Friend ReadOnly Property Settings() As Global.My.MySettings
            Get
                Return Global.My.MySettings.Default
            End Get
        End Property
    End Module
End Namespace
