CREATE TABLE [dbo].[CentrosCosto] (
    [IdCentroCosto] INT          IDENTITY (1, 1) NOT NULL,
    [Codigo]        VARCHAR (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Descripcion]   VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_CentrosCosto] PRIMARY KEY CLUSTERED ([IdCentroCosto] ASC) WITH (FILLFACTOR = 90)
);

