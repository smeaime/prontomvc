﻿






















CREATE Procedure [dbo].[DetProveedoresIB_E]
@IdDetalleProveedorIB int  AS 
Delete DetalleProveedoresIB
Where (IdDetalleProveedorIB=@IdDetalleProveedorIB)























