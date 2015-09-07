'Option Strict On
Option Explicit On

Option Infer On

Imports System
Imports System.Web
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Configuration
Imports System.Linq   '"namespace or type specified in ... doesn't contain any " -Sorry Linq is only available in .net 3.5 http://forums.asp.net/t/1332780.aspx  Advanced Compile Options
Imports System.Data.Linq 'lo necesita el CompileQuery?
Imports ADODB.DataTypeEnum
Imports System.Diagnostics
Imports System.Data
Imports System.Data.DataSetExtensions
Imports Microsoft.Reporting.WebForms
Imports System.IO

Imports System.Data.SqlClient

Imports System.Web.Security
Imports System.Security

Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.EntidadManager

Imports ClaseMigrar.SQLdinamico

Imports System.Drawing
'Namespace Pronto.ERP.Bll

Imports System.Collections.Generic

Imports System.Xml
Imports System.Text
Imports System.Security.Cryptography

Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging
Imports OpenXmlPowerTools
Imports DocumentFormat.OpenXml.Drawing.Wordprocessing

Imports System.Web.UI.WebControls

Imports Word = Microsoft.Office.Interop.Word
Imports Excel = Microsoft.Office.Interop.Excel

Imports System.Net
'Imports System.Configuration
'Imports System.Web.Security


Imports CartaDePorteManager
Imports CDPMailFiltrosManager2

Imports LogicaImportador.FormatosDeExcel


'Namespace Pronto.ERP.Bll


<DataObjectAttribute()> _
<Transaction(TransactionOption.Required)> _
Public Class FertilizanteManager
    Inherits ServicedComponent






End Class



