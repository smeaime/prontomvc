VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ControlForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim mvarIdRegistro As Long, mvarIdRegistroOriginal As Long
Dim mvarListaEditada As String
Dim mvarTipoAccion As EnumAcciones

Public Event ActLista(ByVal IdRegistro As Long, ByVal TipoAccion As EnumAcciones, ByVal NombreListaEditada As String, ByVal mvarIdRegistroOriginal As Long)

Public Property Let AccionRegistro(ByVal vData As EnumAcciones)

   mvarTipoAccion = vData
   
End Property

Public Property Let ListaEditada(ByVal vData As String)

   mvarListaEditada = vData
   
End Property

Public Property Let IdRegistroOriginal(ByVal vData As Long)

   mvarIdRegistroOriginal = vData
   
End Property

Public Property Let Disparador(ByVal vData As Long)

   mvarIdRegistro = vData
   RaiseEvent ActLista(mvarIdRegistro, mvarTipoAccion, mvarListaEditada, mvarIdRegistroOriginal)
   
End Property

