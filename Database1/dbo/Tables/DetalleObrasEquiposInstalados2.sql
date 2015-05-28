CREATE TABLE [dbo].[DetalleObrasEquiposInstalados2] (
    [IdDetalleObraEquipoInstalado2] INT      IDENTITY (1, 1) NOT NULL,
    [IdDetalleObraEquipoInstalado]  INT      NULL,
    [IdObra]                        INT      NULL,
    [IdArticulo]                    INT      NULL,
    [FechaInstalacion]              DATETIME NULL,
    [FechaDesinstalacion]           DATETIME NULL,
    [Observaciones]                 NTEXT    NULL,
    CONSTRAINT [PK_DetalleObrasEquiposInstalados2] PRIMARY KEY CLUSTERED ([IdDetalleObraEquipoInstalado2] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleObrasEquiposInstalados2_Obras] FOREIGN KEY ([IdObra]) REFERENCES [dbo].[Obras] ([IdObra])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleObrasEquiposInstalados2]([IdDetalleObraEquipoInstalado] ASC) WITH (FILLFACTOR = 90);

