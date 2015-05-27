CREATE TABLE [dbo].[DW_DimDescripcionIva] (
    [IdCodigoIva] TINYINT      NOT NULL,
    [Condicion]   VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DW_DimDescripcionIva] PRIMARY KEY CLUSTERED ([IdCodigoIva] ASC) WITH (FILLFACTOR = 90)
);

