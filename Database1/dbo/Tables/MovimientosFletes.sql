CREATE TABLE [dbo].[MovimientosFletes] (
    [IdMovimientoFlete]             INT             IDENTITY (1, 1) NOT NULL,
    [IdFlete]                       INT             NULL,
    [Fecha]                         DATETIME        NULL,
    [Tipo]                          VARCHAR (1)     NULL,
    [Touch]                         VARCHAR (5)     NULL,
    [IdDispositivoGPS]              INT             NULL,
    [IdLecturaGPS]                  INT             NULL,
    [DistanciaRecorridaKm]          NUMERIC (18, 8) NULL,
    [IdPatronGPS]                   INT             NULL,
    [ModalidadFacturacion]          TINYINT         NULL,
    [ValorUnitario]                 NUMERIC (18, 2) NULL,
    [FechaUltimaModificacionManual] DATETIME        NULL,
    [FechaLecturaArchivoMovimiento] DATETIME        NULL,
    CONSTRAINT [PK_MovimientosFletes] PRIMARY KEY CLUSTERED ([IdMovimientoFlete] ASC) WITH (FILLFACTOR = 90)
);

