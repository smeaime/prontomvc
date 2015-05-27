
CREATE Procedure [dbo].[BZ_Pesadas_M]

	@IdPesada  int,
	@NumeroPesada int,

	@IdUsuarioIngreso int ,
	@FechaIngreso datetime ,
	@Anulada varchar(2) ,
	@IdUsuarioAnulo int ,
	@FechaAnulacion datetime ,
	@Observaciones varchar(200) ,

	@IdArticulo int  ,
	@IdStock int ,
	@Partida varchar(20),
	@IdUnidad int,
	@IdUbicacion int ,
	@Cantidad numeric(12,2) ,

	@PesoBruto numeric(18,2) ,
	@PesoNeto numeric(18,2) ,
	@Tara numeric(18,2) ,

	@Chofer int , --id?
	@TxtChofer varchar(30) , --mientras no haya id
	@IdCamion int , -- id?
	@TxtCamion varchar(30) ,	

	@IdTransportista int , --id? Sí, el pronto tiene tabla de transportistas
	@IdProveedor int ,
	@IdCliente int ,
	@IdObra int ,

	@RemitoMaterial int ,
	@RemitoTransportista int ,

	@CantidadEnOrigen numeric(12,2), 	
	@PesoBrutoIngresadoManualmente varchar(2),
	@TaraIngresadaManualmente varchar(2),
	@IdDetallePedido int
AS 

UPDATE [BZ_Pesadas]
SET

	NumeroPesada=@NumeroPesada ,

	IdUsuarioIngreso=@IdUsuarioIngreso  ,
	FechaIngreso=@FechaIngreso  ,
	Anulada=@Anulada  ,
	IdUsuarioAnulo=@IdUsuarioAnulo  ,
	FechaAnulacion=@FechaAnulacion  ,
	Observaciones=@Observaciones  ,

	IdArticulo=@IdArticulo   ,
	IdStock=@IdStock  ,
	Partida=@Partida ,
	IdUnidad=@IdUnidad ,
	IdUbicacion=@IdUbicacion  ,
	Cantidad=@Cantidad  ,

	PesoBruto=@PesoBruto  ,
	PesoNeto=@PesoNeto  ,
	Tara=@Tara  ,

	Chofer=@Chofer  , 
	TxtChofer=@TxtChofer  ,
	IdCamion=@IdCamion ,
	TxtCamion=@TxtCamion  ,	

	IdTransportista=@IdTransportista  , 
	IdProveedor=@IdProveedor  ,
	IdCliente=@IdCliente  ,
	IdObra=@IdObra  ,

	RemitoMaterial=@RemitoMaterial  ,
	RemitoTransportista=@RemitoTransportista ,

	CantidadEnOrigen=@CantidadEnOrigen, 	
	PesoBrutoIngresadoManualmente=@PesoBrutoIngresadoManualmente,
	TaraIngresadaManualmente=@TaraIngresadaManualmente,
	IdDetallePedido=@IdDetallePedido
WHERE (IdPesada=@IdPesada)

RETURN(@IdPesada)
