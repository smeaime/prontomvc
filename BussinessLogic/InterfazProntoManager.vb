Imports Pronto.ERP.BO

Public Interface IProntoManager

    'lo que es un poco hinchapelotas es que tenga que sacar los Shared y esté obligado a crear una instancia de los managers
    Function GetItem()
    Function Save(ByVal SC As String, ByVal myComprobantePrv As ComprobanteProveedor, Optional ByVal sError As String = "") As Integer
    Sub Delete()
    Sub Anular()
    Sub RecalcularTotales()
    Sub RefrescarDesnormalizados(ByVal SC As String, ByRef cp As ComprobanteProveedor) 'este vendria a ser RegistrosConFormato...

End Interface