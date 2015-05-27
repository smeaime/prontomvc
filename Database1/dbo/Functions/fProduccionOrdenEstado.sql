

create function fProduccionOrdenEstado (@IdProduccionOrden int)

returns varchar(20)
as
begin

declare @s varchar(20)
declare @emit varchar(2)
declare @aprob varchar(2)
declare @prog varchar(2)
declare @cerro varchar(2)
declare @anul varchar(2)

-------------------------------------
-------------------------------------
DECLARE rs CURSOR FOR 
select emitio,aprobo,programada,cerro,anulada
from produccionOrdenes
where idProduccionOrden=@IdProduccionOrden

OPEN rs

FETCH NEXT FROM rs
INTO @emit, @aprob, @prog, @cerro,@anul
-------------------------------------
-------------------------------------




         If Not @emit Is Null Or @emit = 'SI' 
	 begin
		 set @s='NUEVA'
         end

         If Not @aprob Is Null Or @aprob = 'SI' 
	 begin
		 set @s='ABIERTA'
         end


         If Not @prog Is Null Or @prog = 'SI' 
	 begin
		 set @s='PROGRAMADA'
         end

         If exists (select IdProduccionOrden FROM ProduccionPartes WHERE (IdProduccionOrden=@IdProduccionOrden))
	 begin
		 set @s='EN EJECUCION'
         end

	 If Not @cerro Is Null Or @cerro = 'SI' 
	 begin
		 set @s='CERRADA'
         end

         If Not @anul Is Null Or @anul = 'SI' 
	 begin
		 set @s='ANULADA'
         end
/*
         If Not IsNull(.Fields("Aprobo").Value) Or .Fields("Aprobo").Value = "SI" Then
               GetEstado = "ABIERTA"
         End If
         
         If .Fields("Programada").Value = "SI" Then
               GetEstado = "PROGRAMADA"
         End If
         
         
         
	Dim rs As ador.Recordset
         Set rs = Aplicacion.TablasGenerales.TraerFiltrado("ProduccionPartes", "_PorIdOrden", !IdProduccionOrden)
         If rs.RecordCount > 0 Then
               GetEstado = "EN EJECUCION"
         End If
         Set rs = Nothing

         If Not IsNull(.Fields("Cerro").Value) Or .Fields("Cerro").Value = "SI" Then
               GetEstado = "CERRADA"
         End If
         
         If Not IsNull(.Fields("Anulada").Value) Or .Fields("Anulada").Value = "SI" Then
               @s = 'ANULADA'
         End If

*/

return @s

end


