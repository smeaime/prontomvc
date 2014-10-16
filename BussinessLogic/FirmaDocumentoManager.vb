Imports System
Imports System.ComponentModel
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    Public Class FirmaDocumentoManager
        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetDocumetosAFirmar(ByVal SC As String, ByVal Usuario As String) As System.Data.DataSet
            Return FirmaDocumentoDB.GetDocumentosAFirmar(SC, Usuario)
        End Function

        '<DataObjectMethod(DataObjectMethodType.Select, False)> _
        'Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As FirmaDocumento
        '    Return FirmaDocumentoDB.GetItem(SC, id)
        'End Function

        <DataObjectMethod(DataObjectMethodType.Update Or DataObjectMethodType.Insert, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myFirmaDocumento As FirmaDocumento) As Integer
            myFirmaDocumento.Id = FirmaDocumentoDB.Save(SC, myFirmaDocumento)
            Return myFirmaDocumento.Id
        End Function

        <DataObjectMethod(DataObjectMethodType.Update Or DataObjectMethodType.Insert, True)> _
        Public Shared Function SaveBlock(ByVal SC As String, ByVal BDs As String, ByVal IdFormularios As String, _
                                         ByVal IdComprobantes As String, ByVal NumerosOrden As String, _
                                         ByVal Autorizo As String) As Integer
            Dim result As Integer
            result = FirmaDocumentoDB.SaveBlock(SC, BDs, IdFormularios, IdComprobantes, NumerosOrden, Autorizo)
            Return result
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myFirmaDocumento As FirmaDocumento) As Boolean
            Return FirmaDocumentoDB.Delete(SC, myFirmaDocumento.Id)
        End Function
    End Class

End Namespace