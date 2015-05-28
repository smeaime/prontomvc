CREATE TABLE [dbo].[DetalleRequerimientosLogSituacion] (
    [IdDetalleRequerimientoLogSituacion] INT         IDENTITY (1, 1) NOT NULL,
    [IdDetalleRequerimiento]             INT         NULL,
    [Situacion]                          VARCHAR (1) NULL,
    [Fecha]                              DATETIME    NULL,
    [IdUsuarioModifico]                  INT         NULL,
    [Observaciones]                      NTEXT       NULL,
    [CambioSituacion]                    VARCHAR (2) NULL,
    CONSTRAINT [PK_DetalleRequerimientosLogSituacion] PRIMARY KEY CLUSTERED ([IdDetalleRequerimientoLogSituacion] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_DetalleRequerimientosLogSituacion]
    ON [dbo].[DetalleRequerimientosLogSituacion]([IdDetalleRequerimiento] ASC, [Fecha] ASC);

