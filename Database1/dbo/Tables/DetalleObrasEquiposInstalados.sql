CREATE TABLE [dbo].[DetalleObrasEquiposInstalados] (
    [IdDetalleObraEquipoInstalado] INT             IDENTITY (1, 1) NOT NULL,
    [IdObra]                       INT             NULL,
    [IdArticulo]                   INT             NULL,
    [Cantidad]                     NUMERIC (18, 2) NULL,
    [FechaInstalacion]             DATETIME        NULL,
    [FechaDesinstalacion]          DATETIME        NULL,
    [Observaciones]                NTEXT           NULL,
    CONSTRAINT [PK_DetalleObrasEquiposInstalados] PRIMARY KEY CLUSTERED ([IdDetalleObraEquipoInstalado] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleObrasEquiposInstalados_Obras] FOREIGN KEY ([IdObra]) REFERENCES [dbo].[Obras] ([IdObra])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleObrasEquiposInstalados]([IdArticulo] ASC) WITH (FILLFACTOR = 90);

