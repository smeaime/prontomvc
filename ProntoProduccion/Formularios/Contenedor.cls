VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Contenedor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private colVariables As New Collection  ' Las variables de la operacion
Private iError As Integer               ' El error ocurrido

' Devuelve la cantidad de variables que hay en la memoria
Public Property Get CuentaVar()
  
  CuentaVar = colVariables.Count

End Property

' Devuelve el nombre de la variable que está en la posición indicada
Public Function NombreVar(ByVal iCualVariable As Integer) As String
  
  iError = 0
  If iCualVariable > 0 And iCualVariable <= colVariables.Count Then
    NombreVar = colVariables.Item(iCualVariable).Nombre
  Else
    iError = 2
    NombreVar = ""
  End If
  
End Function

' Elimina la variable indicada en el parámetro varVariable
Public Sub RemVar(ByVal varVariable As Variant)
  
  On Error Resume Next
  
  iError = 0
  If IsNumeric(varVariable) Then
    colVariables.Remove varVariable
  Else
    colVariables.Remove varVariable
  End If
  
  If Err.Number > 0 Then
    iError = 2
    Err.Number = 0
  End If

End Sub

' Elimina todas las variables del búfer
Public Sub LimpiaVar()
  
  While colVariables.Count > 0
    colVariables.Remove 1
  Wend

End Sub

' Obtiene el valor de la variable indicada en varVariable
Public Function Valor(ByVal varVariable As Variant) As Variant
  
  On Error Resume Next
  
  iError = 0
  If IsNumeric(varVariable) Then
    Valor = colVariables.Item(varVariable).Valor
  Else
    Valor = colVariables.Item(varVariable).Valor
  End If
  
  If Err.Number > 0 Then
    iError = 2
    Valor = ""
  End If
  
End Function

' Establece un nuevo valor (varValor) para la variable indicada en varVariable
Public Sub NuevoValor(ByVal varVariable As Variant, ByVal varValor As Variant)
  
  On Error Resume Next
  
  iError = 0
  If IsNumeric(varVariable) Then
    colVariables.Item(varVariable).Valor = varValor
  Else
    colVariables.Item(varVariable).Valor = varValor
  End If
  
  If Err.Number > 0 Then
    iError = 2
    Err.Number = 0
  End If

End Sub

' Añade una nueva variable al contexto.
' Puede asignarsele opcionalmente un valor predeterminado
' a esa variable. Por añadidura, la bandera bMudo sirve
' para que el procedimiento no muestre un mensaje si encuentra
' que la variable asignada ya existía en la colección.
Public Sub NuevaVar(ByVal strNombre As String, ByVal varIdConcepto As Long, ByVal varValor As Variant, Optional ByVal bMudo As Variant)
  
   ' Var
   Dim objVariable As ContenedorItem
           
   On Error Resume Next
   
'   strNombre = UCase(strNombre)
   
   ' Verifica si existen los parámetros opcionales
   iError = 0
   If IsMissing(varValor) Then
     varValor = Empty
   End If
   
   If Not IsNumeric(varValor) And Not IsEmpty(varValor) Then
     varValor = Empty
     iError = 3
   End If
   
   If IsMissing(bMudo) Then
     bMudo = False
   End If
  
   ' Localice si esta variable ya se encontraba en la colección
   Set objVariable = colVariables.Item(strNombre)
   If Err.Number > 0 Then
      Set objVariable = New ContenedorItem
      With objVariable
          .Nombre = strNombre
          .Valor = varValor
          .IdConcepto = varIdConcepto
      End With
      colVariables.Add Item:=objVariable, Key:=strNombre
      Err.Number = 0
   ElseIf Not bMudo Then
      iError = 7
   End If

End Sub

Private Sub Class_Initialize()
  
'
  
End Sub

Private Sub Class_Terminate()
  
  ' Limpia las variables de la colección. Esto no es
  ' necesario, pero es una buena práctica de programación
  ' liberar los recursos por uno mismo.
  LimpiaVar

End Sub

Public Property Get CErr() As Integer
  
  CErr = iError

End Property


Public Property Get DErr() As String
  
  ' Var
  Dim strError As String  ' La cadena con la descripción del error ocurrido
  
  ' Devuelve el texto del error ocurrido
  Select Case iError
    Case 0: strError = "La operación se realizó con éxito"
    Case 1: strError = "No se admiten caracteres especiales, acentuados o ñ"
    Case 2: strError = "La variable indicada no existe"
    Case 3: strError = "Sólo se aceptan valores numéricos o Empty"
    Case 4: strError = "Hay variables sin inicializar"
    Case 5: strError = "No se ha asignado una expresión por evaluar"
    Case 6: strError = "Falta, al menos, un cierre de paréntesis"
    Case 7: strError = "La variable indicada ya existe"
    Case 8: strError = "No se puede dividir entre cero"
    Case 9: strError = "Nombre incorrecto asignado a la función"
    Case 10: strError = "La definición de la función personalizada no es correcta"
    Case 11: strError = "La función indicada no existe"
    Case 12: strError = "La función indicada ya existe"
  End Select
  
  DErr = strError

End Property

