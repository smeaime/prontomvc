CREATE TABLE [dbo].[DW_DimProvincias] (
    [IdProvincia] INT          NOT NULL,
    [Provincia]   VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DW_DimProvincias] PRIMARY KEY CLUSTERED ([IdProvincia] ASC) WITH (FILLFACTOR = 90)
);

