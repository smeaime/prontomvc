select name + ', ' as [text()] 
from sys.columns 
where object_id = object_id('cartasdeportehistorico') 
for xml path('')


insert into cartasdeportehistorico(IdCartaDePorte, NumeroCartaDePorte, IdUsuarioIngreso, FechaIngreso, Anulada, IdUsuarioAnulo, FechaAnulacion, Observaciones, Vendedor, CuentaOrden1, CuentaOrden2, Corredor, Entregador, Procedencia, Patente, IdArticulo, IdStock, Partida, IdUnidad, IdUbicacion, Cantidad, Cupo, NetoProc, Calidad, BrutoPto, TaraPto, NetoPto, Acoplado, Humedad, Merma, NetoFinal, FechaDeCarga, FechaVencimiento, CEE, IdTransportista, TransportistaCUITdesnormalizado, IdChofer, ChoferCUITdesnormalizado, CTG, Contrato, Destino, Subcontr1, Subcontr2, Contrato1, contrato2, KmARecorrer, Tarifa, FechaDescarga, Hora, NRecibo, CalidadDe, TaraFinal, BrutoFinal, Fumigada, Secada, Exporta, NobleExtranos, NobleNegros, NobleQuebrados, NobleDaniados, NobleChamico, NobleChamico2, NobleRevolcado, NobleObjetables, NobleAmohosados, NobleHectolitrico, NobleCarbon, NoblePanzaBlanca, NoblePicados, NobleMGrasa, NobleAcidezGrasa, NobleVerdes, NobleGrado, NobleConforme, NobleACamara, Cosecha, HumedadDesnormalizada, Factor, IdFacturaImputada, PuntoVenta, SubnumeroVagon, TarifaFacturada, TarifaSubcontratista1, TarifaSubcontratista2, FechaArribo, Version, MotivoAnulacion, NumeroSubfijo, IdEstablecimiento, EnumSyngentaDivision, Corredor2, IdUsuarioModifico, FechaModificacion, FechaEmision, EstaArchivada, ExcluirDeSubcontratistas, IdTipoMovimiento, IdClienteAFacturarle, SubnumeroDeFacturacion, AgregaItemDeGastosAdministrativos, CalidadGranosQuemados, CalidadGranosQuemadosBonifica_o_Rebaja, CalidadTierra, CalidadTierraBonifica_o_Rebaja, CalidadMermaChamico, CalidadMermaChamicoBonifica_o_Rebaja, CalidadMermaZarandeo, CalidadMermaZarandeoBonifica_o_Rebaja, FueraDeEstandar, CalidadPuntaSombreada)
select IdCartaDePorte, NumeroCartaDePorte, IdUsuarioIngreso, FechaIngreso, Anulada, IdUsuarioAnulo, FechaAnulacion, Observaciones, Vendedor, CuentaOrden1, CuentaOrden2, Corredor, Entregador, Procedencia, Patente, IdArticulo, IdStock, Partida, IdUnidad, IdUbicacion, Cantidad, Cupo, NetoProc, Calidad, BrutoPto, TaraPto, NetoPto, Acoplado, Humedad, Merma, NetoFinal, FechaDeCarga, FechaVencimiento, CEE, IdTransportista, TransportistaCUITdesnormalizado, IdChofer, ChoferCUITdesnormalizado, CTG, Contrato, Destino, Subcontr1, Subcontr2, Contrato1, contrato2, KmARecorrer, Tarifa, FechaDescarga, Hora, NRecibo, CalidadDe, TaraFinal, BrutoFinal, Fumigada, Secada, Exporta, NobleExtranos, NobleNegros, NobleQuebrados, NobleDaniados, NobleChamico, NobleChamico2, NobleRevolcado, NobleObjetables, NobleAmohosados, NobleHectolitrico, NobleCarbon, NoblePanzaBlanca, NoblePicados, NobleMGrasa, NobleAcidezGrasa, NobleVerdes, NobleGrado, NobleConforme, NobleACamara, Cosecha, HumedadDesnormalizada, Factor, IdFacturaImputada, PuntoVenta, SubnumeroVagon, TarifaFacturada, TarifaSubcontratista1, TarifaSubcontratista2, FechaArribo, Version, MotivoAnulacion, NumeroSubfijo, IdEstablecimiento, EnumSyngentaDivision, Corredor2, IdUsuarioModifico, FechaModificacion, FechaEmision, EstaArchivada, ExcluirDeSubcontratistas, IdTipoMovimiento, IdClienteAFacturarle, SubnumeroDeFacturacion, AgregaItemDeGastosAdministrativos, CalidadGranosQuemados, CalidadGranosQuemadosBonifica_o_Rebaja, CalidadTierra, CalidadTierraBonifica_o_Rebaja, CalidadMermaChamico, CalidadMermaChamicoBonifica_o_Rebaja, CalidadMermaZarandeo, CalidadMermaZarandeoBonifica_o_Rebaja, FueraDeEstandar, CalidadPuntaSombreada
/*
idcartadeporte,numerocartadeporte, subnumerovagon, numerosubfijo
,subnumerodefacturacion,idclienteAfacturarle,
anulada,motivoanulacion ,fechaanulacion,idFacturaimputada,fechaingreso, * 
*/
from cartasdeporte 
where 
--numerocartadeporte=22557089 and 
--fechaingreso > '20120417'
(subnumerodefacturacion<0 or anulada='SI' )
and idfacturaimputada<=0

and numerocartadeporte in
(
select numerocartadeporte
--,numerocartadeporte, subnumerovagon , count (*)
from cartasdeporte 
--where fechaanulacion is null
--and fechaingreso > '20120417' 
group by numerocartadeporte, subnumerovagon
having count(*)>1
) 
order by numerocartadeporte
go



delete cartasdeporte where IdCartaDePorte in (select IdCartaDePorte from cartasdeportehistorico)







select 
idcartadeporte,numerocartadeporte, subnumerovagon, subnumerodefacturacion,idclienteAfacturarle,
anulada,motivoanulacion ,fechaanulacion,idFacturaimputada,fechaingreso, * 

from cartasdeporte 
where 1=1
--numerocartadeporte=22557089 and 
--fechaingreso > '20120417'

--(subnumerodefacturacion<0 or anulada='SI' )
--and idfacturaimputada<=0

and numerocartadeporte in
(
select numerocartadeporte
--,numerocartadeporte, subnumerovagon , count (*)
from cartasdeporte 
--where fechaanulacion is null
--and fechaingreso > '20120417' 
group by numerocartadeporte, subnumerovagon
having count(*)>1
)
order by numerocartadeporte,subnumerovagon,SubnumeroDeFacturacion











select top 100 idcartadeporte,numerocartadeporte, subnumerovagon, numerosubfijo
,subnumerodefacturacion,idclienteAfacturarle,
anulada,motivoanulacion ,idFacturaimputada,fechaingreso, * 
from cartasdeporte 
order by idcartadeporte desc




select  *
from log 
where IdComprobante=134596 or IdComprobante=133840
--where IdComprobante=131956 or IdComprobante=133921
order by fecharegistro


select numerocartadeporte
,subnumerovagon , count (*)
from cartasdeporte 
--where fechaingreso > '20120417'
--where isnull(anulada,'NO') <> 'SI'
group by numerocartadeporte, subnumerovagon
having count(*)>1
order by count(*) desc





SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where table_name='CartasDePorte'


SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE where table_name='CartasDePorteHistorico'

--wCartasDePorte_TX_PorNumero 524313414,null


select top 100 * from log order by fecharegistro desc


