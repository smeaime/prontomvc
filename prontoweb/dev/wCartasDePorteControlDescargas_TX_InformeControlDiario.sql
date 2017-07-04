
drop PROCEDURE [dbo].wCartasDePorteControlDescargas_TX_InformeControlDiario
go

CREATE PROCEDURE [dbo].wCartasDePorteControlDescargas_TX_InformeControlDiario
(
	@FechaDesde DateTime,
	@FechaHasta DateTime,
	@IdDestino int,
	@IdPuntoVenta int
)
AS
BEGIN

declare @i int



select 
	YEAR(D.Fecha) as Ano,
	DATENAME(month, D.Fecha) as Mes,
    IdCartasDePorteControlDescarga,
    D.IdDestino ,
	DEST.Descripcion as Destino,
	D.Fecha  as FechaDescarga,
    Sum(NetoFinal) as NetoFinal,
    TotalDescargaDia,
    TotalDescargaDia - Sum(NetoFinal) as dif,
    Count(NetoFinal) as cuantas,
	D.idpuntoventa
    --g.Select(x => x.NumeroCartaDePorte).ToList()

	from CartasDePorteControlDescarga D
	left join CartasDePorte C on  
								C.Destino = D.IdDestino 
								AND C.SubnumeroDeFacturacion <= 0 
								AND D.idPuntoVenta=C.puntoVenta
							    AND C.FechaDescarga = D.Fecha -- aca habria que tomar solo el dia de las dos fechas, sin tomar en cuenta la hora
	left  join WilliamsDestinos DEST on D.IdDestino=DEST.IdWilliamsDestino

	where	1=1
			AND (DEST.PuntoVenta=@IdPuntoVenta or @IdPuntoVenta<=0)
			AND (D.Fecha between @FechaDesde and @FechaHasta )
			AND (D.IdDestino=@IdDestino or @IdDestino=-1) 
			AND ((C.FechaDescarga between @FechaDesde and @FechaHasta) or C.IdCartaDePorte is null)
			AND C.Exporta='NO' -- reclamo 41491

	group by YEAR(D.Fecha),DATENAME(month, D.Fecha),d.IdCartasDePorteControlDescarga,D.IdDestino , 
							DEST.Descripcion, D.Fecha  , d.TotalDescargaDia ,D.idpuntoventa
    order by D.Fecha desc, DEST.Descripcion asc


end
go

--select * from WilliamsDestinos where IdWilliamsDestino=47
--select * from CartasDePorteControlDescarga

GRANT EXECUTE ON wCartasDePorteControlDescargas_TX_InformeControlDiario to [NT AUTHORITY\ANONYMOUS LOGON]
go
 
exec wCartasDePorteControlDescargas_TX_InformeControlDiario '20140810','20160810',-1,0

exec wCartasDePorteControlDescargas_TX_InformeControlDiario '20160701','20161030',-1,0

exec wCartasDePorteControlDescargas_TX_InformeControlDiario '20160701','20161030',-1,-1

/*
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [dbo].[CartasDePorte] ([SubnumeroDeFacturacion])
INCLUDE ([NetoFinal],[Destino],[FechaDescarga])
GO
*/

/*
USE [Williams2]
GO
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [dbo].[CartasDePorte] ([SubnumeroDeFacturacion])
INCLUDE ([NetoFinal],[Destino],[FechaDescarga],[PuntoVenta])
GO
*/
