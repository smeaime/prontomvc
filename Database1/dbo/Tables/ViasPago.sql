CREATE TABLE [dbo].[ViasPago] (
    [IdViaPago]   INT          IDENTITY (1, 1) NOT NULL,
    [Codigo]      VARCHAR (5)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Descripcion] VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_ViasPago] PRIMARY KEY CLUSTERED ([IdViaPago] ASC) WITH (FILLFACTOR = 90)
);

