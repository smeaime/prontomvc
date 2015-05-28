CREATE TABLE [dbo].[ListasPrecios] (
    [IdListaPrecios]     INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]        VARCHAR (50) NULL,
    [NumeroLista]        INT          NULL,
    [FechaVigencia]      DATETIME     NULL,
    [Activa]             VARCHAR (2)  NULL,
    [IdMoneda]           INT          NULL,
    [DescripcionPrecio1] VARCHAR (20) NULL,
    [DescripcionPrecio2] VARCHAR (20) NULL,
    [DescripcionPrecio3] VARCHAR (20) NULL,
    [IdObra]             INT          NULL,
    CONSTRAINT [PK_ListasPrecios] PRIMARY KEY CLUSTERED ([IdListaPrecios] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_ListasPrecios_Monedas] FOREIGN KEY ([IdMoneda]) REFERENCES [dbo].[Monedas] ([IdMoneda])
);

