CREATE TABLE [dbo].[CuentasGastos] (
    [IdCuentaGasto]   INT          IDENTITY (1, 1) NOT NULL,
    [CodigoSubcuenta] INT          NULL,
    [Descripcion]     VARCHAR (50) NULL,
    [IdRubroContable] INT          NULL,
    [IdCuentaMadre]   INT          NULL,
    [Activa]          VARCHAR (2)  NULL,
    [Codigo]          VARCHAR (20) NULL,
    [CodigoDestino]   VARCHAR (10) NULL,
    [Titulo]          VARCHAR (2)  NULL,
    [Nivel]           INT          NULL,
    CONSTRAINT [PK_CuentasGastos] PRIMARY KEY CLUSTERED ([IdCuentaGasto] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[CuentasGastos]([IdCuentaMadre] ASC) WITH (FILLFACTOR = 90);

