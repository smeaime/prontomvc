CREATE TABLE [dbo].[DetalleValoresProvincias] (
    [IdDetalleValorProvincias] INT            IDENTITY (1, 1) NOT NULL,
    [IdValor]                  INT            NULL,
    [IdProvincia]              INT            NULL,
    [Porcentaje]               NUMERIC (6, 2) NULL,
    CONSTRAINT [PK_DetalleValoresProvincias] PRIMARY KEY CLUSTERED ([IdDetalleValorProvincias] ASC) WITH (FILLFACTOR = 90)
);

