CREATE TABLE [dbo].[DW_DimPaises] (
    [IdPais] INT          NOT NULL,
    [Pais]   VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DW_DimPaises] PRIMARY KEY CLUSTERED ([IdPais] ASC) WITH (FILLFACTOR = 90)
);

