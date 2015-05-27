CREATE PROCEDURE wComparativas_T
    @IdComparativa INT = NULL
AS 
    SET @IdComparativa = ISNULL(@IdComparativa, -1)
  
    SELECT  *,
         Cmp.IdComparativa,
 Cmp.Numero,
 Cmp.Fecha as [Fecha Comparativa],
 Case When IsNull(Cmp.PresupuestoSeleccionado,0)<>-1 Then 'Monopresupuesto' Else 'Multipresupuesto' End as [Tipo seleccion],
 (Select Empleados.Nombre From Empleados Where Cmp.IdConfecciono=Empleados.IdEmpleado) as [Confecciono],
 (Select Empleados.Nombre From Empleados Where Cmp.IdAprobo=Empleados.IdEmpleado) as [Aprobo],
 Cmp.MontoPrevisto as [Monto previsto],
 Cmp.MontoParaCompra,
 --(Select Count(*) From #Auxiliar0 Where #Auxiliar0.IdComparativa=Cmp.IdComparativa) as [Cant.Sol.],
 Cmp.ArchivoAdjunto1 as [Archivo adjunto 1],
 Cmp.ArchivoAdjunto2 as [Archivo adjunto 2]
    FROM    Comparativas Cmp
    WHERE   @IdComparativa = -1
            OR ( IdComparativa = @IdComparativa )
    ORDER BY IdComparativa DESC
