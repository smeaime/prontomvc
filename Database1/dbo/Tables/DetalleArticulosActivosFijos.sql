CREATE TABLE [dbo].[DetalleArticulosActivosFijos] (
    [IdDetalleArticuloActivosFijos]  INT             IDENTITY (1, 1) NOT NULL,
    [IdArticulo]                     INT             NULL,
    [Fecha]                          DATETIME        NULL,
    [TipoConcepto]                   VARCHAR (1)     NULL,
    [Detalle]                        VARCHAR (50)    NULL,
    [ModificacionVidaUtilImpositiva] INT             NULL,
    [ModificacionVidaUtilContable]   INT             NULL,
    [Importe]                        NUMERIC (18, 4) NULL,
    [IdRevaluo]                      INT             NULL,
    [ImporteRevaluo]                 NUMERIC (18, 4) NULL,
    [VidaUtilRevaluo]                INT             NULL,
    CONSTRAINT [PK_DetalleArticulosActivosFijos] PRIMARY KEY CLUSTERED ([IdDetalleArticuloActivosFijos] ASC) WITH (FILLFACTOR = 90)
);

