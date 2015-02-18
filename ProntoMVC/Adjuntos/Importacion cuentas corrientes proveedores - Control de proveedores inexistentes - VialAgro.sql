select * 
from _TempMayoresProveedores
where not exists(Select Top 1 p.idproveedor from proveedores p where p.cuit=_TempMayoresProveedores.Cuit COLLATE SQL_Latin1_General_CP1_CI_AS)
order by tercero