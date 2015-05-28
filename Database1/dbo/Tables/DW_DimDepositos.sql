CREATE TABLE [dbo].[DW_DimDepositos] (
    [IdDeposito]  INT          NOT NULL,
    [Descripcion] VARCHAR (50) NULL,
    CONSTRAINT [PK_DW_DimDepositos] PRIMARY KEY CLUSTERED ([IdDeposito] ASC) WITH (FILLFACTOR = 90)
);

