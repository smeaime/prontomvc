CREATE TABLE [dbo].[DW_DimLocalidades] (
    [IdLocalidad] INT          NOT NULL,
    [Localidad]   VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DW_DimLocalidades] PRIMARY KEY CLUSTERED ([IdLocalidad] ASC) WITH (FILLFACTOR = 90)
);

