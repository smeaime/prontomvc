CREATE TABLE [dbo].[ArticulosInformacionAdicional] (
    [IdArticuloInformacionAdicional] INT             IDENTITY (1, 1) NOT NULL,
    [IdArticulo]                     INT             NULL,
    [Campo]                          VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CampoItem]                      VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ValorCampoChar]                 VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ValorCampoNum]                  DECIMAL (18, 2) NULL,
    CONSTRAINT [PK_ArticulosInformacionAdicional] PRIMARY KEY CLUSTERED ([IdArticuloInformacionAdicional] ASC) WITH (FILLFACTOR = 90)
);

