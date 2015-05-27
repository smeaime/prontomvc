CREATE TABLE [dbo].[CDPEstablecimientos] (
    [IdEstablecimiento] INT           IDENTITY (1, 1) NOT NULL,
    [Descripcion]       VARCHAR (50)  NULL,
    [IdLocalidad]       INT           NULL,
    [IdTitular]         INT           NULL,
    [CUIT]              VARCHAR (13)  NULL,
    [AuxiliarString1]   VARCHAR (100) NULL,
    [AuxiliarString2]   VARCHAR (50)  NULL,
    [AuxiliarString3]   VARCHAR (50)  NULL,
    CONSTRAINT [PK__CDPEstablecimien__026413E1] PRIMARY KEY CLUSTERED ([IdEstablecimiento] ASC) WITH (FILLFACTOR = 90)
);

