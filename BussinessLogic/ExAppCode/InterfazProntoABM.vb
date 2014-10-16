Imports Microsoft.VisualBasic


Public Interface IProntoABM
    Sub DePaginaHaciaObjeto()
    Sub DeObjetoHaciaPagina()
    Sub refrescarEncabezado()
    Sub AltaSetup()
    Sub AltaItemSetup()
    Sub EditarSetup()
    Sub RecalcularTotales()
    Sub BloqueosDeEdicion(ByVal myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor)
    Sub ByndTypeDropDown()
    Sub RefrescarTalonariosDisponibles()
End Interface

