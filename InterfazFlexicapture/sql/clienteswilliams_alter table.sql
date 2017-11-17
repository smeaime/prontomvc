--

--insertar al final, despues de Tarjeta_NumeroTarjeta 

alter table clientes  ADD
	[IncluyeTarifaEnFactura] [varchar](2) NULL,
	[SeLeFacturaCartaPorteComoTitular] [varchar](2) NULL,
	[SeLeFacturaCartaPorteComoIntermediario] [varchar](2) NULL,
	[SeLeFacturaCartaPorteComoRemcomercial] [varchar](2) NULL,
	[SeLeFacturaCartaPorteComoCorredor] [varchar](2) NULL,
	[SeLeFacturaCartaPorteComoDestinatario] [varchar](2) NULL,
	[SeLeFacturaCartaPorteComoDestinatarioExportador] [varchar](2) NULL,
	[SeLeDerivaSuFacturaAlCorredorDeLaCarta] [varchar](2) NULL,
	[HabilitadoParaCartaPorte] [varchar](2) NULL,
	[SeLeFacturaCartaPorteComoClienteAuxiliar] [varchar](2) NULL,
	[EsAcondicionadoraDeCartaPorte] [varchar](2) NULL,
	[Contactos] [varchar](150) NULL,
	[TelefonosFijosOficina] [varchar](150) NULL,
	[TelefonosCelulares] [varchar](150) NULL,
	[CorreosElectronicos] [varchar](150) NULL
	go