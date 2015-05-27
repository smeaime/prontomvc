CREATE TABLE [dbo].[_TempCuboReservaPresupuestaria] (
    [IdTempCuboReservaPresupuestaria] INT             IDENTITY (1, 1) NOT NULL,
    [Rubro]                           VARCHAR (50)    NULL,
    [Material]                        VARCHAR (256)   NULL,
    [Obra]                            VARCHAR (50)    NULL,
    [Precio]                          NUMERIC (18, 2) NULL,
    [Cantidad]                        NUMERIC (18, 2) NULL,
    [Importe]                         NUMERIC (18, 2) NULL,
    [Subrubro]                        VARCHAR (50)    NULL,
    [RM]                              INT             NULL,
    CONSTRAINT [PK__TempCuboReservaPresupuestaria] PRIMARY KEY CLUSTERED ([IdTempCuboReservaPresupuestaria] ASC) WITH (FILLFACTOR = 90)
);

