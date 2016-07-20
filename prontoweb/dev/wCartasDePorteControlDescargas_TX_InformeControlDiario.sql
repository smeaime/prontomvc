
drop PROCEDURE [dbo].wCartasDePorteControlDescargas_TX_InformeControlDiario
go

CREATE PROCEDURE [dbo].wCartasDePorteControlDescargas_TX_InformeControlDiario
(
	@FechaDesde DateTime,
	@FechaHasta DateTime,
	@IdDestino int
)
AS
BEGIN

declare @i int



select 
    IdCartasDePorteControlDescarga,
    DEST.Descripcion as Destino,
    FechaDescarga,
    Sum(NetoFinal) as NetoFinal,
    TotalDescargaDia,
    TotalDescargaDia - Sum(NetoFinal) as dif,
    Count(NetoFinal) as cuantas,
	D.idpuntoventa
    --g.Select(x => x.NumeroCartaDePorte).ToList()

	from CartasDePorteControlDescarga D
	left join CartasDePorte C on   C.FechaDescarga = D.Fecha  AND C.Destino = d.IdDestino AND  C.SubnumeroDeFacturacion <= 0 AND D.idPuntoVenta=C.puntoVenta
	left  join WilliamsDestinos DEST on C.Destino=DEST.IdWilliamsDestino
	group by d.IdCartasDePorteControlDescarga, DEST.Descripcion, c.FechaDescarga, d.TotalDescargaDia ,D.idpuntoventa
                      
end
go






exec wCartasDePorteControlDescargas_TX_InformeControlDiario '','',3

/*
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [dbo].[CartasDePorte] ([SubnumeroDeFacturacion])
INCLUDE ([NetoFinal],[Destino],[FechaDescarga])
GO
*/