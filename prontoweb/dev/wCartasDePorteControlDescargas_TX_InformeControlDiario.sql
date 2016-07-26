
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
	left join CartasDePorte C on   C.FechaDescarga = D.Fecha  
								AND C.Destino = D.IdDestino 
								AND C.SubnumeroDeFacturacion <= 0 
								AND D.idPuntoVenta=C.puntoVenta
	left  join WilliamsDestinos DEST on D.IdDestino=DEST.IdWilliamsDestino
	where	(DEST.PuntoVenta=@IdPuntoVenta or @IdPuntoVenta=0)
			--D.idPuntoVenta=@IdPuntoVenta or @IdPuntoVenta=0
			AND (D.Fecha between @FechaDesde and @FechaHasta)
	group by d.IdCartasDePorteControlDescarga,D.IdDestino , DEST.Descripcion, D.Fecha  , d.TotalDescargaDia ,D.idpuntoventa
    order by D.Fecha desc, DEST.Descripcion asc


end
go

--select * from WilliamsDestinos where IdWilliamsDestino=47




exec wCartasDePorteControlDescargas_TX_InformeControlDiario '','',3,0

/*
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [dbo].[CartasDePorte] ([SubnumeroDeFacturacion])
INCLUDE ([NetoFinal],[Destino],[FechaDescarga])
GO
*/